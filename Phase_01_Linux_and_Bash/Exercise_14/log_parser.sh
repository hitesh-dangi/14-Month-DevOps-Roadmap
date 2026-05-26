#!/bin/bash

set -e

echo "Accessing suspicious IP addresses....."

# Using awk to target the log file
# Also using | sort | uniq for clean data

awk '{print $2}' /tmp/security_logs/auth.log | sort | uniq > attacker_ips.txt
echo "Suspicious IP addresses successfully captured and redirected to the attacker_ips.txt file."

