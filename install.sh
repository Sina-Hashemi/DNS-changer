#!/bin/bash

# DNS Manager Installer

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "This script requires root privileges. Please run with sudo."
    exit 1
fi

# Define installation paths
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/usr/local/etc"
COMPLETION_DIR="/usr/local/etc/bash_completion.d"

# Create directories if they don't exist
mkdir -p "$INSTALL_DIR" "$CONFIG_DIR" "$COMPLETION_DIR"

# Install main script
echo "Installing DNS Manager main script..."
cp dns-setup.sh "$INSTALL_DIR/setdns"
chmod +x "$INSTALL_DIR/setdns"

# Install configuration file
echo "Installing DNS configuration file..."
cp dns_settings.txt "$CONFIG_DIR/dns_settings.txt"

# Install completion script
echo "Installing bash completion script..."
cp dns-completions.sh "$COMPLETION_DIR/setdns"
chmod +x "$COMPLETION_DIR/setdns"

# Set up completion for current session
source "$COMPLETION_DIR/setdns"

# Update bash profile to source the completion script
BASH_PROFILE="$HOME/.bash_profile"
if [ ! -f "$BASH_PROFILE" ]; then
    BASH_PROFILE="$HOME/.profile"
fi

if ! grep -q "source $COMPLETION_DIR/setdns" "$BASH_PROFILE"; then
    echo "# DNS Manager completion" >> "$BASH_PROFILE"
    echo "source $COMPLETION_DIR/setdns" >> "$BASH_PROFILE"
    echo "Added completion script to $BASH_PROFILE"
fi

echo "Installation complete!"
echo "Please restart your terminal or run 'source $BASH_PROFILE' to enable completion."
echo "You can now use 'sudo setdns <dns_name>' to change your DNS settings."