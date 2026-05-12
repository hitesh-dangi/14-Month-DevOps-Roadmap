#!/bin/bash

# Taking multiple items and storing in array
echo "Enter the name of the directories you want to move(Use spaces for separation):"
read -a Dir_to_move

# Asking for the destination directory
echo "Enter the destination directory:"
read Dest_dir

# Checking if destination exists, build it if it dosen't
if [ ! -d "$Dest_dir" ]; then
	echo "Destination $Dest_dir not exists. creating it now...."
	mkdir -p "$Dest_dir"
fi

echo "Moving the files"

# Using For loop for moving one by one
for dir in "${Dir_to_move[@]}"; do
	# Safety check, if the directory exists
	if [ -d "$dir" ]; then
		echo "Moving $dir -> $Dest_dir "
		mv "$dir" "$Dest_dir/"
	else
		echo "Directory $dir not found. Skipping..."
	fi
done
