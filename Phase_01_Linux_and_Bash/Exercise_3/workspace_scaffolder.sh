#!/bin/bash

# 1. Asking details from the user
echo "Enter Main Project Name: "
read ProjectName

# 2. Creating main directory
echo "Checking........"
if [ -d "$ProjectName" ]; then
	echo "Project already exists!"
	echo "Take another name"
else
	echo "Creating directory '$ProjectName'"
	mkdir -p "$ProjectName"/notes
	mkdir -p "$ProjectName"/scripts
	touch "$ProjectName"/notes/todo.txt
	echo "Workspace for [$ProjectName] is ready for use!"
fi
