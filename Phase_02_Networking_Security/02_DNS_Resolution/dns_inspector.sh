#!/usr/bin/env bash

# ==========================================
# Topic 02: DNS Resolution Inspector
# ==========================================

set -euo pipefail

echo "========================================"
echo " 🔍 DNS Record Inspector"
echo "========================================"

# 1. Capturing target domain
read -p "Enter a domain to inspect (e.g., google.com): " TARGET_DOMAIN

# Defensive check: Ensuring the user didn't just hit Enter
if [ -z "$TARGET_DOMAIN" ]; then
    echo "[!] Error: Target domain cannot be empty."
    exit 1
fi

echo ""
echo "[*] Resolving IPv4 Addresses (A Records)..."
# The +short flag strips away the extra fluff and only returns the IP
dig +short A "$TARGET_DOMAIN"

echo ""
echo "[*] Querying Name Servers (NS Records)..."
# NS records tell us which servers are authoritative for this domain
dig +short NS "$TARGET_DOMAIN"

echo ""
echo "[*] Querying Mail Servers (MX Records)..."
# MX records show where email for this domain is routed
dig +short MX "$TARGET_DOMAIN"

echo "========================================"
