#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🔗 Setting up dotfiles symlinks..."
echo "📁 Dotfiles directory: $DOTFILES_DIR"

create_symlink() {
    local source="$1"
    local target="$2"
    
    if [[ -L "$target" ]]; then
        echo "ℹ️  Symlink already exists: $target"
        return
    fi
    
    if [[ -e "$target" ]]; then
        echo "📦 Backing up existing file: $target -> $target.backup"
        mv "$target" "$target.backup"
    fi
    
    mkdir -p "$(dirname "$target")"
    ln -s "$source" "$target"
    echo "✅ Created symlink: $target -> $source"
}

echo "🔄 Creating symlinks for core dotfiles..."

create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/.zsh_functions" "$HOME/.zsh_functions"

if [[ -f "$DOTFILES_DIR/.luarc.json" ]]; then
    create_symlink "$DOTFILES_DIR/.luarc.json" "$HOME/.luarc.json"
fi

echo "🔄 Creating symlinks for .config directories..."

if [[ -d "$DOTFILES_DIR/.config/alacritty" ]]; then
    create_symlink "$DOTFILES_DIR/.config/alacritty" "$HOME/.config/alacritty"
fi

if [[ -d "$DOTFILES_DIR/.config/nvim" ]]; then
    create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
fi

if [[ -d "$DOTFILES_DIR/.config/btop" ]]; then
    create_symlink "$DOTFILES_DIR/.config/btop" "$HOME/.config/btop"
fi

echo "✅ Dotfiles symlinks created successfully!"
echo "📝 Note: Some applications may need to be restarted to pick up new configs"