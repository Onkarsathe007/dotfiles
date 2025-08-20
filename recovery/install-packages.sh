#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES_FILE="$SCRIPT_DIR/packages-official.txt"

echo "📦 Installing official packages..."

if [[ ! -f "$PACKAGES_FILE" ]]; then
    echo "❌ Package list not found: $PACKAGES_FILE"
    exit 1
fi

echo "📋 Package list: $PACKAGES_FILE"
echo "📊 Total packages: $(wc -l < "$PACKAGES_FILE")"

echo "🔄 Updating package database..."
sudo pacman -Sy

echo "🔄 Installing packages..."
sudo pacman -S --needed --noconfirm $(cat "$PACKAGES_FILE")

echo "✅ Official packages installed successfully!"