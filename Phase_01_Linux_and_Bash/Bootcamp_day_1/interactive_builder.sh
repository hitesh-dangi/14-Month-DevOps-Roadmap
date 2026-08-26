#!/bin/bash

# ===========================================
# Advaned Day 1: Interactive Environment Setup
# ===========================================


echo "Infrastructure Generator"
echo "------------------------"


# 1. Taking input from the user
read -p "Enter environment type (dev or prod ): " ENV_TYPE
read -p "Enter project name: " PROJ_NAME

# Converting the environment type input to lower case
ENV_TYPE=${ENV_TYPE,,}


# 2. Building dynamic file path
TARGET_DIR="./$ENV_TYPE/$PROJ_NAME"



# 3. Checking if it exists
if [ -d "$TARGET_DIR" ]; then
	echo "Error: the environment $TARGET_DIR already exists!"
else
	# 4. Creating the directory
	mkdir -p "$TARGET_DIR"

	# 5. Core bash logic: String comparission
	CONFIG_FILE="$TARGET_DIR/settings.conf"

	if [ "$ENV_TYPE" == "prod" ]; then
		echo "STRICT_SECURTIY=ON" > "$CONFIG_FILE"
		echo "DEBUG_MODE=OFF" >> "$CONFIG_FILE"
		echo "Production configuration applied."

	elif [ "$ENV_TYPE" == "dev" ]; then
		echo "STRICT_SECURITY=OFF" > "$CONFIG_FILE"
		echo "DEBUG_MODE=ON" >> "$CONFIG_FILE"
		echo "Development configuration applied."

	else
		echo "Unknown Environment type. Blank configuration file created."
		touch "$CONFIG_FILE"
	fi
fi

echo "Environment setup completed!"
