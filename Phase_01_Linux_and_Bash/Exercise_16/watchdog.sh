#!/bin/bash

set -e


# ----- EXTRACTING THE PID IN THE VARIABLE -----
# Pipe the ps -> grep -> awk all inside the $() command subsitution
# Using "|| true" so that if greps find nothing, it doesn't crash the script due to set -e.
PID=$(ps aux | grep "[r]ogue_worker" | awk '{print $2}' || true)

# ----- DEFENSIVE CHECK - VARIABLE EMPTY OR NOT -----
if [ -z "$PID" ]; then
	echo "No rogue_worker process found running."
	exit 0
fi


# ----- FORCEFULLY TERMINATING THAT PID -----
echo "Target found: PID $PID. Initiating termination....."
sleep 2
kill -9 "$PID"

echo "Success! Rogue Worker process with PID $PID has been terminated."
exit 0
