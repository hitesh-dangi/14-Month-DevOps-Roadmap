#!/bin/bash

# 1. Root Check

if [ "$EUID" -ne 0 ]; then
	echo "[ERROR] Access Denied. Medic must be run as root." | tee -a /tmp/medic_test/medic_run.log
	exit 1
fi


# 2. Disk Cleanup

echo "[INFO] Connecting to Janitor protocol...." | tee -a /tmp/medic_test/medic_run.log

find /tmp/medic_test/logs/ -type f -mtime +7 -delete

echo "[SUCCESS] Obsolete logs removed." | tee -a /tmp/medic_test/medic_run.log


# 3. Log Parsing
# scaning a file for a specific word, count the lines, and storting that number in a variable

echo "[INFO] Scanning for system anomalies...." | tee -a /tmp/medic_test/medic_run.log
# Command subsitution $(...) runs the command and saves the output to the variable
CRITICAL_COUNT=$(grep -c "CRITICAL" /tmp/medic_test/sys_error.log)
echo "[ALERT] Discovered $CRITICAL_COUNT critical errors requiring attention." | tee -a /tmp/medic_test/medic_run.log


# 4. Process Termination
# Hunting down the frozen script by its exact file name using pkill and force-drop it with the -9 flag

echo "[INFO] Hunting rogue processes...." | tee -a /tmp/medic_test/medic_run.log
# -f tells the pkill to at the full command line name, not just the process name
pkill -9 -f "rogue_process.sh"
echo "[SUCCESS] rogue process neutralized. Server Medic shutdown complete." | tee -a /tmp/medic_test/medic_run.log
