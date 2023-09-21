#!/bin/bash

# Specify the directory to search for files
directory="/var/log/"

# Use the 'find' command to search for regular files and their sizes
files=$(find "$directory" -type f -exec du -ah {} + | sort -rh)

# Loop through the files and display the top 10 files
counter=1
echo "Top 10 Files:"
echo "-------------------------"
while IFS= read -r line; do
    if [ $counter -le 10 ]; then
        file=$(echo "$line" | awk '{print $2}')
        size=$(echo "$line" | awk '{print $1}')
        type=$(file -a "$file")
        echo "$counter - $file, $size, $type"
        counter=$((counter+1))
    else
        break
    fi
done <<< "$files"