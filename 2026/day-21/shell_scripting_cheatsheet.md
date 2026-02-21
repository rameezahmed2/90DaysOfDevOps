# 🐚 Shell Scripting Cheat Sheet — The Definitive DevOps Quick-Reference

> **Author:** Rameez Ahmed  
> **Challenge:** [#90DaysOfDevOps](https://github.com/LondheShubham153/90DaysOfDevOps) — Day 21  
> **Date:** 2026-02-21  
> **Purpose:** A consolidated, practical reference for everyday shell scripting on the job.

---

## 📑 Table of Contents

| # | Section | Jump |
|---|---------|------|
| 0 | [Quick Reference Table](#-quick-reference-table) | ⚡ |
| 1 | [Basics](#1--basics) | 🔤 |
| 2 | [Operators & Conditionals](#2--operators--conditionals) | ⚖️ |
| 3 | [Loops](#3--loops) | 🔄 |
| 4 | [Functions](#4--functions) | 🧩 |
| 5 | [Text Processing Commands](#5--text-processing-commands) | 📝 |
| 6 | [Useful Patterns & One-Liners](#6--useful-patterns--one-liners) | 💡 |
| 7 | [Error Handling & Debugging](#7--error-handling--debugging) | 🛡️ |

---

## ⚡ Quick Reference Table

| Topic | Key Syntax | Example |
|-------|-----------|---------|
| **Shebang** | `#!/bin/bash` | First line of every script |
| **Variable** | `VAR="value"` | `NAME="DevOps"` |
| **Argument** | `$1`, `$2`, `$@` | `./script.sh arg1 arg2` |
| **If** | `if [ condition ]; then` | `if [ -f file ]; then echo "exists"; fi` |
| **For loop** | `for i in list; do` | `for i in 1 2 3; do echo $i; done` |
| **While loop** | `while [ cond ]; do` | `while read -r line; do echo "$line"; done < file` |
| **Function** | `name() { ... }` | `greet() { echo "Hi $1"; }` |
| **Grep** | `grep pattern file` | `grep -i "error" log.txt` |
| **Awk** | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| **Sed** | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |
| **Cut** | `cut -d',' -f1 file` | `cut -d':' -f1 /etc/passwd` |
| **Sort** | `sort [-n] [-r] [-u]` | `sort -rn scores.txt` |
| **Exit code** | `$?` | `echo $?  # 0 = success` |
| **Debug mode** | `set -x` | Place at top of script |
| **Strict mode** | `set -euo pipefail` | Recommended script header |
| **Trap** | `trap 'cmd' SIGNAL` | `trap 'rm -f /tmp/lock' EXIT` |

---

## 1. 🔤 Basics

### 1.1 Shebang (`#!/bin/bash`)

The **shebang** tells the OS which interpreter to use. Without it, the script runs in the current shell, which may not be Bash.

```bash
#!/bin/bash
# Always place this on line 1 of your scripts
```

> 💡 **Tip:** Use `#!/usr/bin/env bash` for better portability across systems where Bash may not live at `/bin/bash`.

### 1.2 Running a Script

```bash
# Method 1 — Make executable, then run
chmod +x script.sh
./script.sh

# Method 2 — Invoke directly with the interpreter
bash script.sh

# Method 3 — Source the script (runs in the current shell context)
source script.sh   # or:  . script.sh
```

| Method | New sub-shell? | Needs `chmod +x`? |
|--------|:--------------:|:-----------------:|
| `./script.sh` | ✅ | ✅ |
| `bash script.sh` | ✅ | ❌ |
| `source script.sh` | ❌ | ❌ |

### 1.3 Comments

```bash
# This is a single-line comment

echo "Hello"  # This is an inline comment

: '
This is a
multi-line comment block
(heredoc trick)
'
```

### 1.4 Variables

```bash
# Declaring & Using
NAME="DevOps"
echo "Welcome to $NAME"        # Double quotes → variable is expanded
echo 'Welcome to $NAME'        # Single quotes → literal string (no expansion)
echo "Path is: ${HOME}/scripts" # Braces for clarity / concatenation

# Read-only variable
readonly PI=3.14

# Unsetting a variable
unset NAME
```

> ⚠️ **No spaces** around `=` when assigning: `VAR="value"` ✅ · `VAR = "value"` ❌

### 1.5 Reading User Input

```bash
# Simple read
read -p "Enter your name: " USERNAME
echo "Hello, $USERNAME!"

# Silent read (useful for passwords)
read -sp "Enter password: " PASSWORD
echo

# Read with a timeout (5 seconds)
read -t 5 -p "Quick! Enter value: " FAST_INPUT
```

### 1.6 Command-line Arguments

```bash
#!/bin/bash
echo "Script name  : $0"
echo "First arg    : $1"
echo "Second arg   : $2"
echo "All args     : $@"
echo "All args (s) : $*"
echo "Arg count    : $#"
echo "Last exit    : $?"
echo "Script PID   : $$"
echo "Last bg PID  : $!"
```

**Example run:**
```
$ ./info.sh hello world
Script name  : ./info.sh
First arg    : hello
Second arg   : world
All args     : hello world
Arg count    : 2
Last exit    : 0
```

---

## 2. ⚖️ Operators & Conditionals

### 2.1 String Comparisons

```bash
STR="hello"

[ "$STR" = "hello" ]    # Equal
[ "$STR" != "world" ]   # Not equal
[ -z "$STR" ]           # True if string is empty (zero length)
[ -n "$STR" ]           # True if string is non-empty
```

> 💡 Always **double-quote** variables inside `[ ]` to prevent word-splitting errors.

### 2.2 Integer Comparisons

```bash
A=10; B=20

[ "$A" -eq "$B" ]   # Equal
[ "$A" -ne "$B" ]   # Not equal
[ "$A" -lt "$B" ]   # Less than
[ "$A" -gt "$B" ]   # Greater than
[ "$A" -le "$B" ]   # Less than or equal
[ "$A" -ge "$B" ]   # Greater than or equal
```

**Mnemonic cheatsheet:**

| Operator | Meaning | Mnemonic |
|----------|---------|----------|
| `-eq` | Equal | **eq**ual |
| `-ne` | Not equal | **n**ot **e**qual |
| `-lt` | Less than | **l**ess **t**han |
| `-gt` | Greater than | **g**reater **t**han |
| `-le` | Less or equal | **l**ess or **e**qual |
| `-ge` | Greater or equal | **g**reater or **e**qual |

### 2.3 File Test Operators

```bash
FILE="/etc/passwd"

[ -f "$FILE" ]   # Is a regular file
[ -d "$FILE" ]   # Is a directory
[ -e "$FILE" ]   # Exists (any type)
[ -r "$FILE" ]   # Is readable
[ -w "$FILE" ]   # Is writable
[ -x "$FILE" ]   # Is executable
[ -s "$FILE" ]   # Exists and is non-empty (size > 0)
[ -L "$FILE" ]   # Is a symbolic link
```

### 2.4 `if` / `elif` / `else`

```bash
#!/bin/bash
SCORE=85

if [ "$SCORE" -ge 90 ]; then
    echo "Grade: A 🌟"
elif [ "$SCORE" -ge 75 ]; then
    echo "Grade: B 👍"
elif [ "$SCORE" -ge 60 ]; then
    echo "Grade: C 🙂"
else
    echo "Grade: F 😟"
fi
```

### 2.5 Logical Operators

```bash
# AND (&&) — both conditions must be true
if [ -f "$FILE" ] && [ -r "$FILE" ]; then
    echo "File exists and is readable"
fi

# OR (||) — at least one condition must be true
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <arg1> <arg2>"
    exit 1
fi

# NOT (!) — negate a condition
if [ ! -d "/tmp/mydir" ]; then
    mkdir /tmp/mydir
fi
```

### 2.6 Case Statements

```bash
#!/bin/bash
read -p "Enter environment (dev/staging/prod): " ENV

case "$ENV" in
    dev|development)
        echo "🔧 Deploying to Development"
        ;;
    staging)
        echo "🧪 Deploying to Staging"
        ;;
    prod|production)
        echo "🚀 Deploying to Production"
        ;;
    *)
        echo "❌ Unknown environment: $ENV"
        exit 1
        ;;
esac
```

---

## 3. 🔄 Loops

### 3.1 `for` Loop

```bash
# List-based
for FRUIT in apple banana cherry; do
    echo "I like $FRUIT"
done

# Range-based (Bash brace expansion)
for i in {1..5}; do
    echo "Iteration $i"
done

# C-style
for ((i = 0; i < 5; i++)); do
    echo "Index: $i"
done
```

### 3.2 `while` Loop

```bash
COUNT=1
while [ "$COUNT" -le 5 ]; do
    echo "Count: $COUNT"
    ((COUNT++))
done
```

### 3.3 `until` Loop

Runs **until** the condition becomes true (opposite of `while`).

```bash
NUM=1
until [ "$NUM" -gt 5 ]; do
    echo "Number: $NUM"
    ((NUM++))
done
```

### 3.4 Loop Control — `break` & `continue`

```bash
# break — exit the loop early
for i in {1..10}; do
    [ "$i" -eq 6 ] && break
    echo "$i"
done
# Output: 1 2 3 4 5

# continue — skip the current iteration
for i in {1..5}; do
    [ "$i" -eq 3 ] && continue
    echo "$i"
done
# Output: 1 2 4 5
```

### 3.5 Looping Over Files

```bash
# Process all .log files in the current directory
for FILE in *.log; do
    [ -f "$FILE" ] || continue   # guard against zero matches
    echo "Processing: $FILE ($(wc -l < "$FILE") lines)"
done
```

### 3.6 Looping Over Command Output

```bash
# Read a file line-by-line (the safest way)
while IFS= read -r LINE; do
    echo ">> $LINE"
done < /etc/hostname

# Process command output line-by-line
df -h | while IFS= read -r LINE; do
    echo "$LINE"
done
```

> ⚠️ **Always use `while read`** instead of `for line in $(cat file)` — the latter breaks on whitespace.

---

## 4. 🧩 Functions

### 4.1 Defining a Function

```bash
# Syntax style 1 (POSIX-compatible ✅)
greet() {
    echo "Hello, $1!"
}

# Syntax style 2 (Bash-specific)
function greet {
    echo "Hello, $1!"
}
```

### 4.2 Calling a Function

```bash
greet "DevOps Engineer"
# Output: Hello, DevOps Engineer!
```

### 4.3 Passing Arguments

Function arguments use their own `$1`, `$2`, etc. — they shadow the script's arguments.

```bash
add() {
    echo "Sum: $(( $1 + $2 ))"
}
add 5 10
# Output: Sum: 15
```

### 4.4 Return Values

```bash
# return → sets exit status (0-255 only, for success/failure signalling)
is_even() {
    (( $1 % 2 == 0 )) && return 0 || return 1
}
is_even 4 && echo "Even" || echo "Odd"

# echo → returns actual data (capture with command substitution)
get_hostname() {
    echo "$(hostname)"
}
HOST=$(get_hostname)
echo "Host: $HOST"
```

> 💡 **Rule of thumb:** Use `return` for status codes, `echo` for data.

### 4.5 Local Variables

```bash
demo() {
    local MSG="I'm local"
    GLOBAL_MSG="I'm global"
    echo "Inside: $MSG"
}
demo
echo "Outside: $MSG"         # Empty — local variable is not visible
echo "Outside: $GLOBAL_MSG"  # "I'm global" — leaks to parent scope
```

---

## 5. 📝 Text Processing Commands

### 5.1 `grep` — Search Patterns

```bash
grep "error" logfile.txt           # Basic search
grep -i "error" logfile.txt        # Case-insensitive
grep -r "TODO" ./src/              # Recursive search in directory
grep -c "error" logfile.txt        # Count matching lines
grep -n "error" logfile.txt        # Show line numbers
grep -v "debug" logfile.txt        # Invert match (exclude "debug")
grep -E "error|warn" logfile.txt   # Extended regex (OR)
grep -w "fail" logfile.txt         # Match whole word only
grep -A2 -B1 "CRITICAL" log.txt   # Show 2 lines After, 1 Before match
```

### 5.2 `awk` — Column Processing

```bash
# Print specific columns
awk '{print $1, $3}' data.txt

# Custom field separator
awk -F: '{print $1}' /etc/passwd

# Pattern matching
awk '/error/ {print $0}' logfile.txt

# BEGIN / END blocks
awk 'BEGIN {print "=== Report ==="} {sum += $1} END {print "Total:", sum}' nums.txt

# Built-in variables
# NR = record (line) number, NF = number of fields
awk '{print NR": "$0" ("NF" fields)"}' data.txt
```

### 5.3 `sed` — Stream Editor

```bash
# Substitution (first occurrence per line)
sed 's/old/new/' file.txt

# Global substitution (all occurrences)
sed 's/old/new/g' file.txt

# In-place edit (modifies the file directly)
sed -i 's/old/new/g' file.txt

# In-place edit with backup
sed -i.bak 's/old/new/g' file.txt

# Delete lines matching a pattern
sed '/^#/d' config.txt        # Remove comment lines

# Delete specific line numbers
sed '5d' file.txt             # Delete line 5
sed '3,7d' file.txt           # Delete lines 3–7

# Print only matching lines (like grep)
sed -n '/pattern/p' file.txt
```

### 5.4 `cut` — Extract Columns

```bash
# By delimiter (comma) — extract field 1 and 3
cut -d',' -f1,3 data.csv

# By character position
cut -c1-10 file.txt

# Extract usernames from /etc/passwd
cut -d':' -f1 /etc/passwd
```

### 5.5 `sort`

```bash
sort file.txt                # Alphabetical
sort -n file.txt             # Numerical
sort -r file.txt             # Reverse
sort -u file.txt             # Unique (remove duplicates)
sort -t',' -k2 -n data.csv  # Sort CSV by 2nd column, numerically
sort -h sizes.txt            # Human-readable numbers (1K, 2M, 3G)
```

### 5.6 `uniq`

```bash
# Must sort first! uniq only removes consecutive duplicates
sort file.txt | uniq          # Deduplicate
sort file.txt | uniq -c       # Show count of each unique line
sort file.txt | uniq -d       # Show only duplicated lines
sort file.txt | uniq -u       # Show only unique (non-duplicated) lines
```

### 5.7 `tr` — Translate / Delete Characters

```bash
# Lowercase → Uppercase
echo "hello" | tr 'a-z' 'A-Z'     # HELLO

# Delete specific characters
echo "Hello 123" | tr -d '0-9'    # Hello

# Squeeze repeated characters
echo "Heeellooo" | tr -s 'eo'     # Helo

# Replace spaces with tabs
cat file.txt | tr ' ' '\t'
```

### 5.8 `wc` — Word Count

```bash
wc file.txt           # Lines, words, characters
wc -l file.txt        # Line count only
wc -w file.txt        # Word count only
wc -c file.txt        # Byte count
wc -m file.txt        # Character count (multi-byte aware)
```

### 5.9 `head` / `tail`

```bash
head -n 20 file.txt         # First 20 lines
tail -n 20 file.txt         # Last 20 lines
tail -f /var/log/syslog     # Follow — live stream of new lines
tail -n +5 file.txt         # Everything from line 5 onward

# Combine for a specific range (lines 10–20)
sed -n '10,20p' file.txt
```

---

## 6. 💡 Useful Patterns & One-Liners

### 🗑️ Find and delete files older than 30 days

```bash
find /var/log -type f -name "*.log" -mtime +30 -delete
```

### 📊 Count total lines in all `.log` files

```bash
find . -name "*.log" -exec cat {} + | wc -l
# Or simply:
wc -l *.log
```

### 🔁 Replace a string across multiple files

```bash
grep -rl "old_string" ./src/ | xargs sed -i 's/old_string/new_string/g'
```

### 🩺 Check if a service is running

```bash
systemctl is-active --quiet nginx && echo "✅ Nginx is running" || echo "❌ Nginx is down"
```

### 💾 Monitor disk usage with an alert

```bash
USAGE=$(df / | awk 'NR==2 {gsub(/%/,""); print $5}')
[ "$USAGE" -gt 80 ] && echo "⚠️ Disk usage critical: ${USAGE}%"
```

### 📄 Parse a JSON value with `jq` (or without)

```bash
# With jq
curl -s https://api.example.com/status | jq -r '.status'

# Without jq (quick-and-dirty)
grep -o '"status":"[^"]*"' response.json | cut -d'"' -f4
```

### 🔍 Tail a log and filter for errors in real time

```bash
tail -f /var/log/syslog | grep --line-buffered -i "error"
```

### 🧹 Remove all empty lines from a file

```bash
sed -i '/^$/d' file.txt
```

### 📋 List the top 10 largest files in a directory

```bash
find /path -type f -exec du -h {} + | sort -rh | head -10
```

### 🔐 Generate a random password

```bash
< /dev/urandom tr -dc 'A-Za-z0-9!@#$%' | head -c 16; echo
```

---

## 7. 🛡️ Error Handling & Debugging

### 7.1 Exit Codes

```bash
# Every command returns an exit code: 0 = success, non-zero = failure
ls /nonexistent 2>/dev/null
echo "Exit code: $?"   # 2

# Explicitly exit with a code
exit 0   # Success
exit 1   # General error
```

**Common exit codes:**

| Code | Meaning |
|------|---------|
| `0` | ✅ Success |
| `1` | ❌ General error |
| `2` | ⚠️ Misuse of shell command |
| `126` | 🔒 Permission denied / not executable |
| `127` | 🔍 Command not found |
| `130` | ⛔ Script terminated by Ctrl+C |

### 7.2 `set -e` — Exit on Error

```bash
#!/bin/bash
set -e   # Script will exit immediately if any command fails

cp important.conf /backup/
rm temp_file.txt
echo "All done!"  # Won't reach here if cp or rm fail
```

### 7.3 `set -u` — Treat Unset Variables as Errors

```bash
#!/bin/bash
set -u

echo "$UNDEFINED_VAR"   # Script exits with error instead of printing empty string
```

### 7.4 `set -o pipefail` — Catch Errors in Pipes

```bash
#!/bin/bash
set -o pipefail

# Without pipefail: exit code = exit code of LAST command in pipe
# With pipefail:    exit code = first non-zero exit code in the pipe

false | true
echo $?   # Returns 1 (from 'false'), not 0 (from 'true')
```

### 7.5 `set -x` — Debug Mode (Trace Execution)

```bash
#!/bin/bash
set -x   # Prints every command before execution (prefixed with +)

NAME="DevOps"
echo "Hello, $NAME"

# Output:
# + NAME=DevOps
# + echo 'Hello, DevOps'
# Hello, DevOps
```

> 💡 **Best practice header** — combine them all:
> ```bash
> #!/bin/bash
> set -euo pipefail
> ```

### 7.6 `trap` — Run Cleanup on Exit / Signals

```bash
#!/bin/bash
TMPFILE=$(mktemp)

cleanup() {
    echo "🧹 Cleaning up temporary files..."
    rm -f "$TMPFILE"
}

trap cleanup EXIT        # Runs cleanup when script exits (any reason)
trap cleanup SIGINT      # Runs cleanup on Ctrl+C
trap cleanup SIGTERM     # Runs cleanup on kill signal

echo "Working with $TMPFILE ..."
# ... script logic here ...

# cleanup() will be called automatically when the script ends
```

**Practical trap for lock files:**

```bash
LOCKFILE="/tmp/myscript.lock"

if [ -f "$LOCKFILE" ]; then
    echo "Script is already running!"
    exit 1
fi

trap 'rm -f "$LOCKFILE"' EXIT
touch "$LOCKFILE"

# ... your script logic ...
```

---

## 🎓 Final Tips

| # | Tip | Why |
|---|-----|-----|
| 1 | Always quote your variables: `"$VAR"` | Prevents word splitting and glob expansion |
| 2 | Use `[[ ]]` instead of `[ ]` in Bash | Safer — no word splitting, supports regex |
| 3 | Use `shellcheck` to lint scripts | Catches common bugs automatically |
| 4 | Use `set -euo pipefail` at the top | Makes scripts fail fast and loud |
| 5 | Prefer `$(command)` over backticks | Nestable, more readable |
| 6 | Use `"${VAR:-default}"` for defaults | Avoids errors with unset variables |
| 7 | Redirect stderr: `2>/dev/null` | Suppresses unwanted error output |
| 8 | Use `readonly` for constants | Prevents accidental overwriting |

---

> 📌 *This cheat sheet is part of the [#90DaysOfDevOps](https://github.com/LondheShubham153/90DaysOfDevOps) challenge. Keep learning, keep scripting!* 🚀
