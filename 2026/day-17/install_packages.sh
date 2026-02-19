#!/bin/bash

# Task 5 Requirement: Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)."
    exit 1
fi

# List of packages to install
packages=("nginx" "curl" "wget")

echo "--- Starting Package Installation Process ---"

for pkg in "${packages[@]}"; do
    # Check if package is installed
    if dpkg -s "$pkg" &> /dev/null; then
        echo "[SKIP] $pkg is already installed."
    else
        echo "[INSTALLING] $pkg..."
        apt-get update -y &> /dev/null
        apt-get install -y "$pkg" &> /dev/null
        
        # Verify installation
        if [ $? -eq 0 ]; then
            echo "[SUCCESS] $pkg has been installed."
        else
            echo "[FAILED] Could not install $pkg."
        fi
    fi
done

echo "--- Installation Process Completed ---"
