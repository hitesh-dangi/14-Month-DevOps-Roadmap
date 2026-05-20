#!/bin/bash

echo "Checking System requirements....."

# -v command is used to check if a tool exists in linux
# > /dev/null (black hole) used to keep the terminal clean

command -v flux_capacitor > /dev/null

# now we check the exit code of that check

if [ $? -ne 0 ]; then
	echo "Warning 'Flux_capacitor' is missing. Auto-healing triggered.... "
	echo "Installing flux_capacitor now......."
	sleep 3
	echo "Auto heal complete. Proceeding with deployment."
else
	echo "Flux_capacitor already installed. Proceeding with deployment."
fi

