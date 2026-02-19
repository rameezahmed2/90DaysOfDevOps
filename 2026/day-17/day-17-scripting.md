# Day 17: Mastering Shell Scripting 🚀

Welcome to Day 17 of the #90DaysOfDevOps challenge! Today's focus is on elevating shell scripting skills by implementing loops, handling command-line arguments, and integrating robust error handling.

---

## 📋 Task Overview
- **Loops:** Implementing `for` and `while` loops for automation.
- **Arguments:** Using positional parameters (`$1`, `$#`, `$@`).
- **Automation:** Installing packages via script.
- **Error Handling:** Using `set -e`, exit codes, and root checks.

---

## 🛠️ Task 1: For Loops

### 1.1 `for_loop.sh` - Iterating Over Lists
This script demonstrates how to loop through a predefined list of items.

```bash
#!/bin/bash

# List of 5 fruits
fruits=("Apple" "Banana" "Mango" "Orange" "Grapes")

echo "--- Printing a list of 5 fruits ---"
for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done
```

**Output:**
```text
--- Printing a list of 5 fruits ---
Fruit: Apple
Fruit: Banana
Fruit: Mango
Fruit: Orange
Fruit: Grapes
```

### 1.2 `count.sh` - Range-Based Loops
Using C-style for loops to iterate through a range of numbers.

```bash
#!/bin/bash

echo "--- Printing numbers from 1 to 10 ---"
for ((i=1; i<=10; i++)); do
    echo "Number: $i"
done
```

**Output:**
```text
--- Printing numbers from 1 to 10 ---
Number: 1
Number: 2
...
Number: 10
```

---

## 🔄 Task 2: While Loops

### `countdown.sh` - Conditional Iteration
A script that counts down from a user-provided number until it hits zero.

```bash
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
    sleep 0.5 
done

echo "Done!"
```

**Output Example (`./countdown.sh 3`):**
```text
--- Starting Countdown from 3 ---
3
2
1
0
Done!
```

---

## 📥 Task 3: Command-Line Arguments

### 3.1 `greet.sh` - Basic Positional Parameters
Handling input directly from the terminal.

```bash
#!/bin/bash

# Check if an argument is passed
if [ $# -eq 0 ]; then
    echo "Usage: ./greet.sh <name>"
    exit 1
fi

name=$1
echo "Hello, $name!"
```

### 3.2 `args_demo.sh` - Argument Metadata
Exploring `$0`, `$#`, and `$@` to manage script inputs.

```bash
#!/bin/bash

echo "--- Command-Line Arguments Demo ---"
echo "Script name (\$0): $0"
echo "Total number of arguments (\$#): $#"
echo "All arguments (\$@): $@"
```

**Output Example (`./args_demo.sh devops is fun`):**
```text
--- Command-Line Arguments Demo ---
Script name ($0): ./args_demo.sh
Total number of arguments ($#): 3
All arguments ($@): devops is fun
```

---

## 📦 Task 4 & 5: Package Installation & Error Handling

### `install_packages.sh`
A robust script to automate package management with root verification.

```bash
#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run as root (use sudo)."
    exit 1
fi

packages=("nginx" "curl" "wget")

echo "--- Starting Package Installation ---"
for pkg in "${packages[@]}"; do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "[SKIP] $pkg is already installed."
    else
        echo "[INSTALLING] $pkg..."
        apt-get update -y &> /dev/null
        apt-get install -y "$pkg" &> /dev/null
        echo "[SUCCESS] $pkg installed."
    fi
done
```

### `safe_script.sh` - Defensive Scripting
Implementing `set -e` to ensure the script stops immediately upon any failure.

```bash
#!/bin/bash
set -e

echo "--- Running Safe Script ---"
mkdir /tmp/devops-test 2>/dev/null || echo "Info: Directory exists."
cd /tmp/devops-test
touch test_file.txt && echo "Success: Created test_file.txt"
```

---

## 💡 Key Learnings

1.  **Loops for Automation:** `for` loops are excellent for iterating over known lists (like packages or files), while `while` loops are better suited for operations that depend on changing conditions.
2.  **Positional Parameters:** Utilizing `$1`, `$@`, and `$#` allows scripts to be dynamic and reusable without hardcoding values.
3.  **Error Handling is Essential:** Using `set -e` and checking for exit codes (`$?`) or environment variables (like `$EUID`) transforms a simple script into a production-ready automation tool.

---

## 🚀 Enhancement: Shell Scripting Best Practices

To make your scripts even better, follow these "Pro" tips:
- **Always use double quotes** around variables (e.g., `"$VAR"`) to prevent globbing and word splitting.
- **Add Comments:** Explain *why* a complex logic exists, not just *what* it does.
- **Use ShellCheck:** Always run your scripts through `shellcheck` to find potential bugs and styling issues.
- **Shebang Accuracy:** Use `#!/bin/bash` or `#!/usr/bin/env bash` for better portability.

---

### Connect with Me
- **LinkedIn:** [Your Profile Link Here]
- **Hashnode:** [Your Blog Link Here]

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham #BashScripting #Automation
