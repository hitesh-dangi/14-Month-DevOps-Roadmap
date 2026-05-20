#!/bin/bash

# Defining the array
Log_Files=("web.log" "database.log" "system.log")

# Defining the destination directory
Archive_Dir="/tmp/archive"
	mkdir -p /tmp/archive

# Moving the file using for loop
for file in "${Log_Files[@]}"; do
	echo "Moving the file $file to the destination ($Archive_Dir)"
	mv "$file" "$Archive_Dir/"
done
echo "All files moved successfully"
