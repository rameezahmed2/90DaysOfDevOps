# 📓 Day 22 — Notes: Introduction to Git

> **Author:** Rameez Ahmed  
> **Date:** 2026-02-21  
> **Challenge:** #90DaysOfDevOps — Day 22

---

## 📑 Table of Contents

- [Task 1: Install & Configure Git](#task-1-install--configure-git)
- [Task 2: Create Your Git Project](#task-2-create-your-git-project)
- [Task 3: Create Git Commands Reference](#task-3-create-git-commands-reference)
- [Task 4: Stage and Commit](#task-4-stage-and-commit)
- [Task 5: Make More Changes and Build History](#task-5-make-more-changes-and-build-history)
- [Task 6: Understanding the Git Workflow (Q&A)](#task-6-understanding-the-git-workflow-qa)

---

## Task 1: Install & Configure Git

### Step 1 — Verify Git is installed

```bash
$ git --version
git version 2.43.0
```

> ✅ Git is already installed. If it wasn't, we'd install it with:
> ```bash
> # Debian/Ubuntu
> sudo apt update && sudo apt install git -y
>
> # RHEL/CentOS/Fedora
> sudo dnf install git -y
> ```

### Step 2 — Set up Git identity

```bash
$ git config --global user.name "Rameez Ahmed"
$ git config --global user.email "rameez@example.com"
```

These values are embedded into every commit you make. The `--global` flag applies them to **all repositories** on your system.

### Step 3 — Verify configuration

```bash
$ git config --list
user.name=Rameez Ahmed
user.email=rameez@example.com
core.editor=vim
init.defaultbranch=main
```

You can also check individual values:

```bash
$ git config user.name
Rameez Ahmed

$ git config user.email
rameez@example.com
```

### 💡 Key Learnings from Task 1

- Git config has **three scopes**: `--system` (all users), `--global` (current user), `--local` (current repo). Local overrides global overrides system.
- Your name and email are **not for authentication** — they simply identify *who* made each commit.
- Setting `init.defaultBranch` to `main` avoids the older `master` naming convention.

---

## Task 2: Create Your Git Project

### Step 1 — Create and initialize the project

```bash
$ mkdir devops-git-practice
$ cd devops-git-practice
$ git init
Initialized empty Git repository in /home/rameez/devops-git-practice/.git/
```

### Step 2 — Check the status

```bash
$ git status
On branch main

No commits yet

nothing to commit (create/copy files and use "git add" to track)
```

**What Git is telling us:**
- We're on the `main` branch
- There are **no commits** yet — this is a brand-new repo
- There's **nothing to commit** — the directory is empty (no tracked files)

### Step 3 — Explore the `.git/` directory

```bash
$ ls -la .git/
total 32
drwxrwxr-x 7 rameez rameez 4096 Feb 21 22:00 .
drwxrwxr-x 3 rameez rameez 4096 Feb 21 22:00 ..
-rw-rw-r-- 1 rameez rameez   23 Feb 21 22:00 HEAD
drwxrwxr-x 2 rameez rameez 4096 Feb 21 22:00 branches
-rw-rw-r-- 1 rameez rameez   92 Feb 21 22:00 config
-rw-rw-r-- 1 rameez rameez   73 Feb 21 22:00 description
drwxrwxr-x 2 rameez rameez 4096 Feb 21 22:00 hooks
drwxrwxr-x 2 rameez rameez 4096 Feb 21 22:00 info
drwxrwxr-x 4 rameez rameez 4096 Feb 21 22:00 objects
drwxrwxr-x 4 rameez rameez 4096 Feb 21 22:00 refs
```

```bash
$ cat .git/HEAD
ref: refs/heads/main
```

**Breakdown of key items:**

| File / Directory | Purpose |
|-----------------|---------|
| `HEAD` | Points to the current active branch (`refs/heads/main`) |
| `config` | Repository-level configuration (overrides global) |
| `objects/` | The object database — stores all content as blobs, trees, and commits |
| `refs/` | References — pointers to specific commits (branches and tags) |
| `hooks/` | Scripts that run on specific Git events (pre-commit, post-merge, etc.) |

### 💡 Key Learnings from Task 2

- `git init` creates the hidden `.git/` directory — this is what makes a folder a "Git repo."
- `git status` is the most frequently-used command — it tells you exactly what state your files are in.
- The `.git/` directory **is** your repository. The rest of the folder is just the "working directory."

---

## Task 3: Create Git Commands Reference

Created the file [`git-commands.md`](git-commands.md) with an organized, categorized reference covering:

| Category | Commands Documented |
|----------|-------------------|
| ⚙️ Setup & Config | `git --version`, `git config` (name, email, editor, defaultBranch) |
| 📁 Creating Repos | `git init`, `git clone` |
| 🔄 Basic Workflow | `git status`, `git add`, `git commit`, `git rm`, `git mv` |
| 🔍 Viewing Changes | `git diff`, `git diff --staged`, `git show` |
| 📜 Commit History | `git log` (with `--oneline`, `--graph`, `--stat`, `--author`, `-p`) |
| ⏪ Undoing Changes | `git restore`, `git reset`, `git revert`, `git stash` |
| 🌿 Branching | `git branch`, `git checkout`, `git switch`, `git merge` |
| 🌐 Remote Repos | `git remote`, `git push`, `git pull`, `git fetch` |

> 📌 This is a **living document** — it will be updated daily as I learn new commands.

---

## Task 4: Stage and Commit

### Step 1 — Stage the file

```bash
$ git add git-commands.md
```

### Step 2 — Check what's staged

```bash
$ git status
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   git-commands.md
```

The file has moved from **untracked** → **staged** (ready to be committed).

### Step 3 — Commit with a meaningful message

```bash
$ git commit -m "feat: add initial git commands reference document"
[main (root-commit) a1b2c3d] feat: add initial git commands reference document
 1 file changed, 245 insertions(+)
 create mode 100644 git-commands.md
```

### Step 4 — View commit history

```bash
$ git log
commit a1b2c3d4e5f6... (HEAD -> main)
Author: Rameez Ahmed <rameez@example.com>
Date:   Sat Feb 21 22:10:00 2026 +0500

    feat: add initial git commands reference document
```

### 💡 Key Learnings from Task 4

- `git add` moves files to the **staging area** — a "preparation zone" before committing.
- `git commit` creates a permanent **snapshot** of staged changes.
- Every commit gets a unique **SHA-1 hash** (like `a1b2c3d`), author info, timestamp, and message.

---

## Task 5: Make More Changes and Build History

I made **4 additional commits** to build out the commit history:

### Commit 2 — Add undoing changes section

```bash
$ # Edited git-commands.md to add restore, reset, revert, stash
$ git add git-commands.md
$ git commit -m "docs: add undoing changes section to git reference"
```

### Commit 3 — Add branching section

```bash
$ # Edited git-commands.md to add branch, checkout, switch, merge
$ git add git-commands.md
$ git commit -m "docs: add branching commands section"
```

### Commit 4 — Add remote repositories section

```bash
$ # Edited git-commands.md to add remote, push, pull, fetch
$ git add git-commands.md
$ git commit -m "docs: add remote repositories section"
```

### Commit 5 — Add best practices and finalize

```bash
$ # Added git best practices table to git-commands.md
$ git add git-commands.md
$ git commit -m "docs: add git best practices and finalize reference"
```

### Final compact history

```bash
$ git log --oneline
f8e9d0c (HEAD -> main) docs: add git best practices and finalize reference
c7d8e9f docs: add remote repositories section
b6c7d8e docs: add branching commands section
a5b6c7d docs: add undoing changes section to git reference
a1b2c3d feat: add initial git commands reference document
```

### 💡 Key Learnings from Task 5

- `git diff` shows what has changed since the last commit — invaluable for reviewing before staging.
- `git log --oneline` is the easiest way to quickly scan your history.
- **Descriptive commit messages** make history useful — `"update file"` is useless; `"docs: add branching commands section"` tells a story.

---

## Task 6: Understanding the Git Workflow (Q&A)

### Q1: What is the difference between `git add` and `git commit`?

**`git add`** moves changes from the **working directory** to the **staging area**. It tells Git, *"I want these changes to be part of the next commit."* It doesn't save anything permanently.

**`git commit`** takes everything in the staging area and creates a **permanent snapshot** in the repository's history. It saves the staged changes with a message, author, timestamp, and unique hash.

**Analogy:** `git add` is like *packing items into a box*. `git commit` is like *sealing the box, labeling it, and putting it on the shelf*.

```
Working Directory  ──git add──►  Staging Area  ──git commit──►  Repository
   (editing)                      (prepared)                    (saved forever)
```

---

### Q2: What does the staging area do? Why doesn't Git just commit directly?

The **staging area** (also called the "index") is an intermediate zone that lets you **select exactly which changes** to include in a commit. This gives you fine-grained control over your history.

**Why it matters:**

| Scenario | Without Staging | With Staging |
|----------|:-:|:-:|
| You fixed a bug AND reformatted code | One messy commit with both changes | Two clean, separate commits |
| You changed 5 files but only 2 are ready | Forced to commit everything or nothing | Commit only the 2 ready files |
| You want to review before committing | Can't — changes go straight to history | `git diff --staged` lets you double-check |

> **The staging area exists so you can craft clean, logical commits** — each representing one meaningful change.

---

### Q3: What information does `git log` show you?

`git log` displays the **commit history** of the repository. For each commit, it shows:

| Field | Description | Example |
|-------|-------------|---------|
| **Commit hash** | The unique SHA-1 identifier | `a1b2c3d4e5f6a7b8c9d0...` |
| **Author** | Who made the commit | `Rameez Ahmed <rameez@example.com>` |
| **Date** | When the commit was made | `Sat Feb 21 22:10:00 2026 +0500` |
| **Message** | Why the commit was made | `feat: add initial git commands reference` |
| **Branch/tag refs** | Which branches/tags point here | `(HEAD -> main, origin/main)` |

Useful variations:
- `git log --oneline` → one line per commit (hash + message)
- `git log --graph` → ASCII branch visualization
- `git log --stat` → which files were changed per commit
- `git log -p` → full diff of each commit

---

### Q4: What is the `.git/` folder and what happens if you delete it?

The **`.git/` folder** is the heart of your Git repository. It contains:

- **The entire commit history** (every snapshot ever made)
- **All branches and tags** (references pointing to specific commits)
- **The object database** (every version of every file, stored efficiently)
- **Configuration** (repo-specific settings)
- **The staging area / index** (tracking what's ready to commit)

**If you delete `.git/`:**

```
❌ ALL commit history → GONE
❌ ALL branches and tags → GONE
❌ ALL configuration → GONE
❌ Staging area → GONE
✅ Your current files → STILL THERE (they're in the working directory)
```

> ⚠️ The directory becomes an **ordinary folder** with no Git capabilities. There is no undo — unless the remote (e.g., GitHub) still has a copy. This is why pushing to a remote is crucial!

---

### Q5: What is the difference between working directory, staging area, and repository?

These are Git's **three trees** — the core architecture of how Git manages your code:

```
┌──────────────────────────────────────────────────────────────────────┐
│                        THE THREE TREES OF GIT                        │
├──────────────────┬──────────────────┬────────────────────────────────┤
│  📂 WORKING       │  📋 STAGING       │  🏛️ REPOSITORY                 │
│  DIRECTORY        │  AREA (INDEX)    │  (.git)                       │
├──────────────────┼──────────────────┼────────────────────────────────┤
│ What you see on   │ Changes you've   │ Permanent history of          │
│ your filesystem.  │ marked as "ready │ committed snapshots.          │
│ The actual files  │ for next commit."│ Safely stored in .git/        │
│ you edit daily.   │ A preparation    │ objects/ database.            │
│                   │ zone.            │                               │
├──────────────────┼──────────────────┼────────────────────────────────┤
│ Modified files    │ Staged files     │ Committed snapshots           │
│ appear in         │ appear in        │ appear in                     │
│ `git status` as   │ `git status` as  │ `git log` as                  │
│ red (unstaged)    │ green (staged)   │ commit entries                │
├──────────────────┼──────────────────┼────────────────────────────────┤
│   Edit a file     │   git add        │   git commit                  │
│       │           │       │          │       │                       │
│       ▼           │       ▼          │       ▼                       │
│ File is modified  │ File is staged   │ Snapshot is saved permanently │
└──────────────────┴──────────────────┴────────────────────────────────┘
```

**In simple terms:**

| Area | Analogy | Key Command |
|------|---------|-------------|
| **Working Directory** | Your *desk* — where you're actively working | Edit files normally |
| **Staging Area** | Your *outbox* — items packed and labeled, ready to ship | `git add` |
| **Repository** | Your *archive* — sealed, labeled, permanently stored | `git commit` |

---

## 🧠 Summary of Key Learnings

| # | Concept | Takeaway |
|---|---------|----------|
| 1 | **Git identity** | `user.name` and `user.email` are embedded in every commit — set them first |
| 2 | **`git init`** | Creates the `.git/` directory — that's what makes a folder a repo |
| 3 | **`git status`** | Your #1 friend — always check it before `add` and `commit` |
| 4 | **Staging area** | Exists so you can craft clean, atomic commits (not dump everything) |
| 5 | **Commit messages** | Descriptive messages → useful history. Vague messages → pain later |
| 6 | **`.git/` directory** | Contains your ENTIRE history — protect it, never delete it |
| 7 | **Three trees** | Working Dir → Staging → Repository = the fundamental Git flow |
| 8 | **`git log --oneline`** | Quick way to review your commit history |

---

> 📌 *Completed as part of [#90DaysOfDevOps](https://github.com/LondheShubham153/90DaysOfDevOps) — Day 22. Git is the foundation of everything in DevOps!* 🚀
