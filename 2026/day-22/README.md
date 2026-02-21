# 🗂️ Day 22 – Introduction to Git: Your First Repository

<div align="center">

![Day](https://img.shields.io/badge/Day-22-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Git_Basics-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Challenge](https://img.shields.io/badge/90DaysOfDevOps-2026-orange?style=for-the-badge)

*"Git is the backbone of modern DevOps — every tool, pipeline, and workflow revolves around version control."*

</div>

---

## 🎯 Task Overview

Today marks the beginning of your **Git journey**. Git is the backbone of modern DevOps — every tool, pipeline, and workflow revolves around version control. Before diving into advanced concepts, you need to get comfortable with the basics by doing.

You will:
- 🧠 Understand what Git is and why it matters
- 🏗️ Set up your first Git repository from scratch
- 📖 Start building a living document of Git commands

---

## 📚 Learning Objectives

| # | Objective | Status |
|---|-----------|:------:|
| 1 | Install and configure Git with proper identity | ✅ |
| 2 | Initialize a repository and understand `.git/` internals | ✅ |
| 3 | Create a categorized Git commands reference | ✅ |
| 4 | Master the stage → commit workflow | ✅ |
| 5 | Build a multi-commit history with meaningful messages | ✅ |
| 6 | Understand the Three Trees: Working Dir, Staging, Repository | ✅ |

---

## 📦 Expected Output

| Deliverable | File | Description |
|-------------|------|-------------|
| 📄 Git Commands Reference | [`git-commands.md`](git-commands.md) | Living document — categorized Git commands you'll keep updating |
| 📓 Day 22 Notes | [`day-22-notes.md`](day-22-notes.md) | Task walkthroughs + conceptual Q&A answers |
| 🏗️ Local Git Repo | `devops-git-practice/` | A local repo with a clean, multi-commit history |

---

## 🗺️ Challenge Tasks — Roadmap

```
  Day 22: Introduction to Git
  ═══════════════════════════
  
  Task 1                Task 2                Task 3
  ┌──────────┐          ┌──────────┐          ┌──────────┐
  │ Install & │ ──────► │ Create   │ ──────► │ Build    │
  │ Configure │          │ Git Repo │          │ Commands │
  │ Git       │          │ + Explore│          │ Reference│
  └──────────┘          │ .git/    │          └──────────┘
                        └──────────┘               │
                                                   ▼
  Task 6                Task 5                Task 4
  ┌──────────┐          ┌──────────┐          ┌──────────┐
  │ Answer   │ ◄─────── │ Build    │ ◄─────── │ Stage &  │
  │ Workflow │          │ Commit   │          │ Commit   │
  │ Q&A      │          │ History  │          │          │
  └──────────┘          └──────────┘          └──────────┘
```

---

### Task 1: Install and Configure Git
1. Verify Git is installed on your machine
2. Set up your Git identity — name and email
3. Verify your configuration

---

### Task 2: Create Your Git Project
1. Create a new folder called `devops-git-practice`
2. Initialize it as a Git repository
3. Check the status — read and understand what Git is telling you
4. Explore the hidden `.git/` directory — look at what's inside

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

---

### Task 4: Stage and Commit
1. Stage your file
2. Check what's staged
3. Commit with a meaningful message
4. View your commit history

---

### Task 5: Make More Changes and Build History
1. Edit `git-commands.md` — add more commands as you discover them
2. Check what changed since your last commit
3. Stage and commit again with a different, descriptive message
4. Repeat this process at least **3 times** so you have multiple commits in your history
5. View the full history in a compact format

---

### Task 6: Understand the Git Workflow
Answer these questions in your own words (add them to a `day-22-notes.md` file):
1. What is the difference between `git add` and `git commit`?
2. What does the **staging area** do? Why doesn't Git just commit directly?
3. What information does `git log` show you?
4. What is the `.git/` folder and what happens if you delete it?
5. What is the difference between a **working directory**, **staging area**, and **repository**?

---

## ✅ Task Completion Checklist

- [x] ⚙️ **Task 1** — Git installed, identity configured, config verified
- [x] 📁 **Task 2** — Repo created, `git status` understood, `.git/` explored
- [x] 📖 **Task 3** — `git-commands.md` created with 8 categorized sections (40+ commands)
- [x] 📸 **Task 4** — File staged, status checked, first commit made, history viewed
- [x] 🔄 **Task 5** — 4 additional commits building up the reference document
- [x] 🧠 **Task 6** — All 5 conceptual questions answered with diagrams and analogies

---

## 🗝️ Core Concepts at a Glance

### The Three Trees of Git

```
  ┌─────────────────┐    git add     ┌─────────────────┐   git commit   ┌─────────────────┐
  │   📂 WORKING     │ ────────────► │   📋 STAGING      │ ────────────► │   🏛️ REPOSITORY   │
  │   DIRECTORY      │               │   AREA (INDEX)   │               │   (.git/)        │
  │                  │               │                  │               │                  │
  │  Your files on   │               │  "Ready for next │               │  Permanent       │
  │  disk. Edit here.│               │   commit"        │               │  snapshot history │
  └─────────────────┘               └─────────────────┘               └─────────────────┘
          ▲                                                                    │
          │              git restore / git checkout                            │
          └────────────────────────────────────────────────────────────────────┘
```

### Commit History Example

```bash
$ git log --oneline
f8e9d0c (HEAD -> main) docs: add git best practices and finalize reference
c7d8e9f docs: add remote repositories section
b6c7d8e docs: add branching commands section
a5b6c7d docs: add undoing changes section to git reference
a1b2c3d feat: add initial git commands reference document
```

---

## 📌 Ongoing Task

> **Keep updating `git-commands.md` every day** as you learn new Git commands in the upcoming days. This will become your personal Git reference. Maintain a clean commit history — one commit per update with a clear message.

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
