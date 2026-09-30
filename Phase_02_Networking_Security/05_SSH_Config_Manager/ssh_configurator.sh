#!/usr/bin/env bash

# ==========================================
# Topic 05: SSH Config Manager
# ==========================================

set -euo pipefail

SSH_DIR="$HOME/.ssh"
CONFIG_FILE="$SSH_DIR/config"

echo "========================================"
echo " Automated SSH Config Builder"
echo "========================================"

# Ensuring the .ssh directory exists with correct 700 permissions
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Capturing server details
read -p "Enter an easy alias for this server (e.g., prod-web, db-primary): " HOST_ALIAS
read -p "Enter the Server IP or Domain Name: " HOST_IP
read -p "Enter the login Username (e.g., ubuntu, ec2-user): " SSH_USER

# Input validation
if [ -z "$HOST_ALIAS" ] || [ -z "$HOST_IP" ] || [ -z "$SSH_USER" ]; then
    echo "[!] Error: All fields are required."
    exit 1
fi

echo ""
echo "[*] Injecting configuration into $CONFIG_FILE..."

# Appending the new block to the config file
cat <<EOF >> "$CONFIG_FILE"

# Added by SysOps Configurator on $(date +'%Y-%m-%d')
Host $HOST_ALIAS
    HostName $HOST_IP
    User $SSH_USER
    IdentityFile ~/.ssh/id_ed25519
    Port 22
    IdentitiesOnly yes
EOF

# SSH requires the config file to be strictly locked down to the owner
chmod 600 "$CONFIG_FILE"

echo "     Configuration saved securely."
echo "    You can now connect simply by typing: ssh $HOST_ALIAS"
echo "========================================"
