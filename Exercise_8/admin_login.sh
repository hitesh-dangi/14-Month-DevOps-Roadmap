#!/bin/bash

# 1. Asking for the details
echo "Enter Username:"
read UserName
echo "Enter Security Level(1-10):"
read Level

# 2. Converting Username to lowerCase
UserName=${UserName,,}

# 3. Checking for admin
if [[ "$UserName" == "admin" && "$Level" -gt 7 ]]; then
	echo "Full access granted."
elif [[ "$UserName" == "admin" && ("$Level" -ge 1 && "$Level" -le 7) ]]; then
	echo "Limited admin access."
else
	echo "Access denied."
fi
