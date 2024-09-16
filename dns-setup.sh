#!/bin/bash

# Path to the text configuration file
CONFIG_FILE="/usr/local/etc/dns_settings.txt"

# Function to display help message
show_help() {
    echo "Usage: $0 [OPTION] <dns_name>"
    echo "Set DNS servers for Wi-Fi interface."
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message and exit"
    echo
    echo "Available DNS options:"
    awk '{print $1}' "$CONFIG_FILE"
    echo
    echo "Example: $0 electro"
}

# Check for help option
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Check if an argument is provided
if [ $# -eq 0 ]; then
    read -p "Enter DNS name: " name
fi

name=$1

# Read DNS settings from text file and set DNS
if dns_servers=$(awk -v name="$name" '$1 == name {$1=""; print $0}' "$CONFIG_FILE"); then
    if [ -n "$dns_servers" ]; then
        networksetup -setdnsservers Wi-Fi $dns_servers
        echo "DNS set to $name"
        exit 0
    fi
fi

echo "Invalid DNS name. Use '$0 --help' to see available options."
exit 1