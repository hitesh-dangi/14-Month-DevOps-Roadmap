#!/usr/bin/env bash
# ==============================================================================
# Script Name: log_analyzer.sh
# Description: Parses web server access logs for 5xx errors and top client IPs.
# Author: Hitesh Dangi
# ==============================================================================

set -euo pipefail

LOG_FILE="/tmp/sample_access.log"

# Generate sample Nginx log if not present
cat << 'SAMPLE' > "$LOG_FILE"
192.168.1.10 - - [24/Oct/2026:10:01:01] "GET /index.html HTTP/1.1" 200 1024
10.0.0.55 - - [24/Oct/2026:10:01:05] "POST /login HTTP/1.1" 401 512
172.16.0.9 - - [24/Oct/2026:10:01:10] "GET /dashboard HTTP/1.1" 502 128
10.0.0.55 - - [24/Oct/2026:10:01:12] "POST /login HTTP/1.1" 401 512
172.16.0.9 - - [24/Oct/2026:10:01:20] "GET /api/data HTTP/1.1" 502 128
172.16.0.9 - - [24/Oct/2026:10:01:25] "GET /api/user HTTP/1.1" 503 128
SAMPLE

echo "=== [1] Top Requesting Client IPs ==="
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr

echo -e "\n=== [2] 5xx Server Error Requests (IP & Endpoint) ==="
awk '$9 >= 500 && $9 < 600 {print $1, $7, "Status:", $9}' "$LOG_FILE"

echo -e "\n=== [3] Total 5xx Count ==="
awk '$9 >= 500 && $9 < 600 {count++} END {print "Total 5xx Errors:", count+0}' "$LOG_FILE"
