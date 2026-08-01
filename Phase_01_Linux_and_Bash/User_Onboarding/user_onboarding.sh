#!/bin/bash

set -e



# ------ Asking the new user name ------
echo "Enter new user name: "
read UserName



# ----- Creation of user accound and its home directory -----
sudo useradd -m "$UserName"



# ----- Asking and creating a dedicated group for their department -----
read -p "Enter your department name:" Depart
Depart=${Depart,,}

# Checking the group already exists or not 
if getent group "$Depart" > /dev/null 2>&1; then
	echo "Adding user to its Department group....."

# Adding the user
sudo gpasswd -a "$UserName" "$Depart"


else
	read -p "Group for the department not exists, do you want to create it (y or n) : " Decision
	Decision=${Decision,,}

	#Checking for the decision
	if [ "$Decision" == "y" ]; then
		echo "Creating group for the department....."
		sudo groupadd "$Depart"
		echo "Your group for the department created successfully!, adding user to the group......"
		sudo gpasswd -a "$UserName" "$Depart"
		echo "User "$UserName" successfully added to the group "$Depart"!"
	elif [ "$Decision" == "n" ];
		echo "Exiting......."
	else
		echo "Invalid input. Please use y or n"
	fi
fi
