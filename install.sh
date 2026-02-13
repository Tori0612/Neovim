#!/bin/bash

NVIM_CONFIG="$HOME/.config/nvim"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing Neovim configuration..."

if [ "$SCRIPT_DIR" = "$NVIM_CONFIG" ]; then
    echo "Already installed at $NVIM_CONFIG"
    exit 0
fi

if [ -d "$NVIM_CONFIG" ]; then
    echo "Existing Neovim config found at $NVIM_CONFIG"
    read -p "Do you want to backup and replace it? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        BACKUP_DIR="$NVIM_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backing up to $BACKUP_DIR"
        mv "$NVIM_CONFIG" "$BACKUP_DIR"
    else
        echo "Installation canceled."
        exit 0
    fi
fi

echo "Moving configuration to $NVIM_CONFIG..."
mkdir -p "$(dirname "$NVIM_CONFIG")"
mv "$SCRIPT_DIR" "$NVIM_CONFIG"

if [ $? -eq 0 ]; then
    echo "✅ Installation complete!"
    echo "Run 'nvim' to start and install plugins"
else
    echo "❌ Instalation failed"
    exit 1
fi
