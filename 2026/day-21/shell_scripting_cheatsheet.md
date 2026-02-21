# 🐚 Shell Scripting Cheat Sheet — The Definitive DevOps Reference

<div align="center">

![Bash](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)
![Lines](https://img.shields.io/badge/Lines-500+-purple?style=for-the-badge)
![90DaysOfDevOps](https://img.shields.io/badge/90DaysOfDevOps-Day_21-orange?style=for-the-badge)

*Your single-page Bash survival guide — from shebang to production-ready scripts.*

</div>

---

## ⚡ Quick Reference Table

> **Bookmark this section** — everything you need at a glance in 17 entries.

| # | Topic | Key Syntax | Example |
|:-:|-------|-----------|---------|
| 1 | Shebang | `#!/bin/bash` | First line of every script |
| 2 | Variable | `VAR="value"` | `NAME="DevOps"` |
| 3 | Argument | `$1`, `$2`, `$@` | `./script.sh arg1 arg2` |
| 4 | User Input | `read -p "prompt" VAR` | `read -p "Name: " NAME` |
| 5 | If | `if [ cond ]; then … fi` | `if [ -f file ]; then echo "exists"; fi` |
| 6 | Elif/Else | `elif [ cond ]; then … else` | `elif [ "$x" -gt 10 ]; then …` |
| 7 | Case | `case $VAR in pattern) … esac` | `case $1 in start) …;; esac` |
| 8 | For loop | `for i in list; do … done` | `for i in 1 2 3; do echo $i; done` |
| 9 | While loop | `while [ cond ]; do … done` | `while [ $i -le 5 ]; do …; done` |
| 10 | Until loop | `until [ cond ]; do … done` | `until [ $i -gt 5 ]; do …; done` |
| 11 | Function | `name() { … }` | `greet() { echo "Hi $1"; }` |
| 12 | Grep | `grep pattern file` | `grep -i "error" app.log` |
| 13 | Awk | `awk '{print $N}' file` | `awk -F: '{print $1}' /etc/passwd` |
| 14 | Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |
| 15 | Exit code | `$?` | `echo $?  # 0 = success` |
| 16 | Strict mode | `set -euo pipefail` | Put at top of every production script |
| 17 | Trap | `trap 'cmd' SIGNAL` | `trap 'rm -f /tmp/lock' EXIT` |

---

## 📖 Table of Contents

1. [🔤 Basics](#-1-basics)
2. [⚖️ Operators & Conditionals](#%EF%B8%8F-2-operators--conditionals)
3. [🔄 Loops](#-3-loops)
4. [🧩 Functions](#-4-functions)
5. [📝 Text Processing Commands](#-5-text-processing-commands)
6. [💡 Useful Patterns & One-Liners](#-6-useful-patterns--one-liners)
7. [🛡️ Error Handling & Debugging](#%EF%B8%8F-7-error-handling--debugging)

---

## 🔤 1. Basics

### 1.1 Shebang (`#!`)

The **shebang** tells the OS which interpreter to use for the script.

```bash
#!/bin/bash          # Use the Bash interpreter
#!/usr/bin/env bash  # More portable — finds bash in $PATH
```

> 💡 **Why it matters:** Without a shebang, the script may run with the default shell (e.g., `sh`), which may lack Bash-specific features like arrays and `[[ ]]`.

---

### 1.2 Running a Script

```bash
# Method 1: Make executable and run directly
chmod +x script.sh   # Add execute permission (one-time)
./script.sh           # Run from current directory

# Method 2: Explicitly invoke with bash
bash script.sh        # No execute permission needed

# Method 3: Source it (runs in current shell — variables persist)
source script.sh
. script.sh           # Shorthand for source
```

| Method | New Subshell? | Needs `chmod`? | Variables Persist? |
|--------|:------------:|:--------------:|:-----------------:|
| `./script.sh` | ✅ | ✅ | ❌ |
| `bash script.sh` | ✅ | ❌ | ❌ |
| `source script.sh` | ❌ | ❌ | ✅ |

---

### 1.3 Comments

```bash
# This is a single-line comment

echo "Hello"  # This is an inline comment

# Multi-line comments (heredoc trick — not executed):
: <<'COMMENT'
Everything here
is ignored by the interpreter.
COMMENT
```

---

### 1.4 Variables

```bash
# Declaring variables (NO spaces around '=')
NAME="DevOps"
COUNT=42
FILES=$(ls *.txt)      # Command substitution
TODAY=$(date +%F)       # Store today's date

# Using variables
echo $NAME              # Works, but not recommended
echo "$NAME"            # ✅ Always quote — prevents word splitting
echo "${NAME}_user"     # ✅ Use braces when appending text
echo '$NAME'            # Prints literally: $NAME (single quotes)

# Read-only variable
readonly PI=3.14159
# PI=3.14  # This would throw an error

# Unsetting a variable
unset NAME
```

> ⚠️ **Golden Rule:** Always double-quote your variables: `"$VAR"`. This prevents bugs from word splitting and globbing.

#### Variable Scope Quick Reference

| Type | Syntax | Scope |
|------|--------|-------|
| Local | `VAR="value"` | Current shell only |
| Export | `export VAR="value"` | Current shell + child processes |
| Function-local | `local VAR="value"` | Within function only |
| Read-only | `readonly VAR="value"` | Cannot be changed or unset |

---

### 1.5 Reading User Input

```bash
# Basic read
read -p "Enter your name: " USERNAME
echo "Hello, $USERNAME!"

# Silent input (for passwords)
read -sp "Enter password: " PASSWORD
echo    # print newline after silent read

# Read with timeout (5 seconds)
read -t 5 -p "Quick! Enter value: " QUICK_VAL

# Read with default value
read -p "Port [8080]: " PORT
PORT=${PORT:-8080}      # Use 8080 if empty

# Read into an array
read -a COLORS -p "Enter colors (space-separated): "
echo "First color: ${COLORS[0]}"
```

---

### 1.6 Command-Line Arguments

```bash
#!/bin/bash
echo "Script name:      $0"
echo "First argument:   $1"
echo "Second argument:  $2"
echo "All arguments:    $@"    # Each arg as separate word
echo "All (single str): $*"    # All args as one string
echo "Number of args:   $#"
echo "Last exit code:   $?"
echo "Script PID:       $$"
echo "Last bg PID:      $!"
```

**Example run:**
```bash
$ ./info.sh hello world
Script name:      ./info.sh
First argument:   hello
Second argument:  world
All arguments:    hello world
Number of args:   2
```

#### Special Parameters Summary

| Parameter | Meaning |
|-----------|---------|
| `$0` | Script name / path |
| `$1`–`$9` | Positional arguments 1–9 |
| `${10}` | 10th argument and beyond (use braces) |
| `$#` | Number of arguments |
| `$@` | All arguments (preserves quoting) ✅ |
| `$*` | All arguments (as single string) |
| `$?` | Exit code of last command |
| `$$` | PID of current script |
| `$!` | PID of last background process |

---

## ⚖️ 2. Operators & Conditionals

### 2.1 String Comparisons

> Use `[ ]` (POSIX) or `[[ ]]` (Bash-enhanced, preferred).

```bash
STR1="hello"
STR2="world"

# Equality / Inequality
[[ "$STR1" == "$STR2" ]]   # false (Bash-style)
[  "$STR1"  = "$STR2"  ]   # false (POSIX-style)
[[ "$STR1" != "$STR2" ]]   # true

# Empty / Non-empty checks
[[ -z "$STR1" ]]            # true if STR1 is EMPTY
[[ -n "$STR1" ]]            # true if STR1 is NOT empty

# Pattern matching (Bash only — no quotes on pattern!)
[[ "$STR1" == h* ]]         # true — glob pattern match
[[ "$STR1" =~ ^hel ]]       # true — regex match
```

| Operator | Meaning | Example |
|----------|---------|---------|
| `=` / `==` | Equal | `[ "$a" = "$b" ]` |
| `!=` | Not equal | `[ "$a" != "$b" ]` |
| `-z` | Is empty (zero length) | `[ -z "$a" ]` |
| `-n` | Is non-empty | `[ -n "$a" ]` |
| `<` | Less than (lexicographic, use `[[ ]]`) | `[[ "$a" < "$b" ]]` |
| `>` | Greater than (lexicographic, use `[[ ]]`) | `[[ "$a" > "$b" ]]` |

---

### 2.2 Integer Comparisons

> **Inside `[ ]`** — use flags. **Inside `(( ))` ** — use symbols.

```bash
A=10
B=20

# Using test brackets
[ "$A" -eq "$B" ]    # Equal
[ "$A" -ne "$B" ]    # Not equal
[ "$A" -lt "$B" ]    # Less than        → true
[ "$A" -gt "$B" ]    # Greater than
[ "$A" -le "$B" ]    # Less or equal
[ "$A" -ge "$B" ]    # Greater or equal

# Using arithmetic evaluation (cleaner for math)
(( A == B ))
(( A != B ))
(( A <  B ))
(( A >  B ))
(( A <= B ))
(( A >= B ))
```

| Test Flag | `(( ))` Equivalent | Meaning |
|-----------|-------------------|---------|
| `-eq` | `==` | Equal |
| `-ne` | `!=` | Not equal |
| `-lt` | `<` | Less than |
| `-gt` | `>` | Greater than |
| `-le` | `<=` | Less than or equal |
| `-ge` | `>=` | Greater than or equal |

---

### 2.3 File Test Operators

```bash
FILE="/etc/passwd"

[ -f "$FILE" ]   # Is a regular file
[ -d "$FILE" ]   # Is a directory
[ -e "$FILE" ]   # Exists (file or directory)
[ -r "$FILE" ]   # Is readable
[ -w "$FILE" ]   # Is writable
[ -x "$FILE" ]   # Is executable
[ -s "$FILE" ]   # Exists and is NOT empty (size > 0)
[ -L "$FILE" ]   # Is a symbolic link
[ -p "$FILE" ]   # Is a named pipe
[ -S "$FILE" ]   # Is a socket

# Compare two files
[ "$F1" -nt "$F2" ]   # F1 is newer than F2
[ "$F1" -ot "$F2" ]   # F1 is older than F2
```

| Operator | Tests For |
|----------|-----------|
| `-f` | Regular file |
| `-d` | Directory |
| `-e` | Existence |
| `-r` | Readable |
| `-w` | Writable |
| `-x` | Executable |
| `-s` | Non-empty file |
| `-L` | Symlink |
| `-nt` | Newer than |
| `-ot` | Older than |

---

### 2.4 `if`, `elif`, `else`

```bash
#!/bin/bash
SCORE=85

if [ "$SCORE" -ge 90 ]; then
    echo "Grade: A 🏆"
elif [ "$SCORE" -ge 80 ]; then
    echo "Grade: B 👍"
elif [ "$SCORE" -ge 70 ]; then
    echo "Grade: C"
else
    echo "Grade: F ❌"
fi
# Output: Grade: B 👍
```

**One-liner style:**
```bash
[ -f "/tmp/lockfile" ] && echo "Locked" || echo "Not locked"
```

---

### 2.5 Logical Operators

```bash
# AND (&&) — both must be true
if [[ -f "$FILE" && -r "$FILE" ]]; then
    echo "File exists and is readable"
fi

# OR (||) — at least one must be true
if [[ -z "$USER" || "$USER" == "root" ]]; then
    echo "No user set, or running as root"
fi

# NOT (!) — negation
if [[ ! -d "/tmp/mydir" ]]; then
    echo "Directory does not exist"
fi

# Combining with multiple brackets (POSIX)
if [ -f "$FILE" ] && [ -r "$FILE" ]; then
    echo "File exists and is readable"
fi
```

| Operator | Meaning | Context |
|----------|---------|---------|
| `&&` | Logical AND | `[[ ]]`, command chaining |
| `\|\|` | Logical OR | `[[ ]]`, command chaining |
| `!` | Logical NOT | `[[ ! condition ]]` |
| `-a` | AND (deprecated) | `[ cond1 -a cond2 ]` |
| `-o` | OR (deprecated) | `[ cond1 -o cond2 ]` |

---

### 2.6 Case Statements

```bash
#!/bin/bash
read -p "Enter environment (dev/staging/prod): " ENV

case "$ENV" in
    dev|development)
        echo "🔧 Deploying to DEVELOPMENT"
        URL="http://localhost:3000"
        ;;
    staging|stg)
        echo "🧪 Deploying to STAGING"
        URL="https://staging.example.com"
        ;;
    prod|production)
        echo "🚀 Deploying to PRODUCTION"
        URL="https://example.com"
        ;;
    *)
        echo "❌ Unknown environment: $ENV"
        exit 1
        ;;
esac

echo "Target URL: $URL"
```

> 💡 **Use `case` instead of long if-elif chains** — it's faster to read and handles pattern matching naturally.

---

## 🔄 3. Loops

### 3.1 `for` Loop

#### List-based
```bash
# Iterate over explicit values
for COLOR in red green blue; do
    echo "Color: $COLOR"
done

# Iterate over a range
for i in {1..5}; do
    echo "Number: $i"
done

# Iterate with step
for i in {0..20..5}; do
    echo "Step: $i"   # 0, 5, 10, 15, 20
done

# Iterate over command output
for USER in $(cut -d: -f1 /etc/passwd | head -5); do
    echo "User: $USER"
done
```

#### C-style
```bash
for (( i=1; i<=5; i++ )); do
    echo "Iteration: $i"
done
```

---

### 3.2 `while` Loop

```bash
# Basic counter
COUNT=1
while [ "$COUNT" -le 5 ]; do
    echo "Count: $COUNT"
    ((COUNT++))
done

# Infinite loop (with break)
while true; do
    read -p "Enter 'quit' to exit: " INPUT
    [ "$INPUT" = "quit" ] && break
done
```

---

### 3.3 `until` Loop

Runs **until** the condition becomes **true** (opposite of `while`).

```bash
COUNT=1
until [ "$COUNT" -gt 5 ]; do
    echo "Count: $COUNT"
    ((COUNT++))
done
```

---

### 3.4 Loop Control — `break` & `continue`

```bash
# break — exit the loop entirely
for i in {1..10}; do
    [ "$i" -eq 6 ] && break
    echo "$i"   # Prints 1 through 5
done

# continue — skip current iteration
for i in {1..10}; do
    [ "$((i % 2))" -eq 0 ] && continue
    echo "$i"   # Prints only odd numbers: 1, 3, 5, 7, 9
done

# break N — break out of N nested loops
for i in {1..3}; do
    for j in {1..3}; do
        [ "$j" -eq 2 ] && break 2   # Breaks both loops
        echo "$i-$j"
    done
done
# Output: 1-1
```

---

### 3.5 Looping Over Files

```bash
# All .log files in current directory
for FILE in *.log; do
    [ -f "$FILE" ] || continue     # Skip if no match (nullglob safety)
    echo "Processing: $FILE ($(wc -l < "$FILE") lines)"
done

# Recursively find and process files
find /var/log -name "*.log" -type f | while read -r FILE; do
    echo "Found: $FILE"
done

# Using globstar (recursive glob)
shopt -s globstar
for FILE in /var/log/**/*.log; do
    echo "$FILE"
done
```

---

### 3.6 Reading Lines from File / Command Output

```bash
# Read file line by line (recommended)
while IFS= read -r LINE; do
    echo "Line: $LINE"
done < /etc/hosts

# Read from command output via process substitution
while IFS= read -r LINE; do
    echo "$LINE"
done < <(grep "error" /var/log/syslog)

# Read CSV with custom delimiter
while IFS=',' read -r NAME AGE CITY; do
    echo "$NAME is $AGE years old, lives in $CITY"
done < data.csv

# Read with line numbers
LINENUM=0
while IFS= read -r LINE; do
    ((LINENUM++))
    echo "$LINENUM: $LINE"
done < input.txt
```

> ⚠️ **Pipeline pitfall:** `cat file | while read line` runs in a subshell — variables set inside the loop **won't persist**. Use `while read … done < file` instead.

---

## 🧩 4. Functions

### 4.1 Defining a Function

```bash
# Style 1: Recommended
greet() {
    echo "Hello, $1! Welcome to $2."
}

# Style 2: Using 'function' keyword (Bash-only)
function greet {
    echo "Hello, $1! Welcome to $2."
}
```

---

### 4.2 Calling a Function

```bash
greet "Rameez" "DevOps"
# Output: Hello, Rameez! Welcome to DevOps.

# Store function output in a variable
RESULT=$(greet "Rameez" "DevOps")
echo "$RESULT"
```

---

### 4.3 Passing Arguments to Functions

Inside a function, `$1`, `$2`, etc. refer to the **function's** arguments (not the script's).

```bash
deploy() {
    local APP="$1"
    local ENV="$2"
    local VERSION="${3:-latest}"   # Default to 'latest'
    
    echo "🚀 Deploying $APP v$VERSION to $ENV"
}

deploy "myapp" "production" "2.1.0"
deploy "myapp" "staging"    # Uses default: latest
```

---

### 4.4 Return Values

```bash
# 'return' sets the exit code (0–255 only)
is_even() {
    if (( $1 % 2 == 0 )); then
        return 0    # success/true
    else
        return 1    # failure/false
    fi
}

if is_even 42; then
    echo "42 is even"
fi

# Use 'echo' to return actual data
get_hostname() {
    echo "$(hostname -f)"
}
HOST=$(get_hostname)
echo "Running on: $HOST"

# Returning multiple values
get_disk_info() {
    local USED=$(df -h / | awk 'NR==2 {print $3}')
    local AVAIL=$(df -h / | awk 'NR==2 {print $4}')
    echo "$USED $AVAIL"
}
read -r USED AVAIL <<< "$(get_disk_info)"
echo "Used: $USED, Available: $AVAIL"
```

---

### 4.5 Local Variables

```bash
GLOBAL_VAR="I'm global"

my_function() {
    local LOCAL_VAR="I'm local"
    GLOBAL_VAR="Modified globally"   # Modifies the global!
    echo "Inside: LOCAL_VAR=$LOCAL_VAR"
}

my_function
echo "Outside: GLOBAL_VAR=$GLOBAL_VAR"   # "Modified globally"
echo "Outside: LOCAL_VAR=$LOCAL_VAR"       # Empty — local is gone
```

> 💡 **Best Practice:** Always use `local` inside functions to avoid accidentally overwriting global variables.

---

## 📝 5. Text Processing Commands

### 5.1 `grep` — Search Patterns in Files

```bash
# Basic search
grep "error" /var/log/syslog

# Common flags
grep -i "error" file.log        # Case insensitive
grep -r "TODO" ./src/           # Recursive search in directory
grep -c "error" file.log        # Count matches
grep -n "error" file.log        # Show line numbers
grep -v "debug" file.log        # Invert — show NON-matching lines
grep -l "error" *.log           # List only filenames with matches
grep -w "error" file.log        # Match whole word only

# Extended regex (-E = egrep)
grep -E "error|warning|critical" file.log    # OR patterns
grep -E "^[0-9]{4}-" file.log               # Lines starting with year

# Context lines
grep -B 3 "error" file.log     # 3 lines Before match
grep -A 5 "error" file.log     # 5 lines After match
grep -C 2 "error" file.log     # 2 lines Context (before + after)

# Count unique error types
grep -oE "ERROR: [^]]*" app.log | sort | uniq -c | sort -rn
```

---

### 5.2 `awk` — Column Processing & Pattern Actions

```bash
# Print specific columns
awk '{print $1, $3}' data.txt          # 1st and 3rd column
awk '{print $NF}' data.txt             # Last column
awk '{print NR, $0}' data.txt          # Line number + entire line

# Custom field separator
awk -F: '{print $1, $7}' /etc/passwd   # Username and shell
awk -F',' '{print $2}' data.csv        # 2nd CSV column

# Pattern matching
awk '/error/ {print $0}' log.txt       # Lines containing "error"
awk '$3 > 100 {print $1, $3}' data.txt # Where 3rd col > 100

# BEGIN and END blocks
awk 'BEGIN {print "=== Report ==="} 
     {sum += $2} 
     END {print "Total:", sum}' data.txt

# Built-in variables
# NR = record number, NF = number of fields
# FS = field separator, OFS = output field separator
awk -F: 'NR<=5 {print NR": "$1}' /etc/passwd  # First 5 users

# Format output
awk -F: '{printf "%-15s %s\n", $1, $7}' /etc/passwd
```

---

### 5.3 `sed` — Stream Editor

```bash
# Substitution (first occurrence per line)
sed 's/old/new/' file.txt         

# Substitution (all occurrences per line = global)
sed 's/old/new/g' file.txt

# In-place edit (modifies the file)
sed -i 's/old/new/g' file.txt

# In-place with backup
sed -i.bak 's/old/new/g' file.txt    # Creates file.txt.bak

# Delete lines
sed '5d' file.txt                   # Delete line 5
sed '/^#/d' file.txt                # Delete lines starting with #
sed '/^$/d' file.txt                # Delete empty lines

# Print specific lines
sed -n '10,20p' file.txt            # Print lines 10–20
sed -n '/start/,/end/p' file.txt    # Print between patterns

# Insert/Append
sed '3i\New line before line 3' file.txt   # Insert before line 3
sed '3a\New line after line 3' file.txt    # Append after line 3

# Multiple operations
sed -e 's/foo/bar/g' -e 's/baz/qux/g' file.txt
```

---

### 5.4 `cut` — Extract Columns

```bash
# By delimiter and field
cut -d: -f1 /etc/passwd             # 1st field, colon delimiter
cut -d',' -f1,3 data.csv            # 1st and 3rd CSV fields
cut -d: -f1-3 /etc/passwd           # Fields 1 through 3

# By character position
cut -c1-10 file.txt                 # First 10 characters
cut -c5- file.txt                   # From 5th character to end
```

---

### 5.5 `sort` — Sort Lines

```bash
sort file.txt                       # Alphabetical (default)
sort -n file.txt                    # Numerical
sort -r file.txt                    # Reverse
sort -u file.txt                    # Unique (remove duplicates)
sort -t: -k3 -n /etc/passwd        # Sort by 3rd field, numeric, colon delim
sort -h sizes.txt                   # Human-readable sizes (1K, 2M, 3G)
sort -k2,2 -n data.txt             # Sort by 2nd column numerically
```

---

### 5.6 `uniq` — Deduplicate

> ⚠️ `uniq` only removes **adjacent** duplicates — always `sort` first!

```bash
sort file.txt | uniq                # Remove duplicates
sort file.txt | uniq -c             # Count occurrences
sort file.txt | uniq -d             # Show only duplicates
sort file.txt | uniq -u             # Show only unique lines
sort file.txt | uniq -c | sort -rn  # Top occurrences
```

---

### 5.7 `tr` — Translate / Delete Characters

```bash
# Case conversion
echo "Hello World" | tr 'a-z' 'A-Z'     # HELLO WORLD
echo "Hello World" | tr 'A-Z' 'a-z'     # hello world
echo "Hello World" | tr '[:lower:]' '[:upper:]'  # HELLO WORLD

# Delete characters
echo "Hello 123 World" | tr -d '0-9'    # Hello  World
echo "Hello   World" | tr -s ' '        # Hello World (squeeze spaces)

# Replace characters
echo "/var/log/syslog" | tr '/' '\n'     # One path component per line
echo "hello:world" | tr ':' '\t'         # Replace colon with tab
```

---

### 5.8 `wc` — Word / Line / Character Count

```bash
wc file.txt                # lines, words, chars
wc -l file.txt             # Line count only
wc -w file.txt             # Word count only
wc -c file.txt             # Byte count
wc -m file.txt             # Character count (multi-byte safe)
wc -l *.log                # Line count for each file + total

# Common patterns
find . -name "*.sh" | wc -l              # Count shell scripts
cat access.log | wc -l                    # Total requests
grep -c "ERROR" app.log                   # Error count (faster)
```

---

### 5.9 `head` & `tail` — View File Portions

```bash
# head — first N lines
head file.txt              # First 10 lines (default)
head -n 20 file.txt        # First 20 lines
head -c 100 file.txt       # First 100 bytes

# tail — last N lines
tail file.txt              # Last 10 lines (default)
tail -n 20 file.txt        # Last 20 lines
tail -n +5 file.txt        # Everything from line 5 onward

# Follow mode — watch file grow in real time
tail -f /var/log/syslog                  # Follow new lines
tail -f /var/log/syslog | grep "error"   # Follow + filter
tail -F /var/log/syslog                  # Follow even if rotated

# Combine head and tail for a specific range
sed -n '100,200p' file.txt               # Lines 100–200
head -n 200 file.txt | tail -n 100       # Same result
```

---

## 💡 6. Useful Patterns & One-Liners

> 🔥 **10 battle-tested one-liners** for everyday DevOps work.

### 1️⃣ Find and Delete Files Older Than N Days
```bash
find /var/log -name "*.log" -type f -mtime +30 -delete
# Or with confirmation:
find /tmp -type f -mtime +7 -exec rm -v {} \;
```

### 2️⃣ Count Lines in All Log Files
```bash
find /var/log -name "*.log" -exec wc -l {} + | sort -n | tail
```

### 3️⃣ Replace a String Across Multiple Files
```bash
grep -rl "old_string" ./src/ | xargs sed -i 's/old_string/new_string/g'
# Or with find:
find . -type f -name "*.conf" -exec sed -i 's/old/new/g' {} +
```

### 4️⃣ Check If a Service Is Running
```bash
systemctl is-active --quiet nginx && echo "✅ Running" || echo "❌ Stopped"
# Alternative with pgrep:
pgrep -x nginx > /dev/null && echo "Running" || echo "Not running"
```

### 5️⃣ Monitor Disk Usage with Alert
```bash
USAGE=$(df -h / | awk 'NR==2 {gsub(/%/,""); print $5}')
[ "$USAGE" -gt 80 ] && echo "⚠️ ALERT: Disk usage at ${USAGE}%!" | mail -s "Disk Alert" admin@example.com
```

### 6️⃣ Parse JSON from Command Line
```bash
# Using jq (preferred)
curl -s https://api.github.com/repos/torvalds/linux | jq '.stargazers_count'

# Without jq — using grep + sed
echo '{"name":"devops","count":42}' | grep -oP '"count":\K[0-9]+'

# Pretty-print JSON
echo '{"a":1,"b":2}' | python3 -m json.tool
```

### 7️⃣ Tail a Log and Filter for Errors in Real Time
```bash
tail -f /var/log/app.log | grep --line-buffered -iE "error|critical|fatal"
# With timestamp highlighting:
tail -f /var/log/app.log | awk '/ERROR/ {print "\033[31m" $0 "\033[0m"; next} {print}'
```

### 8️⃣ List Top 10 Largest Files in a Directory
```bash
find /var -type f -exec du -h {} + 2>/dev/null | sort -rh | head -10
# Or more efficiently:
du -ah /var 2>/dev/null | sort -rh | head -20
```

### 9️⃣ Batch Rename Files
```bash
# Rename all .txt to .md
for FILE in *.txt; do
    mv "$FILE" "${FILE%.txt}.md"
done

# Add prefix to all files
for FILE in *.log; do
    mv "$FILE" "archive_${FILE}"
done
```

### 🔟 Quick System Health Check
```bash
echo "=== System Health ==="
echo "Uptime:     $(uptime -p)"
echo "Load:       $(cat /proc/loadavg | awk '{print $1, $2, $3}')"
echo "Memory:     $(free -h | awk 'NR==2 {printf "%s/%s (%.1f%%)", $3, $2, $3/$2*100}')"
echo "Disk (/):   $(df -h / | awk 'NR==2 {print $3"/"$2" ("$5" used)"}')"
echo "Logged in:  $(who | wc -l) users"
echo "Processes:  $(ps aux | wc -l)"
```

---

## 🛡️ 7. Error Handling & Debugging

### 7.1 Exit Codes

Every command returns an exit code. `0` = success, anything else = failure.

```bash
# Check exit code of last command
ls /tmp
echo "Exit code: $?"   # 0 (success)

ls /nonexistent 2>/dev/null
echo "Exit code: $?"   # 2 (failure)

# Exit script with custom code
exit 0    # Success
exit 1    # General error
exit 2    # Misuse of shell command
exit 127  # Command not found
```

| Code | Meaning |
|------|---------|
| `0` | Success |
| `1` | General error |
| `2` | Misuse of shell builtin |
| `126` | Permission denied |
| `127` | Command not found |
| `128+N` | Fatal signal N (e.g., 130 = Ctrl+C) |
| `255` | Exit code out of range |

---

### 7.2 `set -e` — Exit on Error

```bash
#!/bin/bash
set -e    # Script will exit immediately if ANY command fails

echo "Step 1: Creating directory"
mkdir /tmp/myapp

echo "Step 2: Copying files"
cp important.conf /tmp/myapp/    # If this fails, script stops here

echo "Step 3: Done!"              # Only reached if Step 2 succeeded
```

---

### 7.3 `set -u` — Treat Unset Variables as Error

```bash
#!/bin/bash
set -u    # Error if you use an undefined variable

echo "$UNDEFINED_VAR"   # Script exits with: unbound variable error

# Use defaults to safely handle optional vars:
echo "${OPTIONAL_VAR:-default_value}"   # Won't error
```

---

### 7.4 `set -o pipefail` — Catch Errors in Pipes

```bash
#!/bin/bash
set -o pipefail

# Without pipefail: exit code = 0 (from wc)
# With pipefail:    exit code = 1 (from the failing grep)
grep "nonexistent" hugefile.txt | wc -l
echo "Exit code: $?"
```

> 🔐 **The Holy Trinity — Use this at the top of every production script:**
> ```bash
> #!/bin/bash
> set -euo pipefail
> ```

---

### 7.5 `set -x` — Debug Mode (Trace Execution)

```bash
#!/bin/bash
set -x    # Print each command before executing it

NAME="DevOps"
echo "Hello, $NAME"

# Output:
# + NAME=DevOps
# + echo 'Hello, DevOps'
# Hello, DevOps
```

**Enable/disable debugging for specific sections:**
```bash
#!/bin/bash

echo "Normal output"

set -x    # Turn ON debug
cp file1.txt /tmp/
mv /tmp/file1.txt /tmp/file2.txt
set +x    # Turn OFF debug

echo "Back to normal"
```

---

### 7.6 `trap` — Run Cleanup on Exit/Signals

```bash
#!/bin/bash
set -euo pipefail

TMPFILE=$(mktemp)

# Cleanup runs no matter how the script exits
trap 'rm -f "$TMPFILE"; echo "🧹 Cleaned up temp file"' EXIT

# Also handle specific signals
trap 'echo "⚠️ Caught SIGINT (Ctrl+C)"; exit 1' INT
trap 'echo "⚠️ Caught SIGTERM"; exit 1' TERM

echo "Working with temp file: $TMPFILE"
echo "important data" > "$TMPFILE"
# ... do work ...
# Cleanup happens automatically on exit
```

**Common trap patterns:**
```bash
# Cleanup temporary files
trap 'rm -rf /tmp/myapp_$$' EXIT

# Release a lock file
trap 'rm -f /var/lock/myscript.lock' EXIT

# Log script completion
trap 'echo "[$(date)] Script finished" >> /var/log/myscript.log' EXIT

# Graceful shutdown
trap 'echo "Shutting down..."; kill $(jobs -p) 2>/dev/null' EXIT
```

| Signal | Name | Default Action | Common Use |
|--------|------|---------------|------------|
| `EXIT` | Exit | — | Cleanup on any exit |
| `INT` | Interrupt (Ctrl+C) | Terminate | Graceful abort |
| `TERM` | Terminate | Terminate | Graceful shutdown |
| `HUP` | Hangup | Terminate | Reload config |
| `ERR` | Error (with `set -e`) | — | Error logging |
| `DEBUG` | Before each command | — | Tracing |

---

## 🎓 Best Practices Summary

```
┌──────────────────────────────────────────────────────────────────┐
│                    SHELL SCRIPTING BEST PRACTICES                │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. Always start with:  #!/bin/bash                             │
│                         set -euo pipefail                       │
│                                                                  │
│  2. Quote all variables:  "$VAR"  not  $VAR                     │
│                                                                  │
│  3. Use [[ ]] over [ ] for conditionals (Bash)                  │
│                                                                  │
│  4. Use local variables inside functions                        │
│                                                                  │
│  5. Always clean up with trap ... EXIT                          │
│                                                                  │
│  6. Validate inputs and show usage() on bad args                │
│                                                                  │
│  7. Use meaningful exit codes (0 = ok, 1 = error)               │
│                                                                  │
│  8. Prefer while read < file  over  cat file | while read       │
│                                                                  │
│  9. Use shellcheck to lint your scripts                         │
│                                                                  │
│  10. Comment the WHY, not the WHAT                              │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

<div align="center">

**📝 Created as part of Day 21 — [#90DaysOfDevOps](https://github.com/LondheShubham153/90DaysOfDevOps) Challenge 2026**

*Keep this cheat sheet bookmarked. The best reference guide is the one you wrote yourself.* ✨

</div>
