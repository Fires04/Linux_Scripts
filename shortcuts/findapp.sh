#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 program_name - finds file in PATH folders"
  exit 1
fi

program_name="$1"

# Split the $PATH variable into an array of directories
IFS=':' read -ra path_dirs <<< "$PATH"

# Loop through each directory in $PATH and check if the program exists
found=0
for dir in "${path_dirs[@]}"; do
  # Use the 'find' command to search for the program
  if find "$dir" -type f -name "*$program_name*" 2>/dev/null; then
    found=1
  fi
done

if [ $found -eq 0 ]; then
  echo "Program '$program_name' not found in any directories in \$PATH."
else
  echo "Program '$program_name' found in the following directories in \$PATH:"
  for dir in "${path_dirs[@]}"; do
    find "$dir" -type f -name "*$program_name*" 2>/dev/null
  done
fi