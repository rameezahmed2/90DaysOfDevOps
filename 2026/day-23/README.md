# 🌿 Day 23 – Git Branching & Working with GitHub

<div align="center">

![Day](https://img.shields.io/badge/Day-23-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Git_Branching_&_GitHub-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Challenge](https://img.shields.io/badge/90DaysOfDevOps-2026-orange?style=for-the-badge)

*"Branches are cheap in Git — use them freely, merge them wisely."*

</div>

---

## 🎯 Task Overview

Now that you've mastered creating repos, staging, and committing — it's time to learn the most powerful concept in Git: **branching**. Branches let you work on features, fixes, and experiments in **complete isolation** without breaking your main code. Today you'll also push your work to **GitHub** for the first time and learn the collaboration workflow that powers open-source and DevOps teams worldwide.

You will:
- 🌿 Understand branches, HEAD, and how Git manages parallel work
- 🔀 Create, switch, and delete branches like a pro
- 🚀 Push your local repository to GitHub
- ⬇️ Pull changes from GitHub to your local machine
- 🍴 Understand the difference between Clone and Fork

---

## 📚 Learning Objectives

| # | Objective | Covered |
|:-:|-----------|:-------:|
| 1 | Understand what branches are and why they matter | ✅ |
| 2 | Create, switch, and delete branches | ✅ |
| 3 | Understand `git switch` vs `git checkout` | ✅ |
| 4 | Push branches to GitHub and set up remotes | ✅ |
| 5 | Pull and fetch changes from remote | ✅ |
| 6 | Understand Clone vs Fork and the contribution workflow | ✅ |

---

## 📦 Expected Output

| # | Deliverable | Description |
|:-:|-------------|-------------|
| 1 | 📄 [`day-23-notes.md`](day-23-notes.md) | Conceptual answers about branching, remotes, and collaboration |
| 2 | 📄 [`git-commands.md`](../day-22/git-commands.md) | Updated with all branching & remote commands (living document) |
| 3 | 🌐 GitHub Repository | `devops-git-practice` repo pushed to GitHub with multiple branches |

---

## 🗺️ Git Branching — Visual Map

```
┌──────────────────────────────────────────────────────────────────────┐
│                    THE BRANCHING WORKFLOW                             │
│                                                                      │
│  main ─────●────────────────────●───────────●──────────▶  (stable)   │
│             \                  /             \                        │
│              ● feature-1 ────●                \                       │
│               \                                \                      │
│                ● feature-2 ─────────────────── ●                     │
│                 \                                                     │
│                  ● hotfix ──●                                        │
│                              \                                       │
│                   (merged directly to main)                          │
│                                                                      │
│  Key: ● = commit    ─── = branch history    / \ = merge              │
└──────────────────────────────────────────────────────────────────────┘
```

### How Branching Works Internally

```
                    HEAD
                     │
                     ▼
                    main
                     │
                     ▼
  C1 ◄── C2 ◄── C3 ◄── C4      (main branch)
               │
               └── C5 ◄── C6    (feature-1)
                    ▲
                    │
                 feature-1
```

> 💡 A branch is just a **41-byte file** containing a commit hash. Creating branches is **instantaneous** — Git doesn't copy any code!

---

## 🔧 Challenge Tasks

### Task 1: Understanding Branches

Answer these in your [`day-23-notes.md`](day-23-notes.md):

1. **What is a branch in Git?**
2. **Why do we use branches instead of committing everything to `main`?**
3. **What is `HEAD` in Git?**
4. **What happens to your files when you switch branches?**

> 📄 See [`day-23-notes.md`](day-23-notes.md) for detailed answers with diagrams!

---

### Task 2: Branching Commands — Hands-On

In your `devops-git-practice` repo, perform the following:

#### Step-by-Step Commands

```bash
# 1. List all branches
git branch
# * main   ← The asterisk shows your current branch

# 2. Create a new branch called 'feature-1'
git branch feature-1

# 3. Switch to feature-1
git switch feature-1
# Switched to branch 'feature-1'

# 4. Create a new branch and switch in one command
git switch -c feature-2
# Switched to a new branch 'feature-2'

# 5. Try git switch vs git checkout
git switch main               # Modern way (recommended)
git checkout feature-1        # Classic way (still works)
# Key difference: git switch ONLY does branching
# git checkout is overloaded (branches + file restore)

# 6. Make a commit on feature-1 that doesn't exist on main
git switch feature-1
echo "This is a new feature" > feature.txt
git add feature.txt
git commit -m "Add feature.txt on feature-1 branch"

# 7. Switch back to main — verify the commit is NOT there
git switch main
ls feature.txt
# Error: No such file or directory ← The file stays on feature-1!
git log --oneline
# The feature commit does NOT appear here

# 8. Delete a branch you no longer need
git branch -d feature-2
# Deleted branch feature-2

# 9. Verify branches
git branch
# * main
#   feature-1
```

#### `git switch` vs `git checkout` — Comparison

| Aspect | `git switch` | `git checkout` |
|--------|:------------:|:--------------:|
| **Purpose** | Only switches branches | Switches branches AND restores files |
| **Introduced** | Git 2.23 (2019) — modern | Original Git — legacy |
| **Create + switch** | `git switch -c <name>` | `git checkout -b <name>` |
| **Safer?** | ✅ Single-purpose | ⚠️ Overloaded — can overwrite files |
| **Recommendation** | ✅ **Preferred** | Use `git restore` for files instead |

---

### Task 3: Push to GitHub

1. Create a **new repository** on GitHub (do NOT initialize it with a README)
2. Connect your local repo to GitHub and push

```bash
# 1. Connect local repo to GitHub (after creating empty repo on GitHub)
git remote add origin https://github.com/YOUR-USERNAME/devops-git-practice.git

# 2. Verify the remote
git remote -v
# origin  https://github.com/YOUR-USERNAME/devops-git-practice.git (fetch)
# origin  https://github.com/YOUR-USERNAME/devops-git-practice.git (push)

# 3. Push main branch to GitHub
git push -u origin main
# -u sets up tracking (so future 'git push' works without arguments)

# 4. Push feature-1 branch to GitHub
git push -u origin feature-1

# 5. Verify both branches are visible on GitHub
# Go to: https://github.com/YOUR-USERNAME/devops-git-practice
# Click the branch dropdown — you should see 'main' and 'feature-1'
```

#### What is `origin` vs `upstream`?

```
┌─────────────────────────────────────────────────────────────────┐
│                          GITHUB                                  │
│                                                                  │
│  ┌─────────────────┐  fork   ┌─────────────────┐               │
│  │  Original Repo   │ ──────▶ │  Your Fork       │               │
│  │  (upstream)       │         │  (origin)         │               │
│  └────────┬─────────┘         └────────┬─────────┘               │
│           │ git fetch upstream         │ git push origin          │
│           ▼                            ▼                          │
│  ┌────────────────────────────────────────────┐                  │
│  │              YOUR LOCAL MACHINE             │                  │
│  └────────────────────────────────────────────┘                  │
└─────────────────────────────────────────────────────────────────┘
```

| Remote | Points To | Use |
|--------|-----------|-----|
| **`origin`** | Your copy (fork or direct repo) | Push changes here |
| **`upstream`** | The original repo you forked from | Pull updates from source |

> 📄 See [`day-23-notes.md`](day-23-notes.md) for a detailed explanation!

---

### Task 4: Pull from GitHub

1. Make a change **directly on GitHub** (use the web editor)
2. Pull that change to your local machine

```bash
# After editing a file on GitHub's web editor...

# Pull the change locally
git pull origin main
# This downloads + merges the remote change into your local branch

# Alternatively, the safer two-step approach:
git fetch origin              # Download changes (don't merge yet)
git diff main origin/main     # Review what changed
git merge origin/main         # Merge when you're confident
```

#### `git fetch` vs `git pull` — Key Difference

| Aspect | `git fetch` | `git pull` |
|--------|:-----------:|:----------:|
| **Downloads data?** | ✅ | ✅ |
| **Merges automatically?** | ❌ No — you review first | ✅ Yes — immediate merge |
| **Safe?** | ✅ Very safe | ⚠️ Can cause merge conflicts |
| **Equivalent to** | Just the download | `git fetch` + `git merge` |
| **Best for** | Team environments (review first) | Personal branches |

> 📄 See [`day-23-notes.md`](day-23-notes.md) for visual diagrams!

---

### Task 5: Clone vs Fork

1. **Clone** any public repository from GitHub
2. **Fork** the same repository, then clone your fork

```bash
# CLONE — Copy a repo directly to your machine
git clone https://github.com/LondheShubham153/90DaysOfDevOps.git
cd 90DaysOfDevOps

# FORK — First fork on GitHub (browser), then clone YOUR fork
git clone https://github.com/YOUR-USERNAME/90DaysOfDevOps.git
cd 90DaysOfDevOps

# Set up upstream to sync with original
git remote add upstream https://github.com/LondheShubham153/90DaysOfDevOps.git

# Keep your fork in sync
git fetch upstream
git merge upstream/main
git push origin main
```

#### Clone vs Fork — Comparison

| Aspect | Clone | Fork |
|--------|:-----:|:----:|
| **Type** | Git command | GitHub feature |
| **Creates copy** | On your local machine | On your GitHub account |
| **Can push?** | Only with write access | ✅ Always (to your fork) |
| **Contribute back?** | Direct push (if permitted) | Via Pull Request |
| **Use case** | Own repos / team repos | Open-source contributions |
| **Is it a Git concept?** | ✅ Yes | ❌ No — platform feature |

> 📄 See [`day-23-notes.md`](day-23-notes.md) for the complete Fork+Clone workflow with sync instructions!

---

## ✅ Task Completion Checklist

- [x] 🧠 **Branches Understood** — What they are, why we use them, how HEAD works
- [x] 🌿 **Branching Commands** — Create, switch, delete branches hands-on
- [x] 🔀 **`git switch` vs `git checkout`** — Modern vs legacy approach understood
- [x] 🔗 **Local ↔ Remote Connected** — `git remote add origin` configured
- [x] 🚀 **Pushed to GitHub** — Both `main` and `feature-1` branches visible
- [x] ⬇️ **Pulled from GitHub** — Made remote edit, pulled locally
- [x] 📥 **`git fetch` vs `git pull`** — Differences understood and practiced
- [x] 🍴 **Clone vs Fork** — Differences clear, fork sync workflow practiced
- [x] 📄 **`day-23-notes.md`** — All conceptual questions answered with diagrams
- [x] 📖 **`git-commands.md` Updated** — All branching & remote commands added

---

## 📔 Ongoing Task

> **Keep updating `git-commands.md` every day** as you learn new Git commands. This is your living reference! Today you added branching, switching, remote, push/pull/fetch, clone/fork, and stash commands.

---

## 🧠 Key Takeaways

1. **Branches are pointers, not copies** — Creating a branch is instantaneous because Git only creates a tiny file containing a commit hash. No code duplication.

2. **`main` should always be deployable** — Use branches for all development. Only merge to `main` when the code is tested and ready.

3. **`git switch` > `git checkout`** — Use the modern `git switch` for branches and `git restore` for files. They replaced the overloaded `git checkout`.

4. **`origin` ≠ `upstream`** — `origin` is YOUR copy (push here). `upstream` is the ORIGINAL repo (pull updates from here).

5. **`git fetch` is safer than `git pull`** — Fetch downloads without merging, giving you a chance to review. Pull merges immediately.

6. **Fork = GitHub copy, Clone = local copy** — Fork when you want to contribute to a project you don't own. Clone when you need the code locally.

7. **Keep your fork synced** — Regularly fetch from upstream and push to origin to keep your fork up-to-date.

---

## 💡 Hints

- When you create a branch, it starts from the commit you're currently on
- `git switch` is the modern alternative to `git checkout` for switching branches
- To push a new branch: `git push -u origin <branch-name>`
- A fork is a GitHub concept, not a Git concept
- Use `git stash` to temporarily save work before switching branches

---

## 📤 Submission

1. Add your `day-23-notes.md` to `2026/day-23/`
2. Update `git-commands.md` with all new commands and commit
3. Push to your fork
4. Add your submission for Community Builder of the week on discord

---

## 🌐 Learn in Public

Share your branching workflow and first GitHub push on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

---

<div align="center">

**Happy Learning! 🎉**  
**TrainWithShubham**

</div>
