#!/bin/bash

# 1. Asking the user for the config file name to check
echo "Enter the name of the config file to check: "
read File

# 2. Checking for the file
if [ -e "$File" ]; then
	echo "Config found. Server is ready to start."
else
	touch "$File"
	echo "Config missing. Empty file created for you."
fi
