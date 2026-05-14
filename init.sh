#!/bin/bash

# init.sh - Remote Bootstrap Script for termux-setup
# This script is intended to be run via:
# curl -fsSL https://raw.githubusercontent.com/Elaski6573/termux-setup/main/init.sh | bash

SETUP_DIR="$HOME/.termux-setup-env"
REPO_URL="https://github.com/Elaski6573/termux-setup.git"

echo "=== Termux Setup Bootstrapper ==="

# 1. Install Git (Pre-requisite for cloning)
echo "Installing Git..."
apt update && apt upgrade -y
apt install -y git

# 2. Prepare Setup Directory
if [ -d "$SETUP_DIR" ]; then
    echo "Updating existing setup directory..."
    cd "$SETUP_DIR" || exit 1
    # Check if it's a git repo
    if [ -d ".git" ]; then
        git pull
    else
        cd "$HOME" || exit 1
        rm -rf "$SETUP_DIR"
        git clone "$REPO_URL" "$SETUP_DIR"
    fi
else
    echo "Cloning setup repository..."
    git clone "$REPO_URL" "$SETUP_DIR"
fi

# 3. Execution
cd "$SETUP_DIR" || exit 1
chmod +x termux-manager.sh

echo "Starting Termux Manager..."
./termux-manager.sh
