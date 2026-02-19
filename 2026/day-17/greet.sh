#!/bin/bash

# Check if an argument is passed
if [ $# -eq 0 ]; then
    echo "Usage: ./greet.sh <name>"
    exit 1
fi

name=$1

echo "Hello, $name!"
