#!/usr/bin/env bash
# ==============================================================================
# Script Name: dns_tcp_diag.sh
# Description: Diagnoses ICMP routing, DNS resolution, and TCP port connectivity.
# Author: Hitesh Dangi
# ==============================================================================

set -euo pipefail

TARGET_DOMAIN="${1:-google.com}"
TARGET_PORT="${2:-443}"

echo "=== [1] Checking Local DNS Resolver (/etc/resolv.conf) ==="
grep "^nameserver" /etc/resolv.conf || echo "No nameserver found!"

echo -e "\n=== [2] Testing Outbound IP Routing (Ping 8.8.8.8) ==="
ping -c 2 8.8.8.8 > /dev/null && echo "[OK] Outbound IP connectivity is healthy." || echo "[FAIL] Network routing unreachable!"

echo -e "\n=== [3] Testing DNS Resolution for $TARGET_DOMAIN ==="
RESOLVED_IP=$(dig +short "$TARGET_DOMAIN" | head -n 1)
if [[ -n "$RESOLVED_IP" ]]; then
    echo "[OK] $TARGET_DOMAIN resolved to IPv4: $RESOLVED_IP"
else
    echo "[FAIL] DNS resolution failed for $TARGET_DOMAIN!"
    exit 1
fi

echo -e "\n=== [4] Testing TCP 3-Way Handshake on $TARGET_DOMAIN:$TARGET_PORT ==="
if timeout 3 bash -c "</dev/tcp/$TARGET_DOMAIN/$TARGET_PORT" 2>/dev/null; then
    echo "[OK] TCP Port $TARGET_PORT on $TARGET_DOMAIN is OPEN (Handshake Established)."
else
    echo "[FAIL] TCP Port $TARGET_PORT on $TARGET_DOMAIN is BLOCKED or CLOSED."
fi
