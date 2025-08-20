#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AUR_PACKAGES_FILE="$SCRIPT_DIR/packages-aur.txt"

echo "🏗️  Installing AUR packages..."

if [[ ! -f "$AUR_PACKAGES_FILE" ]]; then
    echo "❌ AUR package list not found: $AUR_PACKAGES_FILE"
    exit 1
fi

if ! command -v yay &> /dev/null; then
    echo "📥 Installing yay AUR helper..."
    
    temp_dir=$(mktemp -d)
    cd "$temp_dir"
    
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    
    cd "$HOME"
    rm -rf "$temp_dir"
    
    echo "✅ yay installed successfully!"
fi

echo "📋 AUR package list: $AUR_PACKAGES_FILE"
echo "📊 Total AUR packages: $(wc -l < "$AUR_PACKAGES_FILE")"

if [[ -s "$AUR_PACKAGES_FILE" ]]; then
    echo "🔄 Installing AUR packages..."
    yay -S --needed --noconfirm $(cat "$AUR_PACKAGES_FILE")
    echo "✅ AUR packages installed successfully!"
else
    echo "ℹ️  No AUR packages to install"
fi