<h1 align="center">🧠 Onkar's Dotfiles</h1>
<p align="center">
  <img src="https://img.shields.io/badge/Linux-MX-blue?logo=linux&style=for-the-badge" />
  <img src="https://img.shields.io/badge/i3wm-config-orange?logo=i3&style=for-the-badge" />
  <img src="https://img.shields.io/badge/Neovim-lua%20based-green?logo=neovim&style=for-the-badge" />
  <img src="https://img.shields.io/badge/Terminal-Alacritty%20%7C%20Kitty-yellow?logo=gnometerminal&style=for-the-badge" />
</p>

---

## 🖼️ Screenshot:

> 📸 Here's a preview of my setup:

<p align="center">
  <img src="screenshot.png" alt="screenshot" width="720"/>
</p>

## Features:

- Configured **i3** tiling window manager with keybindings and workspace control
- **i3blocks** with custom shell scripts (time, volume, power menu, etc.)
- **Neovim** setup with LSP, Treesitter, Lazy.nvim, statusline, and plugins
- **Alacritty** and **Kitty** with custom themes
- **Picom** compositor for blur and transparency effects
- **Dunst** notifications with a clean, readable theme
- **Rofi** for application launching
- **Polybar** (optional) for modular and customizable status bar
- Scripts and tools under `.local/bin` for system automation

---

## Folder Structure:

```bash
.
├── .bashrc
├── .gitconfig
├── .tmux.conf
├── .zshrc
├── .zsh_functions
├── .local/bin/
├── .config/
│   ├── alacritty/
│   ├── kitty/
│   ├── dunst/
│   ├── i3/
│   ├── i3blocks/
│   ├── nvim/
│   ├── picom/
│   ├── polybar/
│   └── rofi/
```

## Installation:
Make sure stow is installed on your system.

```
git clone https://github.com/onkarsathe007/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow .
```
This will symlink all relevant configuration files to your $HOME directory.

## Credits:

Inspired by: ThePrimeagen, ChrisTitusTech, ArchWiki
Themes: Catppuccin, Aura Theme


>“Keep it simple. Make it yours.” — Onkar

