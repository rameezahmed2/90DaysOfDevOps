#!/bin/bash

# Function 1: Greet the user
greet() {
    local name=$1
    if [ -z "$name" ]; then
        echo "Hello, Guest!"
    else
        echo "Hello, $name!"
    fi
}

# Function 2: Add two numbers
add() {
    local num1=$1
    local num2=$2
    local sum=$((num1 + num2))
    echo "The sum of $num1 and $num2 is: $sum"
}

# Calling the functions
echo "--- Testing greet function ---"
greet "Rameez"
greet

echo -e "\n--- Testing add function ---"
add 10 20
add 5 7
