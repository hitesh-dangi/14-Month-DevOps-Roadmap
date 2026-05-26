#!/bin/bash

echo "Enter Name of the directory you want to create (Please do no use spaces): "
read Dir_Name

echo "Checking....."
if [ -d "$Dir_Name" ]; then
	echo "Directory already exists!"
	echo "Skipping to avoid overwriting"
	exit 1
else
	echo "Directory does not exists"
	echo "Creating Directory $Dir_Name ........ "
	mkdir "$Dir_Name"
	echo "Directory created successfully!...."
fi
