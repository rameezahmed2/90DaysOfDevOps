# Day 18: Advanced Shell Scripting — Functions & Strict Mode 🚀

Welcome to Day 18! Today we transition from basic scripting to writing cleaner, more modular, and "production-ready" Bash scripts. We explored functions, variable scoping, and the crucial "Strict Mode."

---

## 📋 Task Overview
- **Modularization:** Creating reusable logic using functions.
- **Scoping:** Managing variables with the `local` keyword.
- **Safety First:** Implementing `set -euo pipefail` (Bash Strict Mode).
- **System Automation:** Building a comprehensive system information reporter.

---

## 🛠️ Task 1: Reusable Logic with Functions
### `functions.sh`
This script demonstrates how to define and call functions with arguments.

```bash
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

echo "--- Testing greet function ---"
greet "Rameez"
greet

echo -e "\n--- Testing add function ---"
add 10 20
```

---

## 📊 Task 2: Health Monitoring
### `disk_check.sh`
Functions are used here to separate different monitoring concerns.

```bash
#!/bin/bash

check_disk() {
    echo "--- Disk Usage (/) ---"
    df -h / | tail -n 1 | awk '{print "Used: " $3 ", Available: " $4 ", Usage%: " $5}'
}

check_memory() {
    echo "--- Free Memory ---"
    free -h | grep "Mem:" | awk '{print "Total: " $2 ", Used: " $3 ", Free: " $4}'
}

echo "System Health Check"
check_disk
check_memory
```

---

## 🛡️ Task 3: The "Strict Mode" (set -euo pipefail)
Documentation of the most important flags for safe scripting:

-   **`set -e` (Exit on Error):** Instructs Bash to exit immediately if any command returns a non-zero exit code.
-   **`set -u` (Unset Variables):** Causes the script to fail if it tries to use a variable that hasn't been defined.
-   **`set -o pipefail`:** Ensures that if any command in a pipeline (e.g., `cmd1 | cmd2`) fails, the entire pipeline return code is non-zero.

Example Script (`strict_demo.sh`):
```bash
#!/bin/bash
set -euo pipefail

echo "Strict mode is active. Script will fail on undefined variables or errors."
```

---

## 🔐 Task 4: Variable Scoping
### `local_demo.sh`
Demonstrates why the `local` keyword is critical in functions to prevent global variable "leaks."

```bash
#!/bin/bash

local_var_func() {
    local my_var="I am local"
    echo "Inside: $my_var"
}

local_var_func
echo "Outside: $my_var" # This will be empty
```

---

## 🚀 Task 5: Ultimate System Info Reporter
### `system_info.sh`
A comprehensive script combining everything learned: functions, strict mode, and command-line tools.

```bash
#!/bin/bash
set -euo pipefail

print_os_info() {
    echo "--- Hostname & OS Info ---"
    echo "Hostname: $(hostname)"
    echo "OS: $(grep '^PRETTY_NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '\"')"
}

print_uptime() {
    echo "--- System Uptime ---"
    uptime -p
}

print_disk_usage() {
    echo "--- Disk Usage (Top 5) ---"
    df -h | head -n 6
}

main() {
    echo "=========================================="
    echo "       SYSTEM INFORMATION REPORTER"
    echo "=========================================="
    print_os_info
    print_uptime
    print_disk_usage
    echo "=========================================="
}

main
```

---

## 💡 Key Learnings

1.  **Functions for Clean Code:** Wrapping logic in functions makes scripts much easier to read, maintain, and debug. It follows the DRY (Don't Repeat Yourself) principle.
2.  **Safety as a Standard:** Always using `set -euo pipefail` should be the first step in any script. It prevents silent failures that can lead to data loss or system instability.
3.  **Namespace Management:** The `local` keyword ensures that function variables don't accidentally overwrite global variables, making functions truly independent components.

---

## 🌟 Enhancement: Modular Scripting Architecture

For larger projects, consider these advanced patterns:
- **Library Files:** Keep your functions in a separate file (e.g., `utils.sh`) and "source" them using `. ./utils.sh`.
- **Main Wrapper:** Always use a `main()` function to control the execution flow.
- **Log Functions:** Create a dedicated function for logging with timestamps and levels (INFO, WARN, ERROR).
  ```bash
  log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
  }
  ```

---

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham #BashAdvanced #Automation #Linux
