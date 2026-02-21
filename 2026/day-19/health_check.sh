#!/bin/bash

# Simple Server Health Check Script
# Displays basic system stats

echo "--- Server Health Check - $(date) ---"

# 1. CPU Usage
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "  Total Usage: " 100-$8 "%"}'

# 2. Memory Usage
echo "Memory Usage:"
free -h | awk '/Mem:/ {print "  Used: " $3 " / Total: " $2}'

# 3. Disk Usage
echo "Disk Usage (Root Partition):"
df -h / | awk 'NR==2 {print "  Used: " $3 " / Total: " $2 " (" $5 ")"}'

# 4. Active Connections
echo "TCP Connections:"
ss -an | grep -c "ESTAB" | awk '{print "  Established: " $1}'

echo "------------------------------------------------"
