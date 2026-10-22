#!/usr/bin/env bash
# ==============================================================================
# Script Name: ufw_baseline.sh
# Description: Automates zero-trust UFW firewall hardening for Linux servers.
# Author: Hitesh Dangi
# ==============================================================================

set -euo pipefail

echo "[+] Applying Zero-Trust UFW Firewall Baseline..."

# 1. Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# 2. Allow essential ports (SSH)
sudo ufw allow 22/tcp

# 3. Enable firewall
sudo ufw --force enable

# 4. Display status
sudo ufw status verbose
echo "[+] UFW Firewall baseline successfully configured!"
