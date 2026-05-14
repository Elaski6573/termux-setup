#!/bin/bash

# scripts/install/core-packages.sh - Core Utilities and Dev Tools

echo "--- Installing Core Packages ---"

# 1. Basic Utilities
echo "Installing basic utilities (vim, wget)..."
pkg install -y vim wget

# 2. Development Tools
echo "Would you like to install development tools?"
echo "(git, gh, python, clang)"
read -p "Install dev tools? [Y/n] " dev_choice

case "$dev_choice" in
    [nN][oO]|[nN])
        echo "Skipping development tools installation."
        ;;
    *)
        echo "Installing development tools..."
        pkg install -y git gh python clang
        ;;
esac

echo "Core packages installation process finished."
