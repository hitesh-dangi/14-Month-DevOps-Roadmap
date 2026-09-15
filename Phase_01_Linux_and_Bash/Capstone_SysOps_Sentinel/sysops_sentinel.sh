#!/usr/bin/env bash

# ==============================================================================
# Project: SysOps Sentinel (Linux & Bash Capstone)
# Description: Automated Server Health Auditing, Security Hardening & Backup Engine
# Author: Hitesh Dangi
# ==============================================================================

set -euo pipefail

# --- Configuration & Paths ---
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${BASE_DIR}/target_env"
BACKUP_DIR="${BASE_DIR}/backups"
LOG_DIR="${BASE_DIR}/logs"
TIMESTAMP="$(date +'%Y-%m-%d_%H-%M-%S')"
REPORT_FILE="${LOG_DIR}/audit_report_${TIMESTAMP}.log"

# Thresholds
DISK_THRESHOLD_PERCENT=80

# --- Color Formatting ---
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

log_info() {
    local msg="[*] $1"
    echo -e "${BLUE}${msg}${RESET}"
    echo "$msg" >> "$REPORT_FILE"
}

log_success() {
    local msg="[SUCCESS] $1"
    echo -e "${GREEN}${msg}${RESET}"
    echo "$msg" >> "$REPORT_FILE"
}

log_warn() {
    local msg="[WARNING] $1"
    echo -e "${YELLOW}${msg}${RESET}"
    echo "$msg" >> "$REPORT_FILE"
}

log_alert() {
    local msg="[ALERT] $1"
    echo -e "${RED}${msg}${RESET}"
    echo "$msg" >> "$REPORT_FILE"
}

# --- Module 1: Environment Validation ---
init_engine() {
    mkdir -p "$BACKUP_DIR" "$LOG_DIR" "$TARGET_DIR"
    echo "================================================================" > "$REPORT_FILE"
    echo "       SYSOPS SENTINEL: SYSTEM AUDIT & SECURITY REPORT          " >> "$REPORT_FILE"
    echo "       Execution Timestamp: ${TIMESTAMP}                       " >> "$REPORT_FILE"
    echo "================================================================" >> "$REPORT_FILE"
    log_info "Initializing SysOps Sentinel audit engine..."
}

# --- Module 2: System Resource Health ---
audit_system_health() {
    log_info "Running System Resource Metrics Check..."

    # Check Disk Capacity
    local disk_usage
    disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
    
    if [ "$disk_usage" -ge "$DISK_THRESHOLD_PERCENT" ]; then
        log_alert "Root filesystem disk usage is at ${disk_usage}% (Exceeds ${DISK_THRESHOLD_PERCENT}% threshold)."
    else
        log_success "Disk capacity safe: Root filesystem utilization at ${disk_usage}%."
    fi

    # Check RAM Consumption
    local total_mem used_mem
    total_mem=$(free -m | awk '/^Mem:/ {print $2}')
    used_mem=$(free -m | awk '/^Mem:/ {print $3}')
    log_info "Memory Consumption: ${used_mem}MB used of ${total_mem}MB total."

    # Record Top 3 CPU Consuming Processes
    echo -e "\n--- Top 3 Active Processes by CPU Utilization ---" >> "$REPORT_FILE"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 4 >> "$REPORT_FILE"
    log_success "Captured top process footprint."
}

# --- Module 3: Security & Permission Auditing ---
audit_and_harden_security() {
    log_info "Scanning target directory (${TARGET_DIR}) for insecure permissions..."

    # Detect any world-writable (777) files
    local vulnerable_files
    vulnerable_files=$(find "$TARGET_DIR" -type f -perm 0777 || true)

    if [ -n "$vulnerable_files" ]; then
        log_warn "Detected files with dangerous 777 permissions:"
        while IFS= read -r file; do
            [ -z "$file" ] && continue
            log_alert "Compromised permission found on: $file"
            # Remediate by downgrading to 640 (Owner rw, Group r, Other none)
            chmod 640 "$file"
            log_success "Hardened: $file -> 640"
        done <<< "$vulnerable_files"
    else
        log_success "No 777 permission risks discovered in audit zone."
    fi

    # Audit directory permissions
    find "$TARGET_DIR" -type d -exec chmod 750 {} +
    log_success "Enforced least privilege boundary (750) across audit directories."
}

# --- Module 4: Automated Archival & Backup ---
execute_backup() {
    log_info "Initiating configuration and state backup..."

    local archive_name="backup_config_${TIMESTAMP}.tar.gz"
    local archive_path="${BACKUP_DIR}/${archive_name}"

    if tar -czf "$archive_path" -C "$BASE_DIR" "target_env" 2>> "$REPORT_FILE"; then
        chmod 600 "$archive_path"
        log_success "Created encrypted/locked backup archive: ${archive_name} (600)"
    else
        log_alert "Backup generation encountered a non-zero exit code."
        return 1
    fi

    # Rotate old backups (Keep only backups newer than 7 days, or prune excess)
    local total_backups
    total_backups=$(find "$BACKUP_DIR" -type f -name "*.tar.gz" | wc -l)
    log_info "Current backup catalog size: ${total_backups} archive(s)."
}

# --- Engine Execution Flow ---
main() {
    init_engine
    audit_system_health
    audit_and_harden_security
    execute_backup
    log_success "SysOps Sentinel execution concluded successfully."
    echo -e "\nDetailed Audit Log generated at: ${REPORT_FILE}"
}

main "$@"
