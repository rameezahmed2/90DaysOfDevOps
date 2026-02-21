# 🌿 Day 22 – Introduction to Git: Your First Repository

<div align="center">

![Day](https://img.shields.io/badge/Day-22-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Git_Basics-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Challenge](https://img.shields.io/badge/90DaysOfDevOps-2026-orange?style=for-the-badge)

*"Every great DevOps pipeline starts with `git init`."*

</div>

---

## 🎯 Task Overview

Today marks the beginning of your **Git journey**. Git is the backbone of modern DevOps — every tool, pipeline, and workflow revolves around version control. Before diving into advanced concepts, you need to get comfortable with the basics by doing.

You will:
- 🧠 Understand what Git is and why it matters
- 🏗️ Set up your first Git repository from scratch
- 📝 Start building a living document of Git commands

---

## 📚 Learning Objectives

| # | Objective | Covered |
|:-:|-----------|:-------:|
| 1 | Install and configure Git with your identity | ✅ |
| 2 | Initialize a repository and understand `.git/` internals | ✅ |
| 3 | Master the stage → commit workflow | ✅ |
| 4 | Build a living Git commands reference | ✅ |
| 5 | Create meaningful commit history (3+ commits) | ✅ |
| 6 | Understand working directory vs staging vs repository | ✅ |

---

## 📦 Expected Output

| # | Deliverable | Description |
|:-:|-------------|-------------|
| 1 | 📂 `devops-git-practice/` | A local Git repository with a clean commit history |
| 2 | 📄 [`git-commands.md`](git-commands.md) | Comprehensive Git commands reference (to be updated daily) |
| 3 | 📄 [`day-22-notes.md`](day-22-notes.md) | Conceptual answers about the Git workflow |

---

## 🗺️ Git Workflow — Visual Map

```
┌──────────────────────────────────────────────────────────────┐
│                    THE GIT WORKFLOW                           │
│                                                              │
│  ┌─────────────┐    git add    ┌──────────┐   git commit   ┌─────────────┐
│  │   WORKING   │ ───────────▶  │ STAGING  │ ────────────▶  │ REPOSITORY  │
│  │  DIRECTORY  │               │  AREA    │                │   (.git/)   │
│  │             │  ◀─────────── │ (Index)  │                │             │
│  │ edit files  │  git restore  │          │                │  commits    │
│  └─────────────┘               └──────────┘                └─────────────┘
│        │                                                          │
│        │                    git diff                              │
│        │◀────────────────────────────────────────────────────────▶│
│        │                  git diff HEAD                           │
│                                                                  │
│  ┌───────────────────────────────────────────────────────────┐   │
│  │                  git log / git log --oneline              │   │
│  │  Shows the history of all commits in the repository       │   │
│  └───────────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Challenge Tasks

### Task 1: Install and Configure Git

1. Verify Git is installed on your machine
2. Set up your Git identity — name and email
3. Verify your configuration

```bash
# Verify installation
git --version

# Set identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify configuration
git config --list
```

---

### Task 2: Create Your Git Project

1. Create a new folder called `devops-git-practice`
2. Initialize it as a Git repository
3. Check the status — read and understand what Git is telling you
4. Explore the hidden `.git/` directory — look at what's inside

```bash
mkdir devops-git-practice
cd devops-git-practice
git init
git status
ls -la .git/
```

#### 📁 Inside the `.git/` Directory

```
.git/
├── HEAD            # Points to current branch (refs/heads/main)
├── config          # Repo-specific configuration
├── description     # Used by GitWeb (rarely used)
├── hooks/          # Client/server-side hook scripts
├── info/           # Global exclude patterns
├── objects/        # All content (blobs, trees, commits)
└── refs/           # Pointers to commits (branches, tags)
```

---

### Task 3: Create Your Git Commands Reference

1. Create a file called `git-commands.md` inside the repo
2. Add the Git commands you've used so far, organized by category:
   - **Setup & Config**
   - **Basic Workflow**
   - **Viewing Changes**
3. For each command, write:
   - What it does (1 line)
   - An example of how to use it

> 📄 See [`git-commands.md`](git-commands.md) for the complete reference!

---

### Task 4: Stage and Commit

1. Stage your file
2. Check what's staged
3. Commit with a meaningful message
4. View your commit history

```bash
git add git-commands.md
git status                              # Shows staged files in green
git commit -m "Add initial git commands reference"
git log                                 # View full commit details
```

---

### Task 5: Make More Changes and Build History

1. Edit `git-commands.md` — add more commands as you discover them
2. Check what changed since your last commit
3. Stage and commit again with a different, descriptive message
4. Repeat this process at least **3 times** so you have multiple commits in your history
5. View the full history in a compact format

```bash
# After editing
git diff                                # See what changed
git add git-commands.md
git commit -m "Add viewing changes section to git commands"

# View compact history
git log --oneline
```

#### 📸 Sample `git log --oneline` Output

```
a1b2c3d (HEAD -> main) Add day-22 notes with Git workflow answers
f4e5d6c Add viewing changes and history commands
b7a8c9d Add basic workflow commands to reference
1e2f3a4 Add initial git commands reference with setup section
```

---

### Task 6: Understand the Git Workflow

Answer these questions in your own words (add them to a `day-22-notes.md` file):

1. What is the difference between `git add` and `git commit`?
2. What does the **staging area** do? Why doesn't Git just commit directly?
3. What information does `git log` show you?
4. What is the `.git/` folder and what happens if you delete it?
5. What is the difference between a **working directory**, **staging area**, and **repository**?

> 📄 See [`day-22-notes.md`](day-22-notes.md) for detailed answers!

---

## ✅ Task Completion Checklist

- [x] 🔧 **Git Installed & Configured** — Version verified, identity set (name + email)
- [x] 📂 **Repository Created** — `devops-git-practice/` initialized with `git init`
- [x] 📁 **`.git/` Explored** — Understood internal structure (HEAD, objects, refs)
- [x] 📄 **`git-commands.md` Created** — Organized by Setup, Workflow, Viewing, and History categories
- [x] 💾 **Multiple Commits** — 3+ commits with meaningful messages
- [x] 📝 **`day-22-notes.md` Created** — All 5 conceptual questions answered
- [x] 📸 **Commit History** — Clean `git log --oneline` output

---

## 📔 Ongoing Task

> **Keep updating `git-commands.md` every day** as you learn new Git commands in the upcoming days. This will become your personal Git reference. Maintain a clean commit history — one commit per update with a clear message.

---

## 🧠 Key Takeaways

1. **Git tracks content, not files** — Git stores snapshots of your entire project at each commit, not individual file changes.
2. **The staging area is your safety net** — It lets you craft precise commits by choosing exactly what goes into each snapshot.
3. **`.git/` IS the repository** — Delete it and you lose all history. The working directory files remain, but Git forgets everything.
4. **Commit messages matter** — Good messages are like breadcrumbs for your future self. Use imperative mood: "Add feature" not "Added feature".
5. **`git status` is your best friend** — When in doubt, run `git status`. It tells you exactly what's going on.

---

## 💡 Hints

- All you need today are about 8-10 Git commands — Google them, try them, break things
- Read what `git status` tells you — it's your best friend
- Use `man git-<command>` or `git <command> --help` to explore

---

## 📤 Submission
1. Share a screenshot of your `git log --oneline` output showing multiple commits
2. Add your `day-22-notes.md` to `2026/day-22/`
3. Commit and push to your fork
4. Add your submission for Community Builder of the week on discord

---

## 🌐 Learn in Public

Share your first Git repo and commit history on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

---

<div align="center">

**Happy Learning! 🎉**  
**TrainWithShubham**

</div>
