#!/bin/bash

# 1. Heading
echo "---------- Devops Log Management ----------"

# 2. Asking the user for the current month (used for directory name)
echo "Enter the current month (eg. May 2026): "
read Month_Name

# 3. Creating directory and empty log files
# Creating Directory
echo "Creating Directory........"
mkdir "logs_$Month_Name"
# Creating empty log files
echo "Creating default project files... "
touch "logs_$Month_Name"/web_server.log
touch "logs_$Month_Name"/database.log
touch "logs_$Month_Name"/error.log

# showing the contents of the folder using ls command
echo "Directory created successfully! Here is what is inside your new workspace: "
ls -l "logs_$Month_Name"
echo "==========================================="
