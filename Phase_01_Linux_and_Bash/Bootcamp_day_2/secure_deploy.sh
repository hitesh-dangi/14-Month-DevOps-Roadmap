#!/bin/bash
set -e

# ==========================================
# Bootcamp Day 2: Secure Deployment Locker
# ==========================================

DEPLOY_DIR="./app_backend"
CONFIG_FILE="$DEPLOY_DIR/database.conf"

echo "Initializing Secure Deployment..."

# 1. Creating the environment
mkdir -p "$DEPLOY_DIR"
touch "$CONFIG_FILE"

# 2. Injecting some dummy configuration data
echo "DB_USER=admin" > "$CONFIG_FILE"
echo "DB_PASS=SuperSecret123!" >> "$CONFIG_FILE"

# 3. Ownership Transfer (chown)
# We are transferring group ownership to 'bob'. 
# (Requires sudo when you run the script to reassign ownership)
echo "[*] Transferring group ownership to the 'bob' team..."
sudo chown :bob "$DEPLOY_DIR"
sudo chown :bob "$CONFIG_FILE"

# 4. Strict Permissions (chmod)
# 750 on Directory: Owner(7=rwx), Group(5=rx), Others(0=none)
# 640 on File: Owner(6=rw), Group(4=r), Others(0=none)
echo "[*] Locking down permissions..."
sudo chmod 750 "$DEPLOY_DIR"
sudo chmod 640 "$CONFIG_FILE"

echo "✅ Deployment secured successfully!"
echo "--------------------------------"

# 5. Verify the locks
echo "Directory Security:"
ls -ld "$DEPLOY_DIR"
echo ""
echo "File Security:"
ls -l "$CONFIG_FILE"
