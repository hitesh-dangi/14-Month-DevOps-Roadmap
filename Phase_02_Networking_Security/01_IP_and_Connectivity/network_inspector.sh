#!/usr/bin/env bash

# ==========================================
# Phase 2 : Networking and Security
# ==========================================

set -euo pipefail

echo "========================================"
echo " 🌐 SysOps Network Inspector"
echo "========================================"

# 1. Grabs the system's hostname
echo "[*] Hostname: $(hostname)"
echo ""

# 2. Extract active IPv4 addresses using 'ip' command and 'awk'
echo "[*] Local Network Interfaces & IPs:"
ip -4 addr show | grep inet | awk '{print "    -> " $NF ": " $2}'
echo ""

# 3. Test Outbound Internet Connectivity (Ping Google's Public DNS)
echo "[*] Testing Outbound Internet Connectivity..."

# We ping 8.8.8.8 exactly 3 times (-c 3).
# > /dev/null hides the messy output to just get the clean result.
if ping -c 3 8.8.8.8 > /dev/null 2>&1; then
    echo "    ✅ Outbound connection: SUCCESS (Can reach 8.8.8.8)"
else
    echo "    ❌ Outbound connection: FAILED (Check firewall or router)"
fi

echo "========================================"
