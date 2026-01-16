package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"strings"
	"time"
)

const (
	cacheFile     = "/tmp/copilot-usage-cache.json"
	cacheDuration = 5 * time.Minute
	icon          = ""
	clientID      = "Iv1.b507a08c87ecfe98"
	deviceCodeURL = "https://github.com/login/device/code"
	tokenURL      = "https://github.com/login/oauth/access_token"
)

type WaybarOutput struct {
	Text    string `json:"text"`
	Class   string `json:"class"`
	Tooltip string `json:"tooltip"`
}

type HostsConfig struct {
	GitHub struct {
		OAuthToken string `json:"oauth_token"`
		User       string `json:"user"`
	} `json:"github.com"`
}

type CopilotResponse struct {
	QuotaSnapshots struct {
		PremiumInteractions struct {
			PercentRemaining float64 `json:"percent_remaining"`
			Remaining        int     `json:"remaining"`
			Entitlement      int     `json:"entitlement"`
			Unlimited        bool    `json:"unlimited"`
		} `json:"premium_interactions"`
		Chat struct {
			Unlimited bool `json:"unlimited"`
		} `json:"chat"`
	} `json:"quota_snapshots"`
	CopilotPlan    string `json:"copilot_plan"`
	QuotaResetDate string `json:"quota_reset_date"`
}

type DeviceCodeResponse struct {
	DeviceCode      string `json:"device_code"`
	UserCode        string `json:"user_code"`
	VerificationURI string `json:"verification_uri"`
	ExpiresIn       int    `json:"expires_in"`
	Interval        int    `json:"interval"`
}

type TokenResponse struct {
	AccessToken string `json:"access_token"`
	TokenType   string `json:"token_type"`
	Scope       string `json:"scope"`
	Error       string `json:"error"`
}

type UserResponse struct {
	Login string `json:"login"`
}

func outputJSON(text, class, tooltip string) {
	out := WaybarOutput{
		Text:    text,
		Class:   class,
		Tooltip: tooltip,
	}
	json.NewEncoder(os.Stdout).Encode(out)
}

func getConfigPath() string {
	home, _ := os.UserHomeDir()
	return filepath.Join(home, ".config", "github-copilot", "hosts.json")
}

func getToken() (string, error) {
	data, err := os.ReadFile(getConfigPath())
	if err != nil {
		return "", err
	}

	var config HostsConfig
	if err := json.Unmarshal(data, &config); err != nil {
		return "", err
	}

	return config.GitHub.OAuthToken, nil
}

func saveToken(token, username string) error {
	configPath := getConfigPath()
	configDir := filepath.Dir(configPath)

	if err := os.MkdirAll(configDir, 0755); err != nil {
		return err
	}

	config := HostsConfig{}
	config.GitHub.OAuthToken = token
	config.GitHub.User = username

	data, err := json.MarshalIndent(config, "", "  ")
	if err != nil {
		return err
	}

	return os.WriteFile(configPath, data, 0600)
}

func getCachedData() (*CopilotResponse, bool) {
	info, err := os.Stat(cacheFile)
	if err != nil {
		return nil, false
	}

	if time.Since(info.ModTime()) > cacheDuration {
		return nil, false
	}

	data, err := os.ReadFile(cacheFile)
	if err != nil {
		return nil, false
	}

	var resp CopilotResponse
	if err := json.Unmarshal(data, &resp); err != nil {
		return nil, false
	}

	return &resp, true
}

func fetchData(token string) (*CopilotResponse, error) {
	client := &http.Client{Timeout: 10 * time.Second}
	req, err := http.NewRequest("GET", "https://api.github.com/copilot_internal/user", nil)
	if err != nil {
		return nil, err
	}

	req.Header.Set("Authorization", "token "+token)
	req.Header.Set("Accept", "application/json")
	req.Header.Set("User-Agent", "GitHubCopilotChat/0.26.7")

	resp, err := client.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		return nil, fmt.Errorf("API returned %d", resp.StatusCode)
	}

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	os.WriteFile(cacheFile, body, 0644)

	var copilotResp CopilotResponse
	if err := json.Unmarshal(body, &copilotResp); err != nil {
		return nil, err
	}

	return &copilotResp, nil
}

func openBrowser(url string) {
	var cmd *exec.Cmd
	switch runtime.GOOS {
	case "linux":
		cmd = exec.Command("xdg-open", url)
	case "darwin":
		cmd = exec.Command("open", url)
	case "windows":
		cmd = exec.Command("rundll32", "url.dll,FileProtocolHandler", url)
	default:
		fmt.Printf("Please open this URL manually: %s\n", url)
		return
	}
	cmd.Start()
}

func requestDeviceCode() (*DeviceCodeResponse, error) {
	client := &http.Client{Timeout: 10 * time.Second}

	data := fmt.Sprintf("client_id=%s&scope=read:user", clientID)
	req, err := http.NewRequest("POST", deviceCodeURL, strings.NewReader(data))
	if err != nil {
		return nil, err
	}

	req.Header.Set("Accept", "application/json")
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")

	resp, err := client.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	var deviceResp DeviceCodeResponse
	if err := json.Unmarshal(body, &deviceResp); err != nil {
		return nil, err
	}

	return &deviceResp, nil
}

func pollForToken(deviceCode string, interval int) (string, error) {
	client := &http.Client{Timeout: 10 * time.Second}

	for {
		time.Sleep(time.Duration(interval) * time.Second)

		data := fmt.Sprintf("client_id=%s&device_code=%s&grant_type=urn:ietf:params:oauth:grant-type:device_code",
			clientID, deviceCode)

		req, err := http.NewRequest("POST", tokenURL, strings.NewReader(data))
		if err != nil {
			return "", err
		}

		req.Header.Set("Accept", "application/json")
		req.Header.Set("Content-Type", "application/x-www-form-urlencoded")

		resp, err := client.Do(req)
		if err != nil {
			continue
		}

		body, err := io.ReadAll(resp.Body)
		resp.Body.Close()
		if err != nil {
			continue
		}

		var tokenResp TokenResponse
		if err := json.Unmarshal(body, &tokenResp); err != nil {
			continue
		}

		if tokenResp.Error == "authorization_pending" {
			continue
		}

		if tokenResp.Error == "slow_down" {
			interval += 5
			continue
		}

		if tokenResp.Error != "" {
			return "", fmt.Errorf("authorization failed: %s", tokenResp.Error)
		}

		if tokenResp.AccessToken != "" {
			return tokenResp.AccessToken, nil
		}
	}
}

func getUsername(token string) (string, error) {
	client := &http.Client{Timeout: 10 * time.Second}
	req, err := http.NewRequest("GET", "https://api.github.com/user", nil)
	if err != nil {
		return "", err
	}

	req.Header.Set("Authorization", "token "+token)
	req.Header.Set("Accept", "application/json")

	resp, err := client.Do(req)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	var user UserResponse
	if err := json.Unmarshal(body, &user); err != nil {
		return "", err
	}

	return user.Login, nil
}

func login() error {
	fmt.Println("🚀 Starting GitHub Copilot authentication...")
	fmt.Println()

	deviceResp, err := requestDeviceCode()
	if err != nil {
		return fmt.Errorf("failed to request device code: %w", err)
	}

	fmt.Printf("📋 Your code: \033[1;36m%s\033[0m\n", deviceResp.UserCode)
	fmt.Printf("🌐 Opening browser to: %s\n", deviceResp.VerificationURI)
	fmt.Println()
	fmt.Println("Please authorize the application in your browser...")
	fmt.Println()

	openBrowser(deviceResp.VerificationURI)

	fmt.Print("Press Enter after you've authorized the app...")
	bufio.NewReader(os.Stdin).ReadBytes('\n')

	fmt.Println("\n⏳ Waiting for authorization...")

	token, err := pollForToken(deviceResp.DeviceCode, deviceResp.Interval)
	if err != nil {
		return fmt.Errorf("failed to get token: %w", err)
	}

	fmt.Println("✅ Authorization successful!")
	fmt.Println("🔍 Getting user information...")

	username, err := getUsername(token)
	if err != nil {
		return fmt.Errorf("failed to get username: %w", err)
	}

	if err := saveToken(token, username); err != nil {
		return fmt.Errorf("failed to save token: %w", err)
	}

	fmt.Printf("\n🎉 Successfully authenticated as: \033[1;32m%s\033[0m\n", username)
	fmt.Printf("💾 Configuration saved to: %s\n", getConfigPath())

	return nil
}

func refresh() error {
	// Remove cache file to force refresh
	if err := os.Remove(cacheFile); err != nil && !os.IsNotExist(err) {
		return fmt.Errorf("failed to remove cache: %w", err)
	}

	// Send signal to waybar to update
	cmd := exec.Command("pkill", "-SIGRTMIN+8", "waybar")
	if err := cmd.Run(); err != nil {
		// Ignore error if waybar is not running or signal fails
		return nil
	}

	return nil
}

func showUsage() {
	token, err := getToken()
	if err != nil {
		outputJSON(icon+" AUTH", "error", "Not authenticated\nRun: waybar-copilot login")
		return
	}

	data, ok := getCachedData()
	if !ok {
		data, err = fetchData(token)
		if err != nil {
			outputJSON(icon+" ERR", "error", "Failed to fetch data: "+err.Error())
			return
		}
	}

	used := int(100 - data.QuotaSnapshots.PremiumInteractions.PercentRemaining)

	class := "normal"
	if !data.QuotaSnapshots.PremiumInteractions.Unlimited {
		if used >= 90 {
			class = "critical"
		} else if used >= 75 {
			class = "warning"
		}
	}

	text := fmt.Sprintf("%s %d%%", icon, used)
	if data.QuotaSnapshots.PremiumInteractions.Unlimited {
		text = icon + " ∞"
	}

	tooltip := "<b>GitHub Copilot Usage</b>\n\n"

	if data.QuotaSnapshots.PremiumInteractions.Unlimited {
		tooltip += "<b>Premium:</b> Unlimited\n\n"
	} else {
		tooltip += fmt.Sprintf("<b>Premium:</b>\n  Used: %d%% (%d/%d remaining)\n\n",
			used,
			data.QuotaSnapshots.PremiumInteractions.Remaining,
			data.QuotaSnapshots.PremiumInteractions.Entitlement)
	}

	if data.QuotaSnapshots.Chat.Unlimited {
		tooltip += "<b>Chat:</b> Unlimited\n\n"
	}

	tooltip += fmt.Sprintf("<b>Plan:</b> %s\n<b>Resets:</b> %s",
		data.CopilotPlan,
		data.QuotaResetDate)

	outputJSON(text, class, tooltip)
}

func printHelp() {
	fmt.Println("GitHub Copilot Usage for Waybar")
	fmt.Println()
	fmt.Println("Usage:")
	fmt.Println("  waybar-copilot           Show usage (default, for Waybar)")
	fmt.Println("  waybar-copilot login     Authenticate with GitHub")
	fmt.Println("  waybar-copilot refresh   Clear cache and refresh Waybar")
	fmt.Println("  waybar-copilot help      Show this help message")
}

func main() {
	if len(os.Args) > 1 {
		switch os.Args[1] {
		case "login":
			if err := login(); err != nil {
				fmt.Fprintf(os.Stderr, "❌ Error: %v\n", err)
				os.Exit(1)
			}
			return
		case "refresh":
			if err := refresh(); err != nil {
				fmt.Fprintf(os.Stderr, "❌ Error: %v\n", err)
				os.Exit(1)
			}
			fmt.Println("✅ Cache cleared and Waybar refreshed")
			return
		case "help", "-h", "--help":
			printHelp()
			return
		default:
			fmt.Fprintf(os.Stderr, "Unknown command: %s\n", os.Args[1])
			printHelp()
			os.Exit(1)
		}
	}

	showUsage()
}
