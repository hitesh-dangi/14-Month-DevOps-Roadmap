#!/bin/bash

set -e


# ==========================================
# Bootcamp Day 1: Automated Workspace Builder
# ==========================================


# 1. Defining Variables
Base_Dir="./project_alpha"
Backup_Dir="$Base_Dir/backups"
Log_Dir="$Base_Dir/logs"

echo "Starting Workspace Build......."


# 2. Checking if base directory already exists
if [ -d "$Base_Dir" ]; then
	echo "Warning: $Base_Dir already exists. Skipping base creation."
else
	echo "Creating new base directory: $Base_Dir"
	mkdir "$Base_Dir"
fi

# 3. Building the sub-directories
echo "Generating the sub-directories....."
mkdir -p "$Backup_Dir"
mkdir -p "$Log_Dir"
touch "$Log_Dir/build_log.txt"


echo "Workspace Built Successfully!"
echo "-----------------------------"



# 4. Proving it worked by listing the directory structure
ls -R "$Base_Dir"
