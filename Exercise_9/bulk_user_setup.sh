#!/bin/bash

# Defining the array
Users=("Alice" "Bob" "Jack")

# for loop
for user in "${Users[@]}"; do
	echo "Provising workspace for $user"
	mkdir -p /tmp/workspace/"$user"
	echo "Workspace successfully created for User $user!"
done
echo "Workspace successfully created for all the Users."
