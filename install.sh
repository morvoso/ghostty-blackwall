#!/bin/bash

# Ghostty Blackwall Shader Installer
# This script configures Ghostty to use the blackwall.glsl shader.

set -e

SHADER_NAME="blackwall.glsl"
SHADER_PATH="$(pwd)/$SHADER_NAME"
CONFIG_DIR="$HOME/.config/ghostty"
CONFIG_FILE="$CONFIG_DIR/config"

# Check if shader file exists in current directory
if [ ! -f "$SHADER_NAME" ]; then
    echo "Error: $SHADER_NAME not found in the current directory."
    exit 1
fi

echo "Configuring Ghostty Blackwall Shader..."

# Ensure config directory exists
mkdir -p "$CONFIG_DIR"

# Create config file if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
    touch "$CONFIG_FILE"
    echo "Created new Ghostty config at $CONFIG_FILE"
fi

# Backup the config before modifying
cp "$CONFIG_FILE" "${CONFIG_FILE}.bak"
echo "Backup created at ${CONFIG_FILE}.bak"

# Check if custom-shader is already defined
if grep -q "^custom-shader =" "$CONFIG_FILE"; then
    echo "Updating existing custom-shader entry..."
    # Comment out old entry and add new one to be safe, or just replace?
    # Replacing is cleaner for a "reliable" script.
    sed -i "s|^custom-shader =.*|custom-shader = $SHADER_PATH|" "$CONFIG_FILE"
else
    echo "Adding new custom-shader entry..."
    {
        echo ""
        echo "# Ghostty Blackwall Shader"
        echo "custom-shader = $SHADER_PATH"
    } >> "$CONFIG_FILE"
fi

echo "--------------------------------------------------"
echo "Success! Ghostty is now configured to use:"
echo "  $SHADER_PATH"
echo ""
echo "Please restart Ghostty or reload your configuration to see the changes."
echo "--------------------------------------------------"
