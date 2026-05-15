#!/bin/bash

# scripts/system-init.sh - System Initialization & Storage Setup

echo "--- System Initialization ---"

# 1. Storage Setup
echo "Requesting storage access..."
termux-setup-storage

# Handle symbolic links
echo "Configuring storage symbolic links..."
echo "1) Keep default links (music, shared, downloads, etc.)"
echo "2) Create direct link to Android Storage (/storage/emulated/0)"
echo "3) Remove default links and do nothing"
read -p "Choose an option [1-3]: " storage_choice

STORAGE_DIR="$HOME/storage"

case "$storage_choice" in
    2)
        echo "Creating direct link to Android Storage..."
        # Wait for storage directory to be created by termux-setup-storage
        sleep 2
        if [ -d "$STORAGE_DIR" ]; then
            rm -rf "$STORAGE_DIR"
        fi
        ln -s /storage/emulated/0 "$HOME/android-storage"
        echo "Link created at ~/android-storage"
        ;;
    3)
        echo "Removing default links..."
        sleep 2
        rm -rf "$STORAGE_DIR"
        ;;
    *)
        echo "Keeping default links."
        ;;
esac

# 2. Termux Properties (Korean Input)
echo "Configuring Termux properties for Korean input..."
PROPERTIES_FILE="$HOME/.termux/termux.properties"
mkdir -p "$(dirname "$PROPERTIES_FILE")"

if [ -f "$PROPERTIES_FILE" ] && grep -q "enforce-char-based-input" "$PROPERTIES_FILE"; then
    sed -i 's/^#* *enforce-char-based-input.*/enforce-char-based-input = true/' "$PROPERTIES_FILE"
else
    echo "enforce-char-based-input = true" >> "$PROPERTIES_FILE"
fi

termux-reload-settings
echo "Korean input setting applied."
