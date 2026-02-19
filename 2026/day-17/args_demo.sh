#!/bin/bash

echo "--- Command-Line Arguments Demo ---"
echo "Script name (\$0): $0"
echo "Total number of arguments (\$#): $#"
echo "All arguments (\$@): $@"

# Demonstration of individual arguments if they exist
for ((i=1; i<=$#; i++)); do
    echo "Argument $i: ${!i}"
done
