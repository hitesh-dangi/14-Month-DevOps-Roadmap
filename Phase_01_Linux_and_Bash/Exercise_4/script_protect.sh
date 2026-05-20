#!/bin/bash

# 1. Asking user the secret keyword
echo "Enter the secret keyword: "
read Key

# 2. Checking the secret keyword
if [ "$Key" == "Cloud2026" ]; then
	echo "Access Granted. Initializing system..."
else
	echo "Access Denied. Incident reported."
fi
