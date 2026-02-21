# 📖 Git Commands Reference — A Living Document

<div align="center">

![Git](https://img.shields.io/badge/Tool-Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![Updated](https://img.shields.io/badge/Started-Day_22-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Living_Document-brightgreen?style=for-the-badge)

*This reference grows daily. Every new Git concept = a new entry.*

</div>

---

## ⚡ Quick Reference Table

| # | Command | What It Does |
|:-:|---------|-------------|
| 1 | `git init` | Initialize a new Git repository |
| 2 | `git status` | Show working tree status |
| 3 | `git add <file>` | Stage changes for commit |
| 4 | `git commit -m "msg"` | Save staged changes with a message |
| 5 | `git log` | Show commit history |
| 6 | `git diff` | Show unstaged changes |
| 7 | `git config` | Get/set Git configuration |
| 8 | `git log --oneline` | Compact commit history |
| 9 | `git restore <file>` | Discard working directory changes |
| 10 | `git rm <file>` | Remove file from tracking |

---

## 📖 Table of Contents

1. [🔧 Setup & Configuration](#-1-setup--configuration)
2. [📂 Repository Creation](#-2-repository-creation)
3. [📝 Basic Workflow (Stage → Commit)](#-3-basic-workflow-stage--commit)
4. [🔍 Viewing Changes](#-4-viewing-changes)
5. [📜 History & Logs](#-5-history--logs)
6. [↩️ Undoing Changes](#%EF%B8%8F-6-undoing-changes)
7. [🗑️ Removing & Ignoring Files](#%EF%B8%8F-7-removing--ignoring-files)

---

## 🔧 1. Setup & Configuration

### `git --version`
Check which version of Git is installed.
```bash
git --version
# Output: git version 2.43.0
```

### `git config --global user.name`
Set your name for all repositories on this machine.
```bash
git config --global user.name "Rameez Ahmed"
```

### `git config --global user.email`
Set your email for all repositories.
```bash
git config --global user.email "rameez@example.com"
```

### `git config --list`
View all current Git configuration settings.
```bash
git config --list
# Shows: user.name, user.email, core.editor, etc.
```

### `git config --global core.editor`
Set your preferred text editor for Git (commit messages, etc.).
```bash
git config --global core.editor "vim"
# Or: "code --wait" for VS Code, "nano" for nano
```

### `git config --global init.defaultBranch`
Set the default branch name for new repositories.
```bash
git config --global init.defaultBranch main
```

> 💡 **Tip:** Use `--global` for settings that apply everywhere. Omit it for repo-specific settings. Use `--system` for machine-wide settings.

#### Config Scope Hierarchy

| Scope | Flag | File | Priority |
|-------|------|------|:--------:|
| System | `--system` | `/etc/gitconfig` | Lowest |
| Global | `--global` | `~/.gitconfig` | Medium |
| Local | `--local` | `.git/config` | Highest ✅ |

---

## 📂 2. Repository Creation

### `git init`
Initialize a new Git repository in the current directory.
```bash
mkdir my-project
cd my-project
git init
# Output: Initialized empty Git repository in /path/to/my-project/.git/
```

### `git clone <url>`
Clone an existing remote repository to your local machine.
```bash
git clone https://github.com/user/repo.git
git clone https://github.com/user/repo.git my-folder   # Custom folder name
git clone --depth 1 https://github.com/user/repo.git    # Shallow clone (latest only)
```

> 💡 **`git init`** creates a new repo. **`git clone`** copies an existing one. Both result in a `.git/` directory.

---

## 📝 3. Basic Workflow (Stage → Commit)

### `git status`
Show the current state of your working directory and staging area.
```bash
git status
# Shows:
#   - Untracked files (new files Git doesn't know about)
#   - Modified files (changed but not staged)
#   - Staged files (ready to commit)
```

```bash
git status -s   # Short format
# Output:
# M  modified-file.txt      (staged)
#  M unstaged-file.txt       (modified, not staged)
# ?? new-file.txt            (untracked)
# A  newly-added.txt         (newly staged)
```

### `git add <file>`
Stage a file (move it to the staging area) for the next commit.
```bash
git add README.md                # Stage a specific file
git add file1.txt file2.txt      # Stage multiple files
git add .                        # Stage ALL changes in current dir
git add -A                       # Stage ALL changes (entire repo)
git add *.py                     # Stage all Python files
git add -p                       # Interactive staging (choose hunks)
```

### `git commit -m "message"`
Save all staged changes as a new commit (a snapshot in history).
```bash
git commit -m "Add initial project structure"
git commit -m "Fix login validation bug"
git commit -am "Update README"    # Stage tracked files + commit (shortcut)
```

> ⚠️ **`git commit -am`** only stages **already tracked** files. New files still need `git add` first.

#### Commit Message Best Practices

```
✅ Good:                          ❌ Bad:
───────────────────────           ──────────────────
Add user login feature            update
Fix memory leak in parser         fix
Update CI pipeline config         changes
Remove deprecated API endpoint    asdfasdf
Refactor database connection      WIP
```

> 💡 Use **imperative mood**: "Add feature" not "Added feature" or "Adding feature"

---

## 🔍 4. Viewing Changes

### `git diff`
Show what changed in your working directory (unstaged changes).
```bash
git diff                          # All unstaged changes
git diff README.md                # Changes in a specific file
```

### `git diff --staged`
Show what's staged and ready to be committed.
```bash
git diff --staged                 # Same as: git diff --cached
```

### `git diff HEAD`
Show ALL changes (staged + unstaged) compared to the last commit.
```bash
git diff HEAD
```

### `git diff <commit1> <commit2>`
Compare two specific commits.
```bash
git diff abc1234 def5678
git diff HEAD~2 HEAD              # Compare 2 commits ago vs now
```

#### Diff Comparison Chart

| Command | Compares |
|---------|----------|
| `git diff` | Working directory ↔ Staging area |
| `git diff --staged` | Staging area ↔ Last commit |
| `git diff HEAD` | Working directory ↔ Last commit |
| `git diff A B` | Commit A ↔ Commit B |

---

## 📜 5. History & Logs

### `git log`
Show the full commit history with details.
```bash
git log
# Shows: commit hash, author, date, message
```

### `git log --oneline`
Show compact commit history (one line per commit).
```bash
git log --oneline
# Output:
# a1b2c3d Add day-22 notes
# f4e5d6c Add viewing changes section
# b7a8c9d Add basic workflow commands
# 1e2f3a4 Initial commit
```

### `git log` — Advanced Formats
```bash
git log --oneline --graph             # With branch graph
git log --oneline --all               # All branches
git log --oneline -n 5                # Last 5 commits only
git log --oneline --graph --all       # Full visual history
git log --author="Rameez"             # Commits by specific author
git log --since="2 weeks ago"         # Recent commits
git log --grep="fix"                  # Search commit messages
git log -p                            # Show patches (diffs) per commit
git log --stat                        # Show files changed per commit
```

### `git show <commit>`
Show details of a specific commit.
```bash
git show a1b2c3d                      # By short hash
git show HEAD                         # Latest commit
git show HEAD~1                       # One commit before HEAD
```

---

## ↩️ 6. Undoing Changes

### `git restore <file>`
Discard changes in working directory (revert to last commit).
```bash
git restore README.md                 # Discard unstaged changes
git restore .                         # Discard ALL unstaged changes
```

### `git restore --staged <file>`
Unstage a file (move it back from staging area to working directory).
```bash
git restore --staged README.md        # Unstage a specific file
git restore --staged .                # Unstage everything
```

### `git commit --amend`
Modify the most recent commit (message or content).
```bash
# Fix the last commit message
git commit --amend -m "Corrected commit message"

# Add forgotten file to last commit
git add forgotten-file.txt
git commit --amend --no-edit          # Keep same message
```

> ⚠️ **Never amend commits that have been pushed** to a shared remote — it rewrites history.

#### Undo Cheat Sheet

| Scenario | Command |
|----------|---------|
| Discard unstaged changes | `git restore <file>` |
| Unstage a file | `git restore --staged <file>` |
| Fix last commit message | `git commit --amend -m "new msg"` |
| Add file to last commit | `git add file && git commit --amend --no-edit` |

---

## 🗑️ 7. Removing & Ignoring Files

### `git rm <file>`
Remove a file from both Git tracking and the working directory.
```bash
git rm old-file.txt                   # Delete + unstage
git rm --cached secret.env            # Stop tracking but keep file on disk
git rm -r old-directory/              # Remove directory recursively
```

### `.gitignore`
Tell Git which files/patterns to ignore (never track).
```bash
# Create a .gitignore file
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
vendor/

# Environment files
.env
*.env.local

# Build outputs
dist/
build/
*.o
*.class

# OS files
.DS_Store
Thumbs.db

# IDE files
.vscode/
.idea/
*.swp
EOF
```

> 💡 **Tip:** Use [gitignore.io](https://www.toptal.com/developers/gitignore) to generate `.gitignore` templates for your tech stack.

---

## 📊 Command Flow Diagram

```
 YOU EDIT FILES
       │
       ▼
 ┌─────────────┐     git add      ┌────────────┐    git commit     ┌──────────────┐
 │  Working     │ ────────────▶   │  Staging    │ ─────────────▶   │  Repository  │
 │  Directory   │                  │  Area       │                  │  (History)   │
 │              │ ◀────────────   │             │                  │              │
 │  (modified)  │  git restore    │  (staged)   │                  │  (committed) │
 └─────────────┘                  └────────────┘                   └──────────────┘
       │                                                                  │
       │                        git diff HEAD                             │
       └──────────────────────────────────────────────────────────────────┘
```

---

## 📈 Update Log

| Date | What Was Added | Day |
|------|---------------|:---:|
| 2026-02-21 | Initial commands: Setup, Workflow, Viewing, History, Undo, Remove | Day 22 |

---

<div align="center">

*This document grows daily. Keep learning, keep committing!* 🌱

**#90DaysOfDevOps**

</div>
