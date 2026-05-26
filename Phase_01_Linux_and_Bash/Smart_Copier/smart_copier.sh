#!/bin/bash
set -e

echo "Enter the name of the file: "
read File_Name

echo "Searching for $File_Name (this might take a second)..."
sleep 1

# 1. Capturing the path into a variable.
# 2. Redirecting errors to /dev/null so the screen stays clean.
# 3. Use 'head -n 1' to only grab the very first match.

FOUND_PATH=$(find /home -name "$File_Name" 2>/dev/null | head -n 1)

# -n checks if the variable is NOT empty (meaning we found something)
if [ -n "$FOUND_PATH" ]; then
    echo " File found at: $FOUND_PATH"
	echo "Enter the Destination to copy the file: "
	read Dest_dir

    if [ ! -d "$Dest_dir" ]; then
		echo "Destination directory does not exist. Creating it now..."
        # Creating the directory!
        mkdir -p "$Dest_dir"
		sleep 1
		echo "Destination directory created successfully."
	fi

    echo "Copying to $Dest_dir..."

# Using the absolute found path, adding the $, and a trailing slash for safety
	cp "$FOUND_PATH" "$Dest_dir/"
	sleep 1
    echo "Copy complete."

else
	echo " File $File_Name not found."
	exit 1
fi
