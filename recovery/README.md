# System Recovery Scripts

This directory contains scripts to completely recover your Arch Linux system setup after a fresh installation.

## 🚀 Quick Recovery

For a complete system recovery, run:

```bash
cd ~/dotfiles/recovery
./install.sh
```

## 📁 Files Overview

| File | Description |
|------|-------------|
| `install.sh` | Main recovery script (interactive) |
| `install-packages.sh` | Install official repository packages |
| `install-aur.sh` | Install AUR packages using yay |
| `install-languages.sh` | Install language managers (Node, Rust, etc.) |
| `setup-symlinks.sh` | Create dotfiles symlinks |
| `packages-official.txt` | List of official packages |
| `packages-aur.txt` | List of AUR packages |
| `versions.txt` | Language tool versions |

## 🔧 Manual Recovery Steps

If you prefer to run steps individually:

### 1. Base System Setup
```bash
# Ensure git and base-devel are installed
sudo pacman -S git base-devel

# Clone your dotfiles
git clone https://github.com/onkarsathe007/dotfiles
cd ~/dotfiles/recovery
```

### 2. Install Packages
```bash
./install-packages.sh    # Official packages
./install-aur.sh         # AUR packages  
```

### 3. Install Language Tools
```bash
./install-languages.sh   # Node, Rust, PNPM, Zinit
```

### 4. Setup Dotfiles
```bash
./setup-symlinks.sh      # Create symlinks
```

## ⚠️ Prerequisites

- Fresh Arch Linux installation
- Internet connection
- sudo privileges

## 📝 Manual Tasks After Recovery

These items need manual attention:

### SSH Keys
```bash
# Copy your SSH keys to ~/.ssh/
# Set proper permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/*.pub
```

### Browser Data
- Import bookmarks
- Restore extensions
- Login to accounts

### Additional Configs
- Import fonts to `~/.local/share/fonts/`
- Restore application-specific settings
- Configure monitors/displays

## 🔄 Updating Package Lists

To update the package lists with your current system:

```bash
cd ~/dotfiles/recovery

# Update package lists
pacman -Qqe | grep -v "$(pacman -Qqm)" > packages-official.txt
pacman -Qqm > packages-aur.txt

# Update tool versions
node --version > versions.txt 2>/dev/null || echo "node: not found" > versions.txt
echo "nvm: $(nvm --version 2>/dev/null || echo 'not found')" >> versions.txt
echo "rust: $(rustc --version 2>/dev/null || echo 'not found')" >> versions.txt
echo "pnpm: $(pnpm --version 2>/dev/null || echo 'not found')" >> versions.txt
```

## 🎯 Recovery Time Estimate

- **Base packages**: ~10 minutes
- **AUR packages**: ~15 minutes  
- **Language tools**: ~5 minutes
- **Dotfiles setup**: ~2 minutes
- **Total**: ~30 minutes

## 🆘 Troubleshooting

### Package Installation Fails
```bash
# Update keyring
sudo pacman -S archlinux-keyring

# Clear package cache
sudo pacman -Scc
```

### AUR Helper Issues
```bash
# Reinstall yay manually
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
```

### Missing Dependencies
```bash
# Install base development tools
sudo pacman -S base-devel git curl wget
```
