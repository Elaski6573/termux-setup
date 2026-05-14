#!/bin/bash

# scripts/install/gemini-cli.sh - Gemini CLI Installation

echo "--- Installing Gemini CLI ---"

# 1. Install Node.js
echo "Installing nodejs-lts..."
pkg install -y nodejs-lts

# 2. Set GYP_DEFINES for installation
export GYP_DEFINES="android_ndk_path=/data/data/com.termux/files/usr/share/ndk"

# 3. Install gemini-cli
echo "Installing @google/gemini-cli..."
npm install -g @google/gemini-cli

# 4. Verify installation and persist environment variable
if npm list -g --depth=0 | grep -q "@google/gemini-cli"; then
    echo "Gemini CLI installed successfully."
    
    BASHRC_FILE="$HOME/.bashrc"
    GYP_ENV_LINE='export GYP_DEFINES="android_ndk_path=/data/data/com.termux/files/usr/share/ndk"'
    
    if [ -f "$BASHRC_FILE" ] && grep -q "GYP_DEFINES" "$BASHRC_FILE"; then
        echo "GYP_DEFINES already exists in .bashrc"
    else
        echo "" >> "$BASHRC_FILE"
        echo "# gyp error fix for gemini-cli" >> "$BASHRC_FILE"
        echo "$GYP_ENV_LINE" >> "$BASHRC_FILE"
        echo "GYP_DEFINES added to .bashrc for persistence."
    fi
else
    echo "Error: Gemini CLI installation failed."
fi
