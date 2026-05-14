#!/bin/bash

# termux-manager.sh - Main Manager Script
export BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Termux Manager ==="
echo "Base Directory: $BASE_DIR"

# Check for scripts
if [ ! -d "$BASE_DIR/scripts" ]; then
    echo "Error: scripts directory not found."
    exit 1
fi

# Function to run a script
run_script() {
    local script_path="$1"
    if [ -f "$script_path" ]; then
        echo "Running: $(basename "$script_path")..."
        chmod +x "$script_path"
        bash "$script_path"
    else
        echo "Warning: Script not found - $script_path"
    fi
}

# Main Execution Flow
echo "Starting system initialization..."
run_script "$BASE_DIR/scripts/system-init.sh"

echo "Starting core packages installation..."
run_script "$BASE_DIR/scripts/install/core-packages.sh"

echo "Starting gemini-cli installation..."
run_script "$BASE_DIR/scripts/install/gemini-cli.sh"

echo "Starting special apps installation (GIMP, etc.)..."
run_script "$BASE_DIR/scripts/install/special-apps.sh"

echo "=== Setup Process Finished ==="

# Cleanup question
read -p "Do you want to keep the setup scripts directory (~/.termux-setup-env)? [Y/n] " choice
case "$choice" in
  [nN][oO]|[nN])
    echo "Cleaning up..."
    rm -rf "$BASE_DIR"
    echo "Cleanup complete."
    ;;
  *)
    echo "Setup scripts kept at $BASE_DIR"
    ;;
esac
