#!/bin/bash

# Function using local variable
local_var_func() {
    local my_var="I am local"
    echo "Inside local_var_func: my_var = $my_var"
}

# Function using global variable
global_var_func() {
    global_var="I am global"
    echo "Inside global_var_func: global_var = $global_var"
}

echo "--- Local vs Global Variable Demo ---"

local_var_func
echo "Outside function: my_var = $my_var (Should be empty)"

echo -e "\n--- Global Variable Leak Demo ---"
global_var_func
echo "Outside function: global_var = $global_var (Leaked outside!)"
