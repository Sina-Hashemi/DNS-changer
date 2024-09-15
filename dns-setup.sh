#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    read -p "Enter DNS name: " name
else
    name=$1
fi


dnses=( "empty:empty"
        "electro:78.157.42.101 78.157.42.100"
        "403:10.202.10.202 10.202.10.102"
)

for dns in "${dnses[@]}"; do
    KEY="${dns%%:*}"
    VALUE="${dns##*:}"
    if [ "$name" == "$KEY" ]; then
        networksetup -setdnsservers Wi-Fi $VALUE
        echo "DNS set to $name"
        exit 0
    fi
done

echo "Invalid DNS name. Available options:"
for dns in "${dnses[@]}"; do
    KEY="${dns%%:*}"
    echo "$KEY"
done
exit 1