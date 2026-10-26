#!/usr/bin/env bash
# ==============================================================================
# Script Name: disk_inode_guard.sh
# Description: Audits root filesystem disk space, inode usage, and large logs.
# Author: Hitesh Dangi
# ==============================================================================

set -euo pipefail

THRESHOLD=80

echo "=== [1] Block Storage Usage (df -h /) ==="
df -h /

echo -e "\n=== [2] Inode Metadata Usage (df -i /) ==="
df -i /

DISK_USAGE=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')
INODE_USAGE=$(df -i / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo -e "\n=== [3] Threshold Health Check (Limit: ${THRESHOLD}%) ==="
if [[ "$DISK_USAGE" -ge "$THRESHOLD" ]] || [[ "$INODE_USAGE" -ge "$THRESHOLD" ]]; then
    echo "[CRITICAL] Storage alert! Disk: ${DISK_USAGE}%, Inodes: ${INODE_USAGE}%"
else
    echo "[OK] Storage healthy. Disk: ${DISK_USAGE}%, Inodes: ${INODE_USAGE}%"
fi

echo -e "\n=== [4] Top 5 Largest Directories in /var/log ==="
sudo du -sh /var/log/* 2>/dev/null | sort -hr | head -n 5
