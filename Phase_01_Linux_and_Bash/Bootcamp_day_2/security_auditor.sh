#!/bin/bash
set -e

# ==========================================
# Bootcamp Day 2 Bonus: Automated Security Auditor
# ==========================================

TARGET_DIR="./audit_zone"

echo "Starting Automated Security Audit..."

# 1. Building a dummy environment with mixed security
mkdir -p "$TARGET_DIR"
touch "$TARGET_DIR/safe_config.txt"
touch "$TARGET_DIR/vulnerable_script.sh"

# Set one file correctly (644), and one dangerously (777)
chmod 644 "$TARGET_DIR/safe_config.txt"
chmod 777 "$TARGET_DIR/vulnerable_script.sh"
echo "[*] Test environment generated."
echo "--------------------------------"

# 2. Scan for dangerous world-writable (777) files
echo "[*] Scanning $TARGET_DIR for 777 permissions..."

VULN_FILES=$(find "$TARGET_DIR" -type f -perm 777)

# 3. Analyzing and Patching the vulnarabel files
if [ -z "$VULN_FILES" ]; then
    echo " System Secure: No vulnerable files detected."
else
    echo "[!] ALERT: World-writable files detected!"
    
    # Loop through every vulnerable file it found and fixing it
    for file in $VULN_FILES; do
        echo "    -> Patching: $file"
        chmod 644 "$file"
    done
    
    echo " All vulnerabilities successfully downgraded to 644."
fi

echo "--------------------------------"
echo "Final Security State:"
ls -l "$TARGET_DIR"
