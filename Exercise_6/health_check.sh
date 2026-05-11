#!/bin/bash

# If -Elif Condition

# 1. Asking the user for sever status code
echo "Enter Server Status Code: "
read StatusCode

# 2. Using the conditions
if [ "$StatusCode" -eq 200 ]; then
	echo "System Healthy: All systems go!"
elif [ "$StatusCode" -eq 404 ]; then
	echo "Warning: Page not found. Check the configuration."
elif [ "$StatusCode" -eq 500 ]; then
	echo "Critical error: Server is down! Call the admin."
else
	echo "Unknown status: Proceed with caution."
fi
