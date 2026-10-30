#!/usr/bin/env bash
# ==============================================================================
# Script Name: process_hunter.sh
# Description: Audits memory usage, top CPU/RAM processes, and unlinked open files.
# Author: Hitesh Dangi
# ==============================================================================

set -euo pipefail

echo "=== [1] System Memory Utilization (free -m) ==="
free -m

echo -e "\n=== [2] Top 5 CPU-Consuming Processes ==="
ps aux --sort=-%cpu | head -n 6

echo -e "\n=== [3] Top 5 Memory-Consuming Processes ==="
ps aux --sort=-%mem | head -n 6

echo -e "\n=== [4] Checking for Deleted Files Still Held Open by Processes (lsof +L1) ==="
sudo lsof +L1 2>/dev/null | head -n 10 || echo "[OK] No unlinked open files consuming phantom disk space."
