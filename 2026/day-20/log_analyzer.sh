#!/bin/bash

# Task 1: Input and Validation
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide the path to the log file as an argument."
    echo "Usage: $0 <log_file>"
    exit 1
fi

LOG_FILE=$1

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: The file '$LOG_FILE' does not exist."
    exit 1
fi

# Configuration
REPORT_DATE=$(date +%Y-%m-%d)
REPORT_FILE="log_report_${REPORT_DATE}.txt"
ARCHIVE_DIR="archive"

# Total lines processed
TOTAL_LINES=$(wc -l < "$LOG_FILE")

# Task 2: Error Count
ERROR_COUNT=$(grep -E -c "ERROR|Failed" "$LOG_FILE")
echo "Total Errors/Failures: $ERROR_COUNT"

# Task 3: Critical Events
echo "--- Critical Events ---"
CRITICAL_EVENTS=$(grep -n "CRITICAL" "$LOG_FILE" | sed -E 's/^([0-9]+):/Line \1: /')
if [ -n "$CRITICAL_EVENTS" ]; then
    echo "$CRITICAL_EVENTS"
else
    echo "No critical events found."
fi

# Task 4: Top Error Messages
echo "--- Top 5 Error Messages ---"
TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" | awk '{$1=$2=$3=""; print}' | sort | uniq -c | sort -rn | head -5)
if [ -n "$TOP_ERRORS" ]; then
    echo "$TOP_ERRORS"
else
    echo "No error messages found."
fi

# Task 5: Summary Report
{
    echo "Log Analysis Report"
    echo "==================="
    echo "Date of analysis: $(date)"
    echo "Log file name: $(basename "$LOG_FILE")"
    echo "Total lines processed: $TOTAL_LINES"
    echo "Total error count: $ERROR_COUNT"
    echo ""
    echo "--- Top 5 Error Messages ---"
    if [ -n "$TOP_ERRORS" ]; then
        echo "$TOP_ERRORS"
    else
        echo "No error messages found."
    fi
    echo ""
    echo "--- Critical Events ---"
    if [ -n "$CRITICAL_EVENTS" ]; then
        echo "$CRITICAL_EVENTS"
    else
        echo "No critical events found."
    fi
} > "$REPORT_FILE"

echo ""
echo "Summary report generated: $REPORT_FILE"

# Task 6: Archive Processed Logs
if [ ! -d "$ARCHIVE_DIR" ]; then
    mkdir "$ARCHIVE_DIR"
fi

mv "$LOG_FILE" "$ARCHIVE_DIR/"
echo "Log file moved to $ARCHIVE_DIR/"
