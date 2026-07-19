#!/bin/bash
set -e

# =====================================================================
# AUTOMATED DISK JANITOR
# Scheduled via Cron to run daily at 2:00 AM
# CRON COMMAND: 0 2 * * * /home/hitesh/14-Month-DevOps-Roadmap/Phase_01_Linux_and_Bash/Disk_Janitor/disk_janitor.sh
# =====================================================================

echo "=================================================="
echo "🚀 DISK CLEANUP STARTED: $(date)"
echo "=================================================="

# ----- TASK 1: LOG ROTATION -----
echo "[*] Purging log files older than 14 days from /var/log..."
# Removing -delete for safe GitHub portfolio display. In production, append -delete
find /var/log -name "*.log" -mtime +14 

# ----- TASK 2: TEMP FILE PURGE -----
echo "[*] Purging temporary cache files larger than 100MB from /tmp..."
# Removing -delete for safe GitHub portfolio display. In production, append -delete
find /tmp -name "*.tmp" -size +100M 

echo "=================================================="
echo "✔ DISK CLEANUP COMPLETE: $(date)"
echo "=================================================="
exit 0
