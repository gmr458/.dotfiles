#!/bin/bash

# Check if a file path is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file>"
    exit 1
fi

file="$1"

# Check if the file exists
if [ ! -f "$file" ]; then
    echo "File $file not found"
    exit 1
fi

# Toggle between "dark" and "light"
sed -i 's/dark/TEMP_STRING/g;s/light/dark/g;s/TEMP_STRING/light/g' "$file"
