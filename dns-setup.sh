#!/bin/bash

# Function to display help message
show_help() {
    echo "Usage: $0 [OPTION] <dns_name>"
    echo "Set DNS servers for Wi-Fi interface."
    echo
    echo "Options:"
    echo "  -h, --help    Display this help message and exit"
    echo
    echo "Available DNS options:"
    for dns in "${dnses[@]}"; do
        KEY="${dns%%:*}"
        echo "  $KEY"
    done
    echo
    echo "Example: $0 electro"
}

# DNS options
dnses=( "empty:empty"
        "electro:78.157.42.101 78.157.42.100"
        "403:10.202.10.202 10.202.10.102"
)

# Check for help option
if [[ "$1" == "--help" || "$1" == "-h" ]]; then
    show_help
    exit 0
fi

# Check if an argument is provided
if [ $# -eq 0 ]; then
    read -p "Enter DNS name: " name
else
    name=$1
fi

for dns in "${dnses[@]}"; do
    KEY="${dns%%:*}"
    VALUE="${dns##*:}"
    if [ "$name" == "$KEY" ]; then
        networksetup -setdnsservers Wi-Fi $VALUE
        echo "DNS set to $name"
        exit 0
    fi
done

echo "Invalid DNS name. Use '$0 --help' to see available options."
exit 1