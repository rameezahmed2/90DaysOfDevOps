# 📝 Day 28 Notes — Revision Day: Everything from Day 1 to Day 27

<div align="center">

![Day](https://img.shields.io/badge/Day-28-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Revision_&_Recap-green?style=for-the-badge)

*Stop, revise, solidify — no new concepts, just mastery of what you've learned*

</div>

---

## 📑 Table of Contents

1. [Task 1: Self-Assessment Checklist](#task-1-self-assessment-checklist)
2. [Task 2: Revisit My Weak Spots](#task-2-revisit-my-weak-spots)
3. [Task 3: Quick-Fire Questions](#task-3-quick-fire-questions)
4. [Task 4: Organize Your Work](#task-4-organize-your-work)
5. [Task 5: Teach It Back](#task-5-teach-it-back)

---

## Task 1: Self-Assessment Checklist

### Rating System

| Rating | Meaning |
|--------|---------|
| ✅ **Confident** | Can do it from memory, explain it to others |
| 🟡 **Need to revisit** | Understand the concept but need practice |
| ❌ **Haven't done yet** | Skipped or need to learn from scratch |

---

### Linux

| # | Skill | Rating | Notes |
|:-:|-------|:------:|-------|
| 1 | Navigate file system, create/move/delete files and directories | ✅ | `ls`, `cd`, `mkdir`, `cp`, `mv`, `rm` — second nature |
| 2 | Manage processes — list, kill, background/foreground | ✅ | `ps`, `top`, `kill`, `bg`, `fg`, `&`, `jobs` |
| 3 | Work with systemd — start, stop, enable, check status | ✅ | `systemctl start/stop/enable/status/restart` |
| 4 | Read and edit text files using vi/vim or nano | ✅ | Comfortable with `vim` (insert, command, save/quit) |
| 5 | Troubleshoot CPU, memory, disk — `top`, `free`, `df`, `du` | ✅ | Know what to look for: load avg, memory %, disk usage |
| 6 | Explain Linux file system hierarchy | ✅ | `/` root, `/etc` configs, `/var` logs, `/home` users, `/tmp` temp |
| 7 | Create users and groups, manage passwords | ✅ | `useradd`, `groupadd`, `passwd`, `usermod -aG` |
| 8 | Set file permissions using chmod (numeric and symbolic) | ✅ | `chmod 755 file`, `chmod u+x file`, understand rwx |
| 9 | Change file ownership with chown and chgrp | ✅ | `chown user:group file`, `chgrp group file` |
| 10 | Create and manage LVM volumes | 🟡 | Understand concept (PV → VG → LV) but need more hands-on practice |
| 11 | Check network connectivity — ping, curl, ss, dig | ✅ | Daily use for troubleshooting |
| 12 | Explain DNS resolution, IP addressing, subnets, ports | ✅ | Know DNS flow, CIDR notation, common ports (22, 80, 443) |

**Linux Score:** 11/12 Confident, 1/12 Need Practice

---

### Shell Scripting

| # | Skill | Rating | Notes |
|:-:|-------|:------:|-------|
| 1 | Write a script with variables, arguments, user input | ✅ | `$1`, `$2`, `$#`, `read`, variable assignment |
| 2 | Use if/elif/else and case statements | ✅ | Conditional logic, string/number comparisons |
| 3 | Write for, while, and until loops | ✅ | Iterating over lists, files, ranges |
| 4 | Define and call functions with arguments and return values | ✅ | `function_name() { }`, `$1` inside function, `return` |
| 5 | Use grep, awk, sed, sort, uniq for text processing | 🟡 | `grep` and `sort` strong; `awk` and `sed` need more practice |
| 6 | Handle errors with set -e, -u, -o pipefail, trap | ✅ | Know what each flag does and when to use trap |
| 7 | Schedule scripts with crontab | ✅ | `crontab -e`, cron syntax (min hour dom mon dow) |

**Shell Scripting Score:** 6/7 Confident, 1/7 Need Practice

---

### Git & GitHub

| # | Skill | Rating | Notes |
|:-:|-------|:------:|-------|
| 1 | Initialize a repo, stage, commit, view history | ✅ | `git init`, `git add`, `git commit`, `git log` |
| 2 | Create and switch branches | ✅ | `git branch`, `git switch -c`, `git switch` |
| 3 | Push to and pull from GitHub | ✅ | `git push -u origin main`, `git pull` |
| 4 | Explain clone vs fork | ✅ | Clone = copy to local; Fork = copy to your GitHub account |
| 5 | Merge branches — fast-forward vs merge commit | ✅ | FF when target hasn't moved; merge commit when both diverge |
| 6 | Rebase and explain when to use vs merge | ✅ | Rebase for linear history on feature branches; merge for shared |
| 7 | Use git stash and git stash pop | ✅ | Save WIP, switch branches, restore. Pop vs apply difference |
| 8 | Cherry-pick a commit from another branch | ✅ | `git cherry-pick <hash>` — surgical, for hotfixes |
| 9 | Explain squash merge vs regular merge | ✅ | Squash = 1 commit; Regular = all commits + merge commit |
| 10 | Use git reset (soft, mixed, hard) and git revert | ✅ | Reset rewrites history; Revert preserves history |
| 11 | Explain GitFlow, GitHub Flow, Trunk-Based | ✅ | GitFlow = enterprise; GitHub Flow = startups; Trunk = CI/CD |
| 12 | Use GitHub CLI for repos, PRs, issues | ✅ | `gh repo`, `gh pr`, `gh issue`, `gh run` |

**Git & GitHub Score:** 12/12 Confident

---

### Overall Summary

```
┌──────────────────────────────────────────────────────────────────┐
│                  SELF-ASSESSMENT SUMMARY                          │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Category          Confident    Need Practice    Total           │
│  ─────────────────────────────────────────────────                │
│  Linux              11            1              12              │
│  Shell Scripting     6            1               7              │
│  Git & GitHub       12            0              12              │
│  ──────────────────────────────────────────────                   │
│  TOTAL              29            2              31              │
│                                                                  │
│  Overall: 93.5% Confident ✅                                     │
│                                                                  │
│  Areas to improve:                                               │
│  🟡 LVM hands-on practice                                       │
│  🟡 Advanced awk/sed text processing                             │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## Task 2: Revisit My Weak Spots

### Weak Spot 1: LVM (Logical Volume Management)

**Why I flagged it:** I understand the concept (Physical Volumes → Volume Groups → Logical Volumes) but haven't done enough hands-on practice to be confident in production.

#### Quick Review

```
PHYSICAL DISK → Physical Volume (PV) → Volume Group (VG) → Logical Volume (LV) → Filesystem

      /dev/sdb              PV                    VG                LV           /mnt/data
      /dev/sdc              PV            ─────────┘                │
                                          (pool of storage)        EXT4/XFS
```

#### Key Commands Reviewed

```bash
# Create Physical Volume
sudo pvcreate /dev/sdb /dev/sdc

# Create Volume Group
sudo vgcreate my_vg /dev/sdb /dev/sdc

# Create Logical Volume (10GB)
sudo lvcreate -L 10G -n my_lv my_vg

# Create filesystem
sudo mkfs.ext4 /dev/my_vg/my_lv

# Mount it
sudo mount /dev/my_vg/my_lv /mnt/data

# Extend the logical volume (add 5GB)
sudo lvextend -L +5G /dev/my_vg/my_lv
sudo resize2fs /dev/my_vg/my_lv

# View status
sudo pvdisplay
sudo vgdisplay
sudo lvdisplay
```

#### Why LVM Matters in DevOps

| Without LVM | With LVM |
|------------|---------|
| Fixed partition sizes | Resize on the fly |
| Can't easily add storage | Add a new disk, extend the VG |
| Risky to resize (data loss) | Safe extension without downtime |
| One disk = one partition | Pool multiple disks into one volume |

**What I re-learned:** LVM's real power is in **elasticity** — in cloud/DevOps environments, you frequently need to add storage without downtime. LVM makes this a standard operation rather than a risky procedure.

---

### Weak Spot 2: Advanced `awk` and `sed`

**Why I flagged it:** I use `grep` daily, but `awk` and `sed` have more complex syntax that I haven't memorized.

#### `awk` — Quick Review

```bash
# Print specific columns
awk '{print $1, $3}' file.txt             # Print columns 1 and 3

# With a delimiter
awk -F: '{print $1, $7}' /etc/passwd      # Username and shell

# Conditional filtering
awk '$3 > 1000 {print $1}' /etc/passwd    # Users with UID > 1000

# Sum a column
awk '{sum += $3} END {print sum}' data.txt

# Count lines matching a pattern
awk '/error/ {count++} END {print count}' logfile.log

# Format output
awk -F, '{printf "%-20s %s\n", $1, $2}' data.csv
```

#### `sed` — Quick Review

```bash
# Find and replace (first occurrence per line)
sed 's/old/new/' file.txt

# Find and replace (ALL occurrences — global)
sed 's/old/new/g' file.txt

# Replace in-place (edit the file)
sed -i 's/old/new/g' file.txt

# Delete lines matching a pattern
sed '/pattern/d' file.txt

# Delete line 5
sed '5d' file.txt

# Insert text before line 3
sed '3i\New line text' file.txt

# Print only matching lines (like grep)
sed -n '/pattern/p' file.txt

# Replace only on specific lines (lines 10-20)
sed '10,20s/old/new/g' file.txt
```

#### Practical Examples Combined

```bash
# Extract error count by hour from log file
awk '/ERROR/ {print $1, $2}' app.log | \
  awk -F: '{print $1}' | \
  sort | uniq -c | sort -rn

# Replace all IP addresses in a config file
sed -i 's/192.168.1.100/10.0.0.50/g' /etc/nginx/nginx.conf

# Get top 5 most frequent error messages
grep "ERROR" app.log | awk '{$1=$2=$3=""; print $0}' | \
  sort | uniq -c | sort -rn | head -5
```

**What I re-learned:** `awk` is best for **column-based processing** and `sed` is best for **line-based transformations**. Together with `grep`, they form the "text processing trinity" of Linux.

---

### Weak Spot 3: Cron Syntax Deep Dive

**Why I revisited:** I know how to set up crontab, but I wanted to make sure I can read any cron expression quickly.

#### Cron Format

```
 ┌───────────── minute (0-59)
 │ ┌───────────── hour (0-23)
 │ │ ┌───────────── day of month (1-31)
 │ │ │ ┌───────────── month (1-12)
 │ │ │ │ ┌───────────── day of week (0-6, Sunday=0)
 │ │ │ │ │
 * * * * *  command
```

#### Common Cron Expressions

| Expression | Meaning |
|-----------|---------|
| `0 3 * * *` | Every day at 3:00 AM |
| `*/15 * * * *` | Every 15 minutes |
| `0 0 * * 0` | Every Sunday at midnight |
| `0 9 * * 1-5` | Weekdays at 9:00 AM |
| `0 0 1 * *` | First day of every month at midnight |
| `30 2 * * 1` | Every Monday at 2:30 AM |
| `0 */4 * * *` | Every 4 hours |
| `0 0 * * *` | Every day at midnight |
| `@reboot` | Once at system startup |
| `@daily` | Same as `0 0 * * *` |
| `@weekly` | Same as `0 0 * * 0` |
| `@hourly` | Same as `0 * * * *` |

**What I re-learned:** The special strings (`@daily`, `@weekly`, `@reboot`) are useful shortcuts, and `*/N` syntax for "every N units" is the most commonly used pattern in DevOps.

---

## Task 3: Quick-Fire Questions

### Question 1: What does `chmod 755 script.sh` do?

> Sets permissions to:
> - **Owner (7):** rwx — read, write, execute
> - **Group (5):** r-x — read, execute
> - **Others (5):** r-x — read, execute
>
> In practice: the owner can do everything, everyone else can read and run the script but can't modify it.
>
> ```
> 7 = 4(r) + 2(w) + 1(x) = rwx
> 5 = 4(r) + 0(-) + 1(x) = r-x
> ```

#### Verified: ✅ Correct

---

### Question 2: What is the difference between a process and a service?

> **Process:** Any running program — it could be a one-time command (`ls`), a user application, or a background task. Every command becomes a process with a PID.
>
> **Service (daemon):** A special type of process that runs **continuously in the background**, managed by `systemd`. Services start at boot, can be restarted automatically, and are managed with `systemctl`.
>
> | Process | Service |
> |---------|---------|
> | Any running program | Long-running background program |
> | May be short-lived | Designed to run continuously |
> | Managed by the user/shell | Managed by systemd |
> | e.g., `ls`, `python script.py` | e.g., `nginx`, `sshd`, `docker` |

#### Verified: ✅ Correct

---

### Question 3: How do you find which process is using port 8080?

> ```bash
> # Method 1: ss (modern, recommended)
> ss -tlnp | grep 8080
>
> # Method 2: lsof
> sudo lsof -i :8080
>
> # Method 3: fuser
> sudo fuser 8080/tcp
>
> # Method 4: netstat (legacy)
> netstat -tlnp | grep 8080
> ```
>
> The most common is `ss -tlnp | grep 8080` — it shows the PID and process name listening on that port.

#### Verified: ✅ Correct

---

### Question 4: What does `set -euo pipefail` do in a shell script?

> It enables **strict mode** — catches errors that would otherwise silently pass:
>
> | Flag | What It Does |
> |------|-------------|
> | `-e` | Exit immediately if any command fails (non-zero exit code) |
> | `-u` | Treat unset variables as errors (prevents typos from being silent) |
> | `-o pipefail` | Catch failures in piped commands (not just the last command) |
>
> ```bash
> #!/bin/bash
> set -euo pipefail
>
> # Without these flags:
> # - `cat nonexistent.txt | grep foo` → silently fails the cat, grep sees empty input
> # - `echo $TYPO_VARIABLE` → silently prints nothing
> # - `false; echo "still runs"` → continues despite the failure
>
> # With these flags:
> # - All three scenarios would STOP the script immediately
> ```

#### Verified: ✅ Correct

---

### Question 5: What is the difference between `git reset --hard` and `git revert`?

> | Aspect | `git reset --hard` | `git revert` |
> |--------|:------------------:|:------------:|
> | **What it does** | Erases commits from history, deletes files | Creates a NEW commit that undoes changes |
> | **History** | Rewritten — commits disappear | Preserved — adds an "undo" commit |
> | **Destructive?** | 🔴 Yes — files deleted from disk | 🟢 No — non-destructive |
> | **Safe for shared branches?** | ❌ No — requires force push | ✅ Yes — normal push |
> | **When to use** | Local/unpushed experiments | Pushed/shared branches |
>
> **Rule of thumb:** Pushed → revert. Local only → reset.

#### Verified: ✅ Correct

---

### Question 6: What branching strategy for a team of 5 shipping weekly?

> **GitHub Flow** ✅ — Simple, fast, built for continuous delivery.
>
> With 5 developers and weekly releases, you don't need GitFlow's complexity. GitHub Flow gives you:
> - `main` branch (always deployable)
> - Short-lived feature branches
> - Pull Requests for code review
> - Merge to main when approved → deploy
>
> GitFlow would be overkill for a small team. Trunk-Based requires more CI/CD maturity than a 5-person team typically has.

#### Verified: ✅ Correct

---

### Question 7: What does `git stash` do and when would you use it?

> `git stash` temporarily saves your uncommitted changes (both staged and unstaged) and gives you a clean working directory.
>
> **When to use:** You're in the middle of coding a feature, but a critical bug comes in. You can't commit half-done work, and you can't switch branches with uncommitted changes.
>
> ```bash
> git stash push -m "WIP: new feature"    # Save work
> git switch main                          # Switch to fix bug
> # ... fix bug, commit, push ...
> git switch feature-branch                # Come back
> git stash pop                            # Restore your work
> ```
>
> `pop` removes from stash list; `apply` keeps it as a backup.

#### Verified: ✅ Correct

---

### Question 8: How do you schedule a script to run every day at 3 AM?

> ```bash
> # Edit your crontab
> crontab -e
>
> # Add this line:
> 0 3 * * * /home/user/scripts/backup.sh >> /var/log/backup.log 2>&1
>
> # Breakdown:
> # 0     = minute 0 (on the hour)
> # 3     = 3 AM
> # * * * = every day, every month, every day of week
> # >> /var/log/backup.log 2>&1 = log output and errors
> ```
>
> Alternative using the shortcut: `@daily /path/to/script.sh` (but this runs at midnight, not 3 AM).

#### Verified: ✅ Correct

---

### Question 9: What is the difference between `git fetch` and `git pull`?

> | `git fetch` | `git pull` |
> |:-----------:|:----------:|
> | Downloads remote changes | Downloads AND merges remote changes |
> | Does NOT modify your working branch | Auto-merges into your current branch |
> | Safe — lets you review first | Can cause unexpected merge conflicts |
> | You inspect, then merge manually | One-step convenience command |
>
> `git pull` = `git fetch` + `git merge`
>
> **Best practice:** Prefer `git fetch` + review + `git merge` in production environments. Use `git pull` for quick personal projects.

#### Verified: ✅ Correct

---

### Question 10: What is LVM and why would you use it instead of regular partitions?

> **LVM (Logical Volume Manager)** adds a flexible layer between physical disks and filesystems, letting you **resize storage on the fly** without downtime.
>
> **Architecture:** Physical Volumes (PVs) → Volume Groups (VGs) → Logical Volumes (LVs)
>
> **Why use LVM over regular partitions:**
>
> | Regular Partitions | LVM |
> |-------------------|-----|
> | Fixed size — hard to resize | Resize anytime (extend/shrink) |
> | Tied to one physical disk | Pool multiple disks together |
> | Risky to resize (data loss possible) | Safe live extension |
> | Can't add storage dynamically | Add a new disk → extend VG → extend LV |
>
> **DevOps relevance:** In cloud environments, you frequently need to add disk space. LVM makes this as simple as: add disk → `pvcreate` → `vgextend` → `lvextend` → `resize2fs`.

#### Verified: ✅ Correct

---

### Quick-Fire Scorecard

```
10/10 Correct ✅ — All questions answered from memory and verified!
```

---

## Task 4: Organize Your Work

### Submission Status Check

| Day | Topic | Files | Status |
|:---:|-------|-------|:------:|
| 22 | Git Basics | `README.md`, `day-22-notes.md`, `git-commands.md` | ✅ Committed |
| 23 | Branching & GitHub | `README.md`, `day-23-notes.md` | ✅ Committed |
| 24 | Advanced Git | `README.md`, `day-24-notes.md` | ✅ Committed |
| 25 | Reset & Revert | `README.md`, `day-25-notes.md` | ✅ Committed |
| 26 | GitHub CLI | `README.md`, `day-26-notes.md` | ✅ Committed |
| 27 | GitHub Profile | `README.md`, `day-27-notes.md` | ✅ Committed |
| 28 | Revision Day | `README.md`, `day-28-notes.md` | ✅ This file! |

### Reference Documents Status

| Document | Location | Status | Content |
|----------|----------|:------:|---------|
| `git-commands.md` | `day-22/` | ✅ Up to date | 40 commands, 17 sections (Days 22-26) |
| Shell cheat sheet | Day 21 | ✅ Complete | Comprehensive shell scripting reference |
| GitHub Profile | GitHub | ✅ Polished | Profile README, organized repos, curated pins |

---

## Task 5: Teach It Back

### Topic: Git Branching — Explained for a Non-Developer

Imagine you're writing a book with a team. The main copy of the book sits on a desk — everyone calls it the **"main" copy**.

Now, one day you want to write a new chapter about dragons. But what if your dragon chapter is terrible? You don't want to ruin the main book. So instead of writing directly in the main copy, you **make a photocopy** of the entire book and take it to your desk. This photocopy is your **"branch"**.

You write your dragon chapter in your photocopy. Meanwhile, your colleague is working on a different photocopy, adding a chapter about magic. Neither of you is messing with the main book.

When your dragon chapter is done and reviewed, you bring your photocopy back to the main desk and **add your new chapter to the main book** — this is called **"merging"**.

What if your colleague's magic chapter changes something on the same page your dragon chapter uses? That's a **"merge conflict"** — you both edited the same part of the book, and someone needs to decide which version to keep (or combine both).

That's Git branching:
- **Main branch** = the official book
- **Feature branch** = your personal photocopy to experiment on
- **Merge** = adding your finished work back to the official book
- **Conflict** = two people edited the same part — resolve it manually

The beauty is: you can make as many photocopies as you want, try crazy ideas, and if they fail, just **throw the photocopy away** — the main book is untouched. 📚

---

## 🧠 Summary

```
┌──────────────────────────────────────────────────────────────────┐
│               REVISION DAY RESULTS — DAY 28                      │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  SELF-ASSESSMENT: 29/31 Confident (93.5%)                       │
│                                                                  │
│  ✅ STRONGEST AREAS:                                              │
│  • Git & GitHub (12/12) — Most recently learned, well-practiced  │
│  • Linux fundamentals (11/12) — Daily use builds confidence      │
│  • Shell scripting (6/7) — Solid foundation                      │
│                                                                  │
│  🟡 AREAS TO IMPROVE:                                            │
│  • LVM hands-on practice                                         │
│  • Advanced awk/sed text processing                              │
│                                                                  │
│  QUICK-FIRE: 10/10 ✅                                            │
│                                                                  │
│  KEY INSIGHT:                                                    │
│  Teaching a concept (Task 5) is the ultimate test of             │
│  understanding. If you can't explain it simply, you              │
│  don't understand it well enough.                                │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

<div align="center">

**Day 28 Complete ✅ — Revision Done, Foundations Solid!** 🏗️

*"Revision isn't going backward — it's building the floor under your next leap."*

**#90DaysOfDevOps #TrainWithShubham**

</div>
