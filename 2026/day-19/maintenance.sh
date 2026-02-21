#!/bin/bash

# Combined Maintenance Script
# Integrates Log Rotation and Backup
# Usage: ./maintenance.sh /log/dir /source/dir /backup/dest

LOG_PATH="/var/log/maintenance.log"
LOG_DIR=$1
SOURCE_DIR=$2
BACKUP_DEST=$3

# Ensure we have required args
if [ -z "$LOG_DIR" ] || [ -z "$SOURCE_DIR" ] || [ -z "$BACKUP_DEST" ]; then
    echo "Usage: $0 /log/dir /source/dir /backup/dest"
    exit 1
fi

# Function to log with timestamps
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_PATH"
}

log_message "Starting Scheduled Maintenance Task"

# 1. Run Log Rotation
log_message "Running Log Rotation..."
./log_rotate.sh "$LOG_DIR" >> "$LOG_PATH" 2>&1
if [ $? -eq 0 ]; then
    log_message "Log Rotation completed successfully."
else
    log_message "Log Rotation failed! Check $LOG_PATH for details."
fi

# 2. Run Server Backup
log_message "Running Server Backup..."
./backup.sh "$SOURCE_DIR" "$BACKUP_DEST" >> "$LOG_PATH" 2>&1
if [ $? -eq 0 ]; then
    log_message "Server Backup completed successfully."
else
    log_message "Server Backup failed! Check $LOG_PATH for details."
fi

log_message "Maintenance Task Finished."
