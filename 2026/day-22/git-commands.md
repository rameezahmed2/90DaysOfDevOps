# 📖 Git Commands Reference — A Living Document

<div align="center">

![Git](https://img.shields.io/badge/Tool-Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![Updated](https://img.shields.io/badge/Updated-Day_24-blue?style=for-the-badge)
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
| 11 | `git branch` | List, create, or delete branches |
| 12 | `git switch <branch>` | Switch to a branch (modern) |
| 13 | `git checkout <branch>` | Switch branches or restore files |
| 14 | `git merge <branch>` | Merge a branch into current branch |
| 15 | `git remote` | Manage remote connections |
| 16 | `git push` | Upload local commits to remote |
| 17 | `git pull` | Download + merge remote changes |
| 18 | `git fetch` | Download remote changes (review first) |
| 19 | `git clone <url>` | Copy a remote repo to local machine |
| 20 | `git stash` | Temporarily save uncommitted changes |
| 21 | `git merge --no-ff` | Merge with explicit merge commit |
| 22 | `git merge --squash` | Squash all commits into one |
| 23 | `git rebase <branch>` | Replay commits on top of another branch |
| 24 | `git cherry-pick <hash>` | Apply a specific commit to current branch |
| 25 | `git rebase -i` | Interactive rebase (reorder, squash, edit) |
| 26 | `git reflog` | Show history of HEAD movements |

---

## 📖 Table of Contents

1. [🔧 Setup & Configuration](#-1-setup--configuration)
2. [📂 Repository Creation](#-2-repository-creation)
3. [📝 Basic Workflow (Stage → Commit)](#-3-basic-workflow-stage--commit)
4. [🔍 Viewing Changes](#-4-viewing-changes)
5. [📜 History & Logs](#-5-history--logs)
6. [↩️ Undoing Changes](#%EF%B8%8F-6-undoing-changes)
7. [🗑️ Removing & Ignoring Files](#%EF%B8%8F-7-removing--ignoring-files)
8. [🌿 Branching & Switching](#-8-branching--switching)
9. [🌐 Remote Repositories](#-9-remote-repositories)
10. [🤝 Collaboration — Clone, Fork & Sync](#-10-collaboration--clone-fork--sync)
11. [📦 Stashing Changes](#-11-stashing-changes)
12. [🔀 Advanced Merging](#-12-advanced-merging)
13. [♻️ Rebasing](#%EF%B8%8F-13-rebasing)
14. [🍒 Cherry Picking](#-14-cherry-picking)
15. [🔎 Reflog & Recovery](#-15-reflog--recovery)

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

## 🌿 8. Branching & Switching

### `git branch`
List all local branches. The current branch is marked with `*`.
```bash
git branch                            # List local branches
git branch -a                         # List ALL branches (local + remote)
git branch -r                         # List remote branches only
git branch -v                         # Show last commit on each branch
```

### `git branch <name>`
Create a new branch (but stay on the current one).
```bash
git branch feature-1                  # Create 'feature-1' branch
git branch bugfix/login-error         # Create with a descriptive path-style name
```

### `git branch -d <name>`
Delete a branch that has been fully merged.
```bash
git branch -d feature-1               # Safe delete (only if merged)
git branch -D feature-1               # Force delete (even if not merged) ⚠️
```

### `git branch -m <new-name>`
Rename the current branch.
```bash
git branch -m new-branch-name         # Rename current branch
git branch -m old-name new-name       # Rename a specific branch
```

> 💡 **Tip:** Use descriptive branch names with prefixes: `feature/`, `bugfix/`, `hotfix/`, `chore/`.

---

### `git switch <branch>`
Switch to an existing branch (modern, recommended).
```bash
git switch main                       # Switch to main
git switch feature-1                  # Switch to feature-1
```

### `git switch -c <branch>`
Create a new branch AND switch to it in one command.
```bash
git switch -c feature-2               # Create + switch (one step)
git switch -c hotfix/urgent-fix       # Create a hotfix branch and switch
```

### `git checkout <branch>`
The classic way to switch branches (still works, but broader scope).
```bash
git checkout main                     # Switch to main
git checkout -b feature-3             # Create + switch (classic way)
```

#### `git switch` vs `git checkout` — What's the Difference?

| Aspect | `git switch` | `git checkout` |
|--------|:------------:|:--------------:|
| **Purpose** | Only switches branches | Switches branches AND restores files |
| **Introduced** | Git 2.23 (2019) — modern | Original Git command — legacy |
| **Create + switch** | `git switch -c <name>` | `git checkout -b <name>` |
| **Safer?** | ✅ Yes — only does one thing | ⚠️ Overloaded — can accidentally overwrite files |
| **Recommendation** | ✅ Preferred for switching | Use only for restoring files |

> 💡 **Use `git switch` for branches, `git restore` for files.** These two replaced the overloaded `git checkout` command.

---

### `git merge <branch>`
Merge a branch into the current branch.
```bash
# Merge feature-1 into main
git switch main
git merge feature-1

# Merge with a commit message
git merge feature-1 -m "Merge feature-1 into main"
```

> ⚠️ **Merge conflicts** occur when two branches modify the same lines. Git will ask you to resolve them manually.

#### Merge Types at a Glance

| Type | Command | When It Happens | Result |
|------|---------|----------------|--------|
| Fast-forward | `git merge branch` | Target hasn't moved | Pointer moved forward |
| Merge commit | `git merge branch` | Both branches have new commits | New commit with 2 parents |
| No-fast-forward | `git merge --no-ff branch` | Forced | Always creates merge commit |
| Squash | `git merge --squash branch` | Explicit | All changes staged, no merge commit |

---

## 🌐 9. Remote Repositories

### `git remote`
Manage connections to remote repositories.
```bash
git remote                            # List remote names
git remote -v                         # List remotes with URLs (fetch + push)
```

### `git remote add <name> <url>`
Connect your local repo to a remote repository.
```bash
# Add your GitHub repo as 'origin'
git remote add origin https://github.com/rameez/devops-git-practice.git

# Add the original repo as 'upstream' (for forks)
git remote add upstream https://github.com/original/repo.git
```

### `git remote remove <name>`
Remove a remote connection.
```bash
git remote remove upstream
```

### `git remote rename <old> <new>`
Rename a remote.
```bash
git remote rename origin github
```

---

### `git push`
Upload local commits to the remote repository.
```bash
git push origin main                  # Push main branch to origin
git push -u origin main               # Push + set upstream tracking
git push                              # Push to tracked upstream (after -u)
git push origin feature-1             # Push a feature branch
git push --all origin                 # Push all branches
git push origin --delete feature-1    # Delete remote branch
```

> 💡 **`-u` (or `--set-upstream`)** sets up tracking so future `git push` and `git pull` work without specifying the remote/branch.

### `git pull`
Download remote changes and merge them into your current branch.
```bash
git pull origin main                  # Fetch + merge from origin/main
git pull                              # Pull from tracked upstream
git pull --rebase origin main         # Fetch + rebase (cleaner history)
```

### `git fetch`
Download remote changes WITHOUT merging (safe preview).
```bash
git fetch origin                      # Fetch all branches from origin
git fetch upstream                    # Fetch from upstream remote
git fetch --all                       # Fetch from all remotes

# After fetching, review and then merge:
git log main..origin/main             # See what's new
git diff main origin/main             # See the actual changes
git merge origin/main                 # Merge when ready
```

#### Fetch vs Pull — Quick Comparison

| Command | Downloads? | Merges? | Safe? |
|---------|:----------:|:-------:|:-----:|
| `git fetch` | ✅ | ❌ | ✅ Very safe |
| `git pull` | ✅ | ✅ | ⚠️ May cause conflicts |

---

## 🤝 10. Collaboration — Clone, Fork & Sync

### `git clone <url>`
Copy a remote repository to your local machine.
```bash
git clone https://github.com/user/repo.git           # Clone
git clone https://github.com/user/repo.git my-folder  # Clone into custom dir
git clone --depth 1 https://github.com/user/repo.git   # Shallow (latest only)
git clone --branch feature-1 https://github.com/user/repo.git  # Clone specific branch
```

### Fork + Clone Workflow (Contributing to Open Source)
```bash
# 1. Fork on GitHub (browser — click "Fork" button)
# 2. Clone YOUR fork
git clone https://github.com/YOUR-USERNAME/repo.git
cd repo

# 3. Add original repo as upstream
git remote add upstream https://github.com/ORIGINAL-OWNER/repo.git

# 4. Verify remotes
git remote -v
# origin    https://github.com/YOUR-USERNAME/repo.git (fetch)
# origin    https://github.com/YOUR-USERNAME/repo.git (push)
# upstream  https://github.com/ORIGINAL-OWNER/repo.git (fetch)
# upstream  https://github.com/ORIGINAL-OWNER/repo.git (push)
```

### Keeping Your Fork in Sync
```bash
# Fetch latest from original repo
git fetch upstream

# Merge upstream changes into your main
git switch main
git merge upstream/main

# Push updated main to your fork
git push origin main
```

---

## 📦 11. Stashing Changes

### `git stash`
Temporarily save uncommitted changes so you can switch branches cleanly.
```bash
git stash                             # Stash all changes (staged + unstaged)
git stash -m "WIP: login feature"     # Stash with a description
git stash -u                          # Include untracked files
```

### `git stash list`
Show all stashed changes.
```bash
git stash list
# stash@{0}: On feature-1: WIP: login feature
# stash@{1}: WIP on main: a1b2c3d Update README
```

### `git stash pop`
Restore the most recent stash and remove it from the stash list.
```bash
git stash pop                         # Apply latest stash + delete it
git stash pop stash@{1}               # Apply a specific stash
```

### `git stash apply`
Restore a stash but keep it in the stash list.
```bash
git stash apply                       # Apply but keep stash
git stash apply stash@{2}             # Apply specific stash
```

### `git stash drop`
Delete a specific stash entry.
```bash
git stash drop stash@{0}              # Drop specific stash
git stash clear                       # Clear ALL stashes ⚠️
```

> 💡 **Use stash when:** You're mid-work on a feature but need to quickly switch branches for a hotfix. Stash → switch → fix → switch back → pop.

---

## 🔀 12. Advanced Merging

### `git merge --no-ff <branch>`
Force a merge commit even when fast-forward is possible. Preserves branch history.
```bash
git switch main
git merge --no-ff feature-login
# Always creates a merge commit, even if FF was possible
# Useful for: seeing where a feature branch started/ended in history
```

### `git merge --squash <branch>`
Combine all branch commits into a single changeset, staged but not committed.
```bash
git switch main
git merge --squash feature-profile
# Squash commit -- not updating HEAD

# You must commit manually:
git commit -m "Add complete profile feature"
# Result: ONE commit containing all changes from the branch
```

### Resolving Merge Conflicts
```bash
# When a conflict occurs:
git merge feature-branch
# CONFLICT (content): Merge conflict in file.txt

# 1. Open the file — find conflict markers:
# <<<<<<< HEAD
# your changes
# =======
# their changes
# >>>>>>> feature-branch

# 2. Edit the file to resolve (keep what you want)
# 3. Stage the resolved file
git add file.txt

# 4. Complete the merge
git commit -m "Resolve merge conflict in file.txt"

# Or abort the merge entirely
git merge --abort
```

---

## ♻️ 13. Rebasing

### `git rebase <branch>`
Replay your commits on top of another branch — creates a linear history.
```bash
# Update feature branch with latest main
git switch feature-dashboard
git rebase main
# Replays your commits on top of main's latest commit

# After rebase, your commits have NEW hashes
# The changes are the same, but the parents are different
```

### `git rebase -i <base>`
Interactive rebase — reorder, squash, edit, or drop commits.
```bash
# Interactively edit the last 4 commits
git rebase -i HEAD~4

# Opens editor with:
# pick a1b2c3d Add feature A
# pick d4e5f6a Fix typo
# pick b7c8d9e Add feature B
# pick e0f1a2b Another typo fix

# Change 'pick' to:
# pick   = keep the commit as-is
# squash = combine with previous commit
# reword = change commit message
# edit   = pause to amend the commit
# drop   = remove the commit entirely
# fixup  = like squash but discard commit message
```

### `git rebase --abort`
Cancel a rebase in progress and return to the original state.
```bash
git rebase --abort
```

### `git rebase --continue`
Continue after resolving conflicts during a rebase.
```bash
# After fixing conflicts:
git add resolved-file.txt
git rebase --continue
```

> ⚠️ **The Golden Rule:** Never rebase commits that have been pushed and shared with others. It rewrites history and will cause chaos for teammates.

#### Rebase vs Merge — Quick Comparison

| Aspect | Merge | Rebase |
|--------|:-----:|:------:|
| **History** | Non-linear (preserves branches) | Linear (straight line) |
| **Creates extra commit?** | ✅ Merge commit | ❌ No |
| **Rewrites commits?** | ❌ No | ✅ Yes (new hashes) |
| **Safe for shared branches?** | ✅ Yes | ❌ No |
| **Best for** | Integrating finished features | Keeping feature branches up-to-date |

---

## 🍒 14. Cherry Picking

### `git cherry-pick <commit-hash>`
Apply a specific commit from another branch onto your current branch.
```bash
# Find the commit hash you want
git log --oneline feature-hotfix
# c3c3c3c Update UI colors
# b2b2b2b Fix critical security bug    ← want this one
# a1a1a1a Add migration script

# Cherry-pick just that one commit
git switch main
git cherry-pick b2b2b2b
# [main xyz789] Fix critical security bug
# Creates a NEW commit with the same changes
```

### Cherry-pick multiple commits
```bash
git cherry-pick abc1234 def5678       # Pick specific commits
git cherry-pick abc1234..def5678      # Pick a range of commits
```

### Handling cherry-pick conflicts
```bash
# If conflict occurs:
git cherry-pick abc1234
# CONFLICT...

# Resolve, then:
git add resolved-file.txt
git cherry-pick --continue

# Or abort:
git cherry-pick --abort
```

> 💡 **Cherry-pick is a scalpel, not a sword.** Use for isolated, specific changes (hotfixes, backports). For full features, use merge or rebase.

---

## 🔎 15. Reflog & Recovery

### `git reflog`
Show the history of every HEAD movement — your safety net for recovering lost commits.
```bash
git reflog
# abc1234 HEAD@{0}: commit: Add new feature
# def5678 HEAD@{1}: checkout: moving from main to feature
# ghi9012 HEAD@{2}: commit: Update README
# jkl3456 HEAD@{3}: rebase (finish): returning to refs/heads/feature
```

### Recover a deleted branch
```bash
# Oops! Deleted a branch
git branch -D feature-important

# Find the last commit hash from reflog
git reflog
# abc1234 HEAD@{5}: commit: Last commit on feature-important

# Resurrect it!
git switch -c feature-important abc1234
# Branch is back with all its commits!
```

### Undo a bad rebase
```bash
# Find the pre-rebase state in reflog
git reflog
# Find the entry BEFORE the rebase started

# Reset to that point
git reset --hard HEAD@{5}
# Your branch is back to its pre-rebase state
```

> 💡 **Reflog is your time machine.** Even after deleting branches, resetting, or rebasing, Git keeps a record of where HEAD has been for ~90 days.

---

## 📊 Command Flow Diagram

```
 YOU EDIT FILES
       │
       ▼
 ┌─────────────┐     git add      ┌────────────┐    git commit     ┌──────────────┐     git push     ┌──────────────┐
 │  Working     │ ────────────▶   │  Staging    │ ─────────────▶   │  Local Repo  │ ────────────▶   │  Remote Repo │
 │  Directory   │                  │  Area       │                  │  (History)   │                  │  (GitHub)    │
 │              │ ◀────────────   │             │                  │              │ ◀────────────   │              │
 │  (modified)  │  git restore    │  (staged)   │                  │  (committed) │  git pull/fetch  │  (pushed)    │
 └─────────────┘                  └────────────┘                   └──────────────┘                  └──────────────┘
                                                                          │
                                                 git rebase / git merge / git cherry-pick
                                                 (combine branches and history)
```

---

## 📈 Update Log

| Date | What Was Added | Day |
|------|---------------|:---:|
| 2026-02-21 | Initial commands: Setup, Workflow, Viewing, History, Undo, Remove | Day 22 |
| 2026-02-22 | Branching, Switching, Remotes, Push/Pull/Fetch, Clone/Fork, Stash | Day 23 |
| 2026-02-22 | Advanced Merging, Rebase, Cherry-Pick, Reflog & Recovery | Day 24 |

---

<div align="center">

*This document grows daily. Keep learning, keep committing!* 🌱

**#90DaysOfDevOps**

</div>
