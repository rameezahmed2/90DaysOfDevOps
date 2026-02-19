#!/bin/bash
set -euo pipefail

echo "--- Strict Mode Demo ---"

# set -u demo: Try to echo an undefined variable
# Uncomment the line below to see it fail
# echo "This is an undefined variable: $UNDEFINED_VAR"

# set -e demo: Run a command that fails
# ls /non_existent_folder

# set -o pipefail demo: A piped command where the first part fails
# cat non_existent_file | grep "something"

echo "If this line prints, no errors were caught by strict mode (yet)."
