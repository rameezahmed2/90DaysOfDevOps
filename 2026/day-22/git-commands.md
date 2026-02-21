# 🔧 Git Commands Reference — Living Document

> **Started:** Day 22 of #90DaysOfDevOps  
> **Last Updated:** 2026-02-21  
> **Purpose:** A growing, categorized quick-reference for Git commands used throughout the DevOps journey.

---

## 📑 Table of Contents

| # | Category | Jump |
|---|----------|------|
| 1 | [Setup & Config](#1--setup--config) | ⚙️ |
| 2 | [Creating Repositories](#2--creating-repositories) | 📁 |
| 3 | [Basic Workflow](#3--basic-workflow) | 🔄 |
| 4 | [Viewing Changes](#4--viewing-changes) | 🔍 |
| 5 | [Commit History](#5--commit-history) | 📜 |
| 6 | [Undoing Changes](#6--undoing-changes) | ⏪ |
| 7 | [Branching](#7--branching) | 🌿 |
| 8 | [Remote Repositories](#8--remote-repositories) | 🌐 |

---

## 1. ⚙️ Setup & Config

| Command | Description | Example |
|---------|-------------|---------|
| `git --version` | Check installed Git version | `git --version` → `git version 2.43.0` |
| `git config --global user.name` | Set your name for all repos | `git config --global user.name "Rameez Ahmed"` |
| `git config --global user.email` | Set your email for all repos | `git config --global user.email "rameez@example.com"` |
| `git config --list` | View all current configuration | `git config --list` |
| `git config --global core.editor` | Set default text editor | `git config --global core.editor "vim"` |
| `git config --global init.defaultBranch` | Set default branch name | `git config --global init.defaultBranch main` |

### 💡 Config Scope Levels

```
┌─────────────────────────────────────────────────────┐
│  --system   →  /etc/gitconfig      (all users)      │
│  --global   →  ~/.gitconfig        (current user)   │
│  --local    →  .git/config         (current repo)   │
│                                                     │
│  Priority:  local > global > system                 │
└─────────────────────────────────────────────────────┘
```

---

## 2. 📁 Creating Repositories

| Command | Description | Example |
|---------|-------------|---------|
| `git init` | Initialize a new Git repo in current directory | `git init` |
| `git init <dir>` | Create a new directory and init as repo | `git init devops-git-practice` |
| `git clone <url>` | Clone an existing remote repository | `git clone https://github.com/user/repo.git` |
| `git clone <url> <dir>` | Clone into a specific directory name | `git clone https://github.com/user/repo.git my-project` |

### What's inside `.git/`?

```bash
.git/
├── HEAD            # Points to the current branch
├── config          # Repo-specific configuration
├── description     # Used by GitWeb (rarely used)
├── hooks/          # Client-side or server-side scripts
├── info/           # Global excludes file
├── objects/        # All content (blobs, trees, commits)
│   ├── info/
│   └── pack/
└── refs/           # Pointers to commits (branches, tags)
    ├── heads/      # Branch references
    └── tags/       # Tag references
```

> ⚠️ **Never delete `.git/`** — it contains your entire repository history. Without it, the directory is just a regular folder.

---

## 3. 🔄 Basic Workflow

| Command | Description | Example |
|---------|-------------|---------|
| `git status` | Show working tree status (modified, staged, untracked) | `git status` |
| `git status -s` | Short/compact status output | `git status -s` |
| `git add <file>` | Stage a specific file for commit | `git add README.md` |
| `git add .` | Stage **all** changes in current directory | `git add .` |
| `git add -A` | Stage **all** changes in repo (including deletions) | `git add -A` |
| `git add -p` | Interactively stage parts of a file (hunks) | `git add -p script.sh` |
| `git commit -m "msg"` | Commit staged changes with a message | `git commit -m "Add initial README"` |
| `git commit -am "msg"` | Stage **tracked** modified files + commit in one step | `git commit -am "Fix typo in config"` |
| `git rm <file>` | Remove a file and stage the deletion | `git rm old-file.txt` |
| `git mv <old> <new>` | Rename/move a file and stage it | `git mv old.md new.md` |

### 🗺️ The Git Workflow Visualized

```
  Working Directory        Staging Area          Repository (.git)
  ─────────────────        ────────────          ─────────────────
                                                 
  ┌─────────────┐    git add    ┌──────────┐   git commit   ┌──────────┐
  │  Edit files  │ ──────────► │  Staged   │ ────────────► │ Committed │
  │  (untracked  │              │  changes  │               │  snapshot │
  │   / modified)│              │           │               │  (saved!) │
  └─────────────┘              └──────────┘               └──────────┘
         ▲                                                       │
         │                    git checkout / restore              │
         └───────────────────────────────────────────────────────┘
```

---

## 4. 🔍 Viewing Changes

| Command | Description | Example |
|---------|-------------|---------|
| `git diff` | Show **unstaged** changes (working dir vs staging) | `git diff` |
| `git diff --staged` | Show **staged** changes (staging vs last commit) | `git diff --staged` |
| `git diff HEAD` | Show **all** changes (working dir vs last commit) | `git diff HEAD` |
| `git diff <commit1> <commit2>` | Compare two commits | `git diff abc123 def456` |
| `git diff --stat` | Summary of changes (files changed, insertions, deletions) | `git diff --stat` |
| `git show <commit>` | Show details and diff of a specific commit | `git show abc123` |

---

## 5. 📜 Commit History

| Command | Description | Example |
|---------|-------------|---------|
| `git log` | Full commit history with details | `git log` |
| `git log --oneline` | Compact one-line-per-commit view | `git log --oneline` |
| `git log --oneline --graph` | Visual branch graph in terminal | `git log --oneline --graph --all` |
| `git log -n <N>` | Show only the last N commits | `git log -n 5` |
| `git log --stat` | Show files changed per commit | `git log --stat` |
| `git log --author="name"` | Filter commits by author | `git log --author="Rameez"` |
| `git log --since="2 weeks ago"` | Filter commits by date | `git log --since="2026-02-01"` |
| `git log -p` | Show patch/diff for each commit | `git log -p -2` |

### 🎨 Pretty Formats

```bash
# Custom log format with colors
git log --pretty=format:"%C(yellow)%h%Creset %C(blue)%ad%Creset %C(green)%an%Creset %s" --date=short

# Decorated graph view (great for branches)
git log --oneline --graph --decorate --all
```

---

## 6. ⏪ Undoing Changes

| Command | Description | Example |
|---------|-------------|---------|
| `git restore <file>` | Discard changes in working directory | `git restore README.md` |
| `git restore --staged <file>` | Unstage a file (keep changes) | `git restore --staged README.md` |
| `git commit --amend` | Modify the last commit (message or content) | `git commit --amend -m "Better message"` |
| `git reset HEAD~1` | Undo last commit, keep changes staged | `git reset HEAD~1` |
| `git reset --hard HEAD~1` | Undo last commit and **discard** all changes | `git reset --hard HEAD~1` |
| `git revert <commit>` | Create a new commit that undoes a previous one | `git revert abc123` |
| `git stash` | Temporarily save uncommitted changes | `git stash` |
| `git stash pop` | Restore the latest stashed changes | `git stash pop` |
| `git stash list` | List all stashed entries | `git stash list` |

> ⚠️ **`git reset --hard` is destructive!** Uncommitted changes will be permanently lost.

---

## 7. 🌿 Branching

| Command | Description | Example |
|---------|-------------|---------|
| `git branch` | List all local branches | `git branch` |
| `git branch <name>` | Create a new branch | `git branch feature-login` |
| `git checkout <branch>` | Switch to a branch | `git checkout feature-login` |
| `git checkout -b <name>` | Create and switch to a new branch | `git checkout -b feature-login` |
| `git switch <branch>` | Switch branches (modern) | `git switch main` |
| `git switch -c <name>` | Create and switch (modern) | `git switch -c feature-login` |
| `git merge <branch>` | Merge a branch into current branch | `git merge feature-login` |
| `git branch -d <name>` | Delete a merged branch | `git branch -d feature-login` |
| `git branch -D <name>` | Force-delete an unmerged branch | `git branch -D experiment` |

> 💡 **Prefer `git switch`** over `git checkout` for switching branches — it's clearer and less error-prone.

---

## 8. 🌐 Remote Repositories

| Command | Description | Example |
|---------|-------------|---------|
| `git remote -v` | List remote connections with URLs | `git remote -v` |
| `git remote add origin <url>` | Connect local repo to a remote | `git remote add origin https://github.com/user/repo.git` |
| `git push origin <branch>` | Push commits to remote branch | `git push origin main` |
| `git push -u origin <branch>` | Push and set upstream tracking | `git push -u origin main` |
| `git pull` | Fetch + merge changes from remote | `git pull` |
| `git fetch` | Download remote changes without merging | `git fetch origin` |
| `git remote remove <name>` | Remove a remote connection | `git remote remove origin` |

### 🔁 Push/Pull Workflow

```
  Local Repository                        Remote Repository
  ─────────────────                       ─────────────────
  ┌─────────────┐    git push    ┌─────────────────────────┐
  │  Your local  │ ────────────► │  GitHub / GitLab /      │
  │  commits     │               │  Bitbucket              │
  │              │ ◄──────────── │                         │
  └─────────────┘    git pull    └─────────────────────────┘
                                          │
                  git fetch               │  (download only,
                ◄─────────────────────────┘   no merge)
```

---

## 🎓 Git Best Practices

| # | Practice | Why |
|---|----------|-----|
| 1 | Write clear commit messages | Future-you will thank present-you |
| 2 | Commit early, commit often | Small commits are easier to debug and review |
| 3 | One logical change per commit | Keeps history clean and bisectable |
| 4 | Never commit secrets / passwords | Use `.gitignore` and environment variables |
| 5 | Pull before you push | Avoid unnecessary merge conflicts |
| 6 | Use branches for features | Keep `main` stable and deployable |
| 7 | Review `git status` before committing | Avoid staging unintended files |
| 8 | Use `.gitignore` from day one | Keep repo clean from build artifacts and temp files |

---

> 📌 *This is a living document — it will be updated daily as new Git commands are learned throughout the #90DaysOfDevOps challenge.* 🚀
