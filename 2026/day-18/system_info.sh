#!/bin/bash
set -euo pipefail

# Function to print hostname and OS info
print_os_info() {
    echo "--- Hostname & OS Info ---"
    echo "Hostname: $(hostname)"
    echo "OS: $(grep '^PRETTY_NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '\"')"
}

# Function to print uptime
print_uptime() {
    echo "--- System Uptime ---"
    uptime -p
}

# Function to print disk usage (top 5 by size)
print_disk_usage() {
    echo "--- Disk Usage (Top 5 Partitions) ---"
    df -h | head -n 6
}

# Function to print memory usage
print_memory_usage() {
    echo "--- Memory Usage ---"
    free -h
}

# Function to print top 5 CPU-consuming processes
print_cpu_processes() {
    echo "--- Top 5 CPU Consuming Processes ---"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
}

# Main function
main() {
    clear
    echo "=========================================="
    echo "       SYSTEM INFORMATION REPORTER"
    echo "=========================================="
    print_os_info
    echo ""
    print_uptime
    echo ""
    print_disk_usage
    echo ""
    print_memory_usage
    echo ""
    print_cpu_processes
    echo "=========================================="
}

# Call main function
main
