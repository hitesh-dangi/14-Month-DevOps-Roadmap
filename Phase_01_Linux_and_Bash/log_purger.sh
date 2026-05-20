#!/bin/bash
# Description: Safely deletes logs older than 7 days to prevent disk exhaustion.

echo "Starting log cleanup..."
find /tmp/log_cleanup -mtime +7 -delete
echo "Old logs successfully purged!"
