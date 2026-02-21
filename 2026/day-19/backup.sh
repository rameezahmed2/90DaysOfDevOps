#!/bin/bash

# Server Backup Script
# Usage: ./backup.sh /source/dir /backup/destination

SOURCE_DIR=$1
BACKUP_DEST=$2

if [ -z "$SOURCE_DIR" ] || [ -z "$BACKUP_DEST" ]; then
    echo "Error: Missing arguments."
    echo "Usage: $0 /source/dir /backup/destination"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist."
    exit 1
fi

if [ ! -d "$BACKUP_DEST" ]; then
    echo "Creating backup destination: $BACKUP_DEST"
    mkdir -p "$BACKUP_DEST"
fi

TIMESTAMP=$(date +%Y-%m-%d)
BACKUP_NAME="backup-$TIMESTAMP.tar.gz"
BACKUP_PATH="$BACKUP_DEST/$BACKUP_NAME"

echo "Starting backup of $SOURCE_DIR to $BACKUP_PATH..."

# Create timestamped tarball
tar -czf "$BACKUP_PATH" "$SOURCE_DIR" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Backup successful!"
    echo "Archive Name: $BACKUP_NAME"
    echo "Archive Size: $(du -sh "$BACKUP_PATH" | cut -f1)"
else
    echo "Error: Backup failed."
    exit 1
fi

# Delete backups older than 14 days
echo "Cleaning up backups older than 14 days in $BACKUP_DEST..."
find "$BACKUP_DEST" -name "backup-*.tar.gz" -mtime +14 -exec rm -f {} \;

echo "Cleanup finished."
