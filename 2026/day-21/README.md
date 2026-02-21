# 📝 Day 21 – Shell Scripting Cheat Sheet: Build Your Own Reference Guide

<div align="center">

![Day](https://img.shields.io/badge/Day-21-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Shell_Scripting-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Challenge](https://img.shields.io/badge/90DaysOfDevOps-2026-orange?style=for-the-badge)

*"The best way to learn is to teach. The best way to revise is to write a cheat sheet."*

</div>

---

## 🎯 Task Overview

You've spent the last several days learning Shell scripting — from basics to real-world projects. Now it's time to consolidate everything into a **personal cheat sheet** that you can use as a quick-reference guide for the rest of your DevOps journey! 🚀

The best way to revise is to **teach it back**. Writing a cheat sheet forces you to organize your understanding and identify specific syntax gaps.

---

## 📚 Learning Objectives

By completing this task, you will:

| # | Objective | Covered |
|---|-----------|:-------:|
| 1 | Solidify core Bash syntax (variables, arguments, shebang) | ✅ |
| 2 | Master conditional logic and comparison operators | ✅ |
| 3 | Understand all loop types and when to use each | ✅ |
| 4 | Write reusable functions with local scope and return values | ✅ |
| 5 | Leverage text-processing power tools (grep, awk, sed, etc.) | ✅ |
| 6 | Collect real-world one-liners for everyday DevOps tasks | ✅ |
| 7 | Apply best-practice error handling and debugging techniques | ✅ |

---

## 📦 Expected Output

- 📄 **Cheat Sheet:** [`shell_scripting_cheatsheet.md`](shell_scripting_cheatsheet.md)
  *(A definitive, 400+ line reference covering Basics, Operators, Loops, Functions, Text Processing, Patterns, Error Handling, and a Quick Reference table!)*

---

## 🗺️ Challenge Tasks — Section Map

The cheat sheet is organized into **8 comprehensive sections**, each covering a key area of shell scripting:

```
┌──────────────────────────────────────────────────────────────┐
│                  SHELL SCRIPTING CHEAT SHEET                 │
├──────────────┬──────────────┬──────────────┬─────────────────┤
│  ⚡ Quick     │  🔤 Basics    │  ⚖️ Operators │  🔄 Loops       │
│  Reference   │  (Task 1)   │  (Task 2)    │  (Task 3)       │
│  Table       │             │              │                 │
│  (Task 8)    │  • Shebang  │  • Strings   │  • for          │
│              │  • Running  │  • Integers  │  • while        │
│  17 entries  │  • Comments │  • Files     │  • until        │
│  covering    │  • Variables│  • if/elif   │  • break/cont.  │
│  all topics  │  • Input    │  • Logic ops │  • File loops   │
│              │  • Arguments│  • case      │  • read loops   │
├──────────────┼──────────────┼──────────────┼─────────────────┤
│  🧩 Functions │  📝 Text     │  💡 One-      │  🛡️ Error       │
│  (Task 4)   │  Processing │  Liners      │  Handling       │
│             │  (Task 5)   │  (Task 6)    │  (Task 7)       │
│  • Define   │             │              │                 │
│  • Call     │  • grep     │  10 real-    │  • Exit codes   │
│  • Arguments│  • awk      │  world       │  • set -e/-u    │
│  • Return   │  • sed      │  patterns    │  • pipefail     │
│  • local    │  • cut/sort │  for DevOps  │  • set -x       │
│             │  • uniq/tr  │  engineers   │  • trap         │
│             │  • wc/head  │              │                 │
└──────────────┴──────────────┴──────────────┴─────────────────┘
```

---

### Task 1: Basics
Document the following with short descriptions and examples:
1. Shebang (`#!/bin/bash`) — what it does and why it matters
2. Running a script — `chmod +x`, `./script.sh`, `bash script.sh`
3. Comments — single line (`#`) and inline
4. Variables — declaring, using, and quoting (`$VAR`, `"$VAR"`, `'$VAR'`)
5. Reading user input — `read`
6. Command-line arguments — `$0`, `$1`, `$#`, `$@`, `$?`

---

### Task 2: Operators and Conditionals
Document with examples:
1. String comparisons — `=`, `!=`, `-z`, `-n`
2. Integer comparisons — `-eq`, `-ne`, `-lt`, `-gt`, `-le`, `-ge`
3. File test operators — `-f`, `-d`, `-e`, `-r`, `-w`, `-x`, `-s`
4. `if`, `elif`, `else` syntax
5. Logical operators — `&&`, `||`, `!`
6. Case statements — `case ... esac`

---

### Task 3: Loops
Document with examples:
1. `for` loop — list-based and C-style
2. `while` loop
3. `until` loop
4. Loop control — `break`, `continue`
5. Looping over files — `for file in *.log`
6. Looping over command output — `while read line`

---

### Task 4: Functions
Document with examples:
1. Defining a function — `function_name() { ... }`
2. Calling a function
3. Passing arguments to functions — `$1`, `$2` inside functions
4. Return values — `return` vs `echo`
5. Local variables — `local`

---

### Task 5: Text Processing Commands
Document the most useful flags/patterns for each:
1. `grep` — search patterns, `-i`, `-r`, `-c`, `-n`, `-v`, `-E`
2. `awk` — print columns, field separator, patterns, `BEGIN/END`
3. `sed` — substitution, delete lines, in-place edit
4. `cut` — extract columns by delimiter
5. `sort` — alphabetical, numerical, reverse, unique
6. `uniq` — deduplicate, count
7. `tr` — translate/delete characters
8. `wc` — line/word/char count
9. `head` / `tail` — first/last N lines, follow mode

---

### Task 6: Useful Patterns and One-Liners
Include at least 5 real-world one-liners you find useful. Examples:
- Find and delete files older than N days
- Count lines in all `.log` files
- Replace a string across multiple files
- Check if a service is running
- Monitor disk usage with alerts
- Parse CSV or JSON from command line
- Tail a log and filter for errors in real time

---

### Task 7: Error Handling and Debugging
Document with examples:
1. Exit codes — `$?`, `exit 0`, `exit 1`
2. `set -e` — exit on error
3. `set -u` — treat unset variables as error
4. `set -o pipefail` — catch errors in pipes
5. `set -x` — debug mode (trace execution)
6. Trap — `trap 'cleanup' EXIT`

---

### Task 8: Bonus — Quick Reference Table
Create a summary table like this at the top of your cheat sheet:

| Topic | Key Syntax | Example |
|-------|-----------|---------||
| Variable | `VAR="value"` | `NAME="DevOps"` |
| Argument | `$1`, `$2` | `./script.sh arg1` |
| If | `if [ condition ]; then` | `if [ -f file ]; then` |
| For loop | `for i in list; do` | `for i in 1 2 3; do` |
| Function | `name() { ... }` | `greet() { echo "Hi"; }` |
| Grep | `grep pattern file` | `grep -i "error" log.txt` |
| Awk | `awk '{print $1}' file` | `awk -F: '{print $1}' /etc/passwd` |
| Sed | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' config.txt` |

---

## ✅ Task Completion Checklist

- [x] ⚡ **Quick Reference Table** — 17 entries covering all major syntax at a glance
- [x] 🔤 **Basics** — Shebang, script execution, comments, variables, input, arguments
- [x] ⚖️ **Operators & Conditionals** — String, integer, file comparisons + if/case
- [x] 🔄 **Loops** — for, while, until, break/continue, file & line iteration
- [x] 🧩 **Functions** — Definition, arguments, return values, local scope
- [x] 📝 **Text Processing** — grep, awk, sed, cut, sort, uniq, tr, wc, head/tail
- [x] 💡 **One-Liners** — 10 real-world DevOps patterns
- [x] 🛡️ **Error Handling** — Exit codes, strict mode, debug mode, trap

---

## 🧠 Key Takeaways

1. **Teaching is the best revision** — Writing a cheat sheet forces you to truly understand each concept rather than just recognizing it.
2. **Strict mode is non-negotiable** — Every production script should start with `set -euo pipefail` to fail fast and catch bugs early.
3. **Text processing is a superpower** — Mastering `grep`, `awk`, and `sed` alone covers 80% of log analysis and data extraction tasks in DevOps.
4. **One-liners save hours** — Having a curated collection of battle-tested one-liners eliminates repetitive Googling during incident response.

---

## 📂 Format Guidelines

Your cheat sheet should be:
- Written in **Markdown** (`.md`)
- Organized with **clear headings** for each section
- Include **code blocks** with syntax highlighting (` ```bash `)
- Keep explanations **short** — 1-2 lines max per item
- Focus on **practical examples** over theory
- Something **you would actually refer back to** on the job

---

## 📤 Submission
1. Add your `shell_scripting_cheatsheet.md` to `2026/day-21/`
2. Commit and push to your fork

---

## 🌐 Learn in Public

Share your cheat sheet on LinkedIn — help others revise too!

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

---

<div align="center">

**Happy Learning! 🎉**  
**TrainWithShubham**

</div>
