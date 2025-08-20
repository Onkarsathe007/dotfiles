#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RECOVERY_DIR="$DOTFILES_DIR/recovery"

echo "🚀 Starting system recovery..."
echo "📁 Dotfiles directory: $DOTFILES_DIR"
echo "📦 Recovery directory: $RECOVERY_DIR"

confirm() {
    read -p "$1 (y/N): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

run_script() {
    local script="$1"
    local description="$2"
    
    if [[ -f "$RECOVERY_DIR/$script" ]]; then
        echo "🔄 $description..."
        bash "$RECOVERY_DIR/$script"
        echo "✅ $description completed"
    else
        echo "⚠️  Script $script not found, skipping"
    fi
}

echo "📋 Recovery Steps:"
echo "  1. Install base packages"
echo "  2. Install AUR packages" 
echo "  3. Install language managers"
echo "  4. Setup dotfiles symlinks"
echo

if confirm "Start recovery process?"; then
    
    if confirm "Install official packages?"; then
        run_script "install-packages.sh" "Installing official packages"
    fi
    
    if confirm "Install AUR packages?"; then
        run_script "install-aur.sh" "Installing AUR packages"
    fi
    
    if confirm "Install language managers (Node, Rust, etc.)?"; then
        run_script "install-languages.sh" "Installing language managers"
    fi
    
    if confirm "Setup dotfiles symlinks?"; then
        run_script "setup-symlinks.sh" "Setting up dotfiles symlinks"
    fi
    
    echo
    echo "🎉 Recovery process completed!"
    echo "📝 Next steps:"
    echo "   - Reboot or logout/login"
    echo "   - Restore SSH keys manually"
    echo "   - Import browser bookmarks"
    echo "   - Configure any remaining applications"
    
else
    echo "❌ Recovery cancelled"
fi