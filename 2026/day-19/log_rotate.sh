#!/bin/bash

# Log Rotation Script
# Usage: ./log_rotate.sh /path/to/logs

LOG_DIR=$1

if [ -z "$LOG_DIR" ]; then
    echo "Error: Directory path is missing."
    echo "Usage: $0 /path/to/logs"
    exit 1
fi

if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory $LOG_DIR does not exist."
    exit 1
fi

echo "Starting log rotation for: $LOG_DIR"

# 1. Compress .log files older than 7 days
# -name "*.log": only log files
# -mtime +7: older than 7 days
# -type f: only files
COMPRESSED_COUNT=$(find "$LOG_DIR" -maxdepth 1 -name "*.log" -type f -mtime +7 | wc -l)
find "$LOG_DIR" -maxdepth 1 -name "*.log" -type f -mtime +7 -exec gzip {} \;

# 2. Delete .gz files older than 30 days
# -name "*.gz": only compressed files
# -mtime +30: older than 30 days
DELETED_COUNT=$(find "$LOG_DIR" -maxdepth 1 -name "*.gz" -type f -mtime +30 | wc -l)
find "$LOG_DIR" -maxdepth 1 -name "*.gz" -type f -mtime +30 -exec rm -f {} \;

echo "Compression complete. Files compressed: $COMPRESSED_COUNT"
echo "Cleanup complete. Files deleted: $DELETED_COUNT"
echo "Process finished."
