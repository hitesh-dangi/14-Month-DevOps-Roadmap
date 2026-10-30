#!/usr/bin/env bash
# ==============================================================================
# Script Name: service_watchdog.sh
# Description: Checks critical daemon status, auto-restarts if down, lists sockets.
# Author: Hitesh Dangi
# ==============================================================================

set -euo pipefail

SERVICE="${1:-cron}"

echo "=== [1] Checking Service Status: $SERVICE ==="
if systemctl is-active --quiet "$SERVICE"; then
    echo "[OK] Service '$SERVICE' is active and running."
else
    echo "[WARN] Service '$SERVICE' is DOWN! Attempting auto-restart..."
    sudo systemctl start "$SERVICE"
    systemctl is-active --quiet "$SERVICE" && echo "[RECOVERED] '$SERVICE' restarted successfully."
fi

echo -e "\n=== [2] Active Listening TCP/UDP Sockets (ss -tulnp) ==="
sudo ss -tulnp
