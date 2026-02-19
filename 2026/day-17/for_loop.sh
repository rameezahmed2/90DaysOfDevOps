#!/bin/bash

# List of 5 fruits
fruits=("Apple" "Banana" "Mango" "Orange" "Grapes")

echo "--- Printing a list of 5 fruits ---"
for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done
