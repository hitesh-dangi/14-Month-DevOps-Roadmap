#!/usr/bin/env bash

# ==========================================
# Topic 03: Ports & Sockets Inspector
# ==========================================

set -euo pipefail

echo "========================================"
echo "     Port & Socket Inspector"
echo "========================================"

echo "[*] Active Local Listening Ports (TCP & UDP):"
# -t = TCP, -u = UDP, -l = listening, -n = numeric (don't resolve names)
ss -tuln | awk 'NR==1 || /LISTEN/' 

echo ""
echo "[*] Remote Port Scanner"
read -p "Enter a target domain or IP (e.g., google.com): " TARGET
read -p "Enter a port to check (e.g., 443 for HTTPS, 22 for SSH): " PORT

if [ -z "$TARGET" ] || [ -z "$PORT" ]; then
    echo "[!] Error: Target and Port cannot be empty."
    exit 1
fi

echo ""
echo "[*] Scanning $TARGET on port $PORT..."

if nc -zv -w 2 "$TARGET" "$PORT" 2>&1 | grep -q "succeeded\|Connected\|open"; then
    echo " SUCCESS: Port $PORT on $TARGET is OPEN."
else
    echo " FAILED: Port $PORT on $TARGET is CLOSED or blocked."
fi

echo "========================================"
