# SysOps Sentinel: Automated Server Health & Security Engine

A production-grade Linux systems administration and automated maintenance utility written in Bash. Designed to execute proactive health monitoring, inspect resource footprints, remediate insecure file permissions, and automate directory backups with audit trails.

## Features
- **Strict Execution Policy:** Enforces `set -euo pipefail` to ensure zero-tolerance for silent command failures or uninitialized variables.
- **Resource Footprint Diagnostics:** Automatically tracks root partition disk consumption and memory usage, logging top CPU consumers via `ps`.
- **Automated Security Remediation:** Employs the `find` utility to detect world-writable files (`777`) and programmatically hardens them down to strict least-privilege standards (`640` / `750`).
- **State Archival & Backup:** Bundles application states and configurations into timestamped `.tar.gz` archives secured with restrictive permissions (`600`).
- **Audit Logging:** Emits clean, timestamped logs with colored terminal indicators and persistent reporting files.

## Project Structure
