# Day 19 Project: Shell Scripting for System Maintenance

This document outlines the implementation of automated system maintenance tasks using Shell Scripting and Crontab.

## 🚀 Overview

The goal of this project is to automate repetitive DevOps tasks:
1.  **Log Rotation**: Managing disk space by compressing and deleting old logs.
2.  **Server Backups**: Ensuring data safety by creating periodic archives.
3.  **Health Monitoring**: Periodic checks of system vitals.
4.  **Scheduled Maintenance**: Combining tasks into a single automated workflow.

---

## 🛠️ Scripts Detail

### 1. Log Rotation (`log_rotate.sh`)

This script handles log management by compressing logs older than 7 days and deleting archives older than 30 days.

```bash
# Example Usage
./log_rotate.sh /var/log/myapp
```

[View Script](file:///home/rameez/git_resources/90DaysOfDevOps/2026/day-19/log_rotate.sh)

### 2. Server Backup (`backup.sh`)

Creates timestamped `.tar.gz` archives of a source directory and manages retention (keeps last 14 days).

```bash
# Example Usage
./backup.sh /home/user/data /backups
```

[View Script](file:///home/rameez/git_resources/90DaysOfDevOps/2026/day-19/backup.sh)

### 3. Server Health Check (`health_check.sh`)

A lightweight script to monitor CPU, Memory, Disk, and Network connections.

[View Script](file:///home/rameez/git_resources/90DaysOfDevOps/2026/day-19/health_check.sh)

### 4. Scheduled Maintenance (`maintenance.sh`)

A master script that integrates log rotation and backups, logging all output to `/var/log/maintenance.log`.

---

## ⏰ Cron Scheduling

To automate these scripts, we use the `crontab`. Below are the recommended entries:

| Task | Schedule | Cron Entry |
| :--- | :--- | :--- |
| **Maintenance** | Daily @ 1 AM | `0 1 * * * /path/to/maintenance.sh /logs /src /dest` |
| **Log Rotation** | Daily @ 2 AM | `0 2 * * * /path/to/log_rotate.sh /var/log/myapp` |
| **Server Backup** | Sunday @ 3 AM | `0 3 * * 0 /path/to/backup.sh /data /backups` |
| **Health Check** | Every 5 Mins | `*/5 * * * * /path/to/health_check.sh` |

---

## 💡 Key Learnings

1.  **Automation with `find`**: Leveraging `find` with `-mtime` and `-exec` is powerful for cleanup tasks.
2.  **Exit Code Management**: Using `$?` to verify the success of critical operations (like backups) ensures reliability.
3.  **Centralized Logging**: Integrating multiple scripts into a single maintenance wrapper with a unified log file makes troubleshooting much easier.

---

**DevOps Journey Continues!** 🚀
`#90DaysOfDevOps` `#TrainWithShubham`
