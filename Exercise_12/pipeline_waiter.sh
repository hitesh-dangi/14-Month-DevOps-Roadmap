#!/bin/bash

# Defining the wait_time
Wait_Time=5  # represents 5 seconds

# While Loop (Check the condition greater than 0)
while [ "$Wait_Time" -gt 0 ]; do
	echo "Waiting for database to initialize.... $Wait_Time seconds remaining."
	sleep 1
	((Wait_Time--))
done
echo "Database ready! Starting application deployed."
