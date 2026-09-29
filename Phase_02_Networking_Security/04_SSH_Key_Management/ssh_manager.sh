#!/usr/bin/env bash

# ==========================================
# Topic 04: SSH Key Generator & Manager
# ==========================================

set -euo pipefail

# Defining the standard path for an Ed25519 SSH key
KEY_PATH="$HOME/.ssh/id_ed25519"

echo "========================================"
echo "  SSH Key Manager"
echo "========================================"

# Checking if the key already exists to prevent accidental overwrites
if [ -f "$KEY_PATH" ]; then
    echo "[*] SSH Key pair already exists at: $KEY_PATH"
else
    echo "[*] No Ed25519 key found. Generating a new cryptographic key pair..."
    
    # Generating the key:
    # -t ed25519 (algorithm type)
    # -C (comment to identify the key)
    # -f (file path)
    # -N "" (empty passphrase for automated access)
    ssh-keygen -t ed25519 -C "devops_student@$(hostname)" -f "$KEY_PATH" -N ""
    
    echo " Key generation successful."
fi

echo ""
echo "[*] Your Public Key (The 'Lock'):"
echo "    Copy the output below and paste it into AWS, GitHub, or any remote server."
echo "----------------------------------------"
cat "${KEY_PATH}.pub"
echo "----------------------------------------"
echo "[!] WARNING: Never share your private key ($KEY_PATH)."
echo "========================================"
