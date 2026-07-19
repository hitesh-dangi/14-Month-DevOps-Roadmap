#!/bin/bash
set -e

# ==========================================
# File & Directory Creation Utility
# ==========================================

echo "What do you want to create? (Press 'f' for file, 'd' for directory): "
read TYPE
TYPE=${TYPE,,}

# ------------------------------------------
# TYPE: FILE
# ------------------------------------------
if [ "$TYPE" == "f" ]; then
	echo "Enter the file name you want to create (with extension): "
	read FILE_NAME
	echo "Enter the destination directory: "
	read DEST_DIR

	# --- Input Sanitization ---
	DEST_DIR="${DEST_DIR/#\~/$HOME}"
	if [[ "$DEST_DIR" != /* ]]; then
		DEST_DIR="/$DEST_DIR"
		echo "[*] Notice: Formatted path to absolute root -> $DEST_DIR"
		sleep 1
	fi

	# --- Directory Creation Check ---
	if [ ! -d "$DEST_DIR" ]; then
		echo "[!] Destination Directory does not exist. Do you want to create it? (y/n): "
		read DECISION
		if [ "${DECISION,,}" == "y" ]; then
			echo "Creating destination directory..."
			mkdir -p "$DEST_DIR"
		else
			echo "Operation cancelled."
			exit 0
		fi
	fi

	# --- File Creation Check ---
	if [ -e "$DEST_DIR/$FILE_NAME" ]; then
		echo "[!] File already exists. Do you want to replace it? (y/n): "
		read DECISION
		if [ "${DECISION,,}" == "y" ]; then
			echo "Replacing file..."
			rm -f "$DEST_DIR/$FILE_NAME"
		else
			echo "Operation cancelled."
			exit 0
		fi
	fi

	# Create the file
	echo "Creating file..."
	touch "$DEST_DIR/$FILE_NAME"
	echo "File created successfully at: $DEST_DIR/$FILE_NAME"

# ------------------------------------------
# TYPE: DIRECTORY (Handles Single & Nested)
# ------------------------------------------
elif [ "$TYPE" == "d" ]; then
	echo "Enter the directory name (Use slashes for nested, e.g., folder/subfolder): "
	read DIR_NAME
	echo "Enter the destination root path: "
	read DEST_DIR

	# --- Input Sanitization ---
	DEST_DIR="${DEST_DIR/#\~/$HOME}"
	if [[ "$DEST_DIR" != /* ]]; then
		DEST_DIR="/$DEST_DIR"
		echo "[*] Notice: Formatted path to absolute root -> $DEST_DIR"
		sleep 1
	fi

	# --- Existence Check & Creation ---
	FULL_PATH="$DEST_DIR/$DIR_NAME"

	if [ -d "$FULL_PATH" ]; then
		echo "[!] Directory already exists. Do you want to replace it? (y/n): "
		read DECISION
		if [ "${DECISION,,}" == "y" ]; then
			echo "Replacing directory..."
			rm -rf "$FULL_PATH"
		else
			echo "Operation cancelled."
			exit 0
		fi
	fi

	echo "Creating directory structure..."
	mkdir -p "$FULL_PATH"
	echo "[✔] Directory created successfully at: $FULL_PATH"

# ------------------------------------------
# INVALID INPUT
# ------------------------------------------
else
	echo "[!] Invalid input! Please enter 'f' or 'd'."
	exit 1
fi
