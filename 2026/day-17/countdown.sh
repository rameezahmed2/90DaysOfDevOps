#!/bin/bash

# Check if a number is provided
if [ -z "$1" ]; then
    echo "Please provide a number to start the countdown."
    exit 1
fi

number=$1

echo "--- Starting Countdown from $number ---"
while [ $number -ge 0 ]; do
    echo "$number"
    number=$((number - 1))
    sleep 0.5 # Optional: added for better visual effect
done

echo "Done!"
