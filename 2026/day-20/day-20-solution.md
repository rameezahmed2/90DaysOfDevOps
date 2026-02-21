# Day 20 – Bash Scripting Challenge: Log Analyzer and Report Generator

## Overview
As part of the 90DaysOfDevOps challenge, today's task is focused on analyzing server logs. The goal is to write a script that processes a generated log file, calculates insights such as the total error count, most frequent errors, and critical events, and then creates a well-formatted log report. The processed summary report makes it easy for system administrators to check system health.

## 🛠 Script Implementation

`log_analyzer.sh` automates the entire process:

```bash
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
```

## 📋 Sample Output

When running the log generator (`./sample_logs_generator.sh sample_log.log 500`) and the log analyzer script (`./log_analyzer.sh sample_log.log`), the expected console output will look like this:

```
Total Errors/Failures: 95
--- Critical Events ---
Line 1: 2026-02-21 11:52:26 [CRITICAL]  - 27421
Line 9: 2026-02-21 11:52:26 [CRITICAL]  - 23095
...
--- Top 5 Error Messages ---
      1    Segmentation fault - 8496
      1    Segmentation fault - 7802
      1    Segmentation fault - 6854
      1    Segmentation fault - 30557
      1    Segmentation fault - 30059

Summary report generated: log_report_2026-02-21.txt
Log file moved to archive/
```

Inside the generated summary report (`log_report_2026-02-21.txt`):

```
Log Analysis Report
===================
Date of analysis: Sat 21 Feb 11:52:26 PKT 2026
Log file name: sample_log.log
Total lines processed: 500
Total error count: 95

--- Top 5 Error Messages ---
      1    Segmentation fault - 8496
      1    Segmentation fault - 7802
      1    Segmentation fault - 6854
...

--- Critical Events ---
Line 1: 2026-02-21 11:52:26 [CRITICAL]  - 27421
Line 9: 2026-02-21 11:52:26 [CRITICAL]  - 23095
...
```

## 🔧 Tools & Commands Used

- `wc -l`: Used to count the total number of lines in the log file (`wc -l < file`).
- `grep`: Extremely useful for parsing files. `grep -c` outputs the count of matching lines, and `grep -n` prepends the line number to the matching string. We also used `grep -E` for extended regex support.
- `sed`: The stream editor was used for modifying outputs inline, e.g., renaming the `grep -n` output from `84:` to `Line 84:`.
- `awk`: Useful pattern-scanning language. Used to nullify the date, time, and log level fields (`$1=$2=$3=""`) in order to only check error strings for uniqueness.
- `sort`: Used with the `uniq` pipeline to properly group identical lines (`sort`) and then sort numeric occurrences descendingly (`sort -rn`).
- `uniq -c`: Grouped consecutive identical lines and prefixed them with the count of occurrences.
- `head -5`: Taken only the top 5 occurrences.

## 🧠 Key Learnings

1. **Text Stream Processing**: Piping text manipulators (`grep`, `awk`, `sort`, `uniq`, `head`) provides a comprehensive syntax to manipulate log string data effortlessly, allowing complex aggregate routines in a single elegant bash command.
2. **Process Redirection & Grouping**: Putting multiple echo lines in a block like `{ echo "A"; echo "B"; } > file` is an efficient way of creating multi-line file reports in bash without repeating `>>` operators.
3. **Log Rotation & Archiving**: Storing processed files away by dynamically managing folders (`test -d` to check if a directory exists, `mkdir` if not) effectively prevents executing analysis upon already-processed targets.
