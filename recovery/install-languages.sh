#!/bin/bash

set -e

echo "🛠️  Installing language managers and tools..."

install_nvm() {
    if [[ ! -d "$HOME/.nvm" ]]; then
        echo "📥 Installing NVM..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        echo "✅ NVM installed"
        
        echo "📥 Installing Node.js LTS..."
        nvm install --lts
        nvm use --lts
        echo "✅ Node.js installed"
    else
        echo "ℹ️  NVM already installed"
    fi
}

install_rust() {
    if ! command -v rustc &> /dev/null; then
        echo "📥 Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
        echo "✅ Rust installed"
    else
        echo "ℹ️  Rust already installed"
    fi
}

install_pnpm() {
    if ! command -v pnpm &> /dev/null; then
        echo "📥 Installing PNPM..."
        curl -fsSL https://get.pnpm.io/install.sh | sh
        echo "✅ PNPM installed"
    else
        echo "ℹ️  PNPM already installed"
    fi
}

install_zinit() {
    if [[ ! -d "$HOME/.local/share/zinit" ]]; then
        echo "📥 Installing Zinit (Zsh plugin manager)..."
        bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
        echo "✅ Zinit installed"
    else
        echo "ℹ️  Zinit already installed"
    fi
}

echo "🔄 Installing language managers..."

install_nvm
install_rust
install_pnpm
install_zinit

echo "✅ All language managers installed successfully!"
echo "📝 Note: You may need to restart your shell or source your .zshrc/.bashrc"