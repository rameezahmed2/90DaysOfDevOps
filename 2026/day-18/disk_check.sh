#!/bin/bash

# Function to check disk usage of /
check_disk() {
    echo "--- Disk Usage (/) ---"
    df -h / | tail -n 1 | awk '{print "Used: " $3 ", Available: " $4 ", Usage%: " $5}'
}

# Function to check free memory
check_memory() {
    echo "--- Free Memory ---"
    free -h | grep "Mem:" | awk '{print "Total: " $2 ", Used: " $3 ", Free: " $4}'
}

# Main section
echo "System Health Check"
echo "==================="
check_disk
echo ""
check_memory
