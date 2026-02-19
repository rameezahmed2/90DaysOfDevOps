#!/bin/bash

# Task 5 Requirement: Use set -e to exit on any error
set -e

echo "--- Running Safe Script ---"

# Step 1: Create a directory /tmp/devops-test
# Using || operator to handle if directory already exists, though set -e might catch mkdir failure if it's not handled
mkdir /tmp/devops-test 2>/dev/null || echo "Info: Directory /tmp/devops-test already exists."

# Step 2: Navigate into it
cd /tmp/devops-test || { echo "Error: Could not navigate into /tmp/devops-test"; exit 1; }

# Step 3: Create a file inside
touch test_file.txt && echo "Success: Created test_file.txt inside /tmp/devops-test"

# Additional check to show set -e in action (trying to touch a file in a restricted area)
# echo "Trying to touch a file in /sys (this should trigger set -e and exit the script)"
# touch /sys/test_file.txt 2>/dev/null || echo "Triggered handle for /sys failure"

echo "Safe script execution finished successfully."
