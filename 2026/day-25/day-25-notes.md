# 📝 Day 25 Notes — Git Reset vs Revert & Branching Strategies

<div align="center">

![Day](https://img.shields.io/badge/Day-25-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Reset_Revert_&_Branching_Strategies-green?style=for-the-badge)

*Observations, answers, and research from Day 25 tasks*

</div>

---

## 📑 Table of Contents

1. [Task 1: Git Reset — Observations & Answers](#task-1-git-reset--observations--answers)
2. [Task 2: Git Revert — Observations & Answers](#task-2-git-revert--observations--answers)
3. [Task 3: Reset vs Revert — Summary Comparison](#task-3-reset-vs-revert--summary-comparison)
4. [Task 4: Branching Strategies](#task-4-branching-strategies)

---

## Task 1: Git Reset — Observations & Answers

### Hands-On Walkthrough

#### Setup: Create 3 Commits

```bash
git switch main

echo "Commit A content" > file-a.txt
git add file-a.txt && git commit -m "Commit A: Add file-a"

echo "Commit B content" > file-b.txt
git add file-b.txt && git commit -m "Commit B: Add file-b"

echo "Commit C content" > file-c.txt
git add file-c.txt && git commit -m "Commit C: Add file-c"

git log --oneline
# c3c3c3c (HEAD -> main) Commit C: Add file-c
# b2b2b2b Commit B: Add file-b
# a1a1a1a Commit A: Add file-a
```

---

#### Experiment 1: `git reset --soft HEAD~1`

```bash
git reset --soft HEAD~1

git log --oneline
# b2b2b2b (HEAD -> main) Commit B: Add file-b
# a1a1a1a Commit A: Add file-a
# ← Commit C is GONE from history

git status
# Changes to be committed:
#   new file: file-c.txt      ← Changes are STAGED (ready to re-commit)

ls file-c.txt
# file-c.txt                  ← File STILL EXISTS on disk
```

**Observation:** `--soft` removed the commit but **kept the changes staged**. It's like Git said: "I'll undo the commit, but your changes are still ready to go."

---

#### Experiment 2: `git reset --mixed HEAD~1`

```bash
# Re-commit first
git commit -m "Commit C: Add file-c (re-committed)"

# Now try mixed reset
git reset --mixed HEAD~1
# (or just: git reset HEAD~1 — mixed is the DEFAULT)

git log --oneline
# b2b2b2b (HEAD -> main) Commit B: Add file-b
# a1a1a1a Commit A: Add file-a
# ← Commit C is GONE from history

git status
# Untracked files:
#   file-c.txt                ← Changes are UNSTAGED (in working directory only)

ls file-c.txt
# file-c.txt                  ← File STILL EXISTS on disk
```

**Observation:** `--mixed` removed the commit AND unstaged the changes, but the **files remain in the working directory**. You'd need to `git add` again before committing.

---

#### Experiment 3: `git reset --hard HEAD~1`

```bash
# Re-add and commit
git add file-c.txt
git commit -m "Commit C: Add file-c (re-committed again)"

# Now try hard reset
git reset --hard HEAD~1

git log --oneline
# b2b2b2b (HEAD -> main) Commit B: Add file-b
# a1a1a1a Commit A: Add file-a
# ← Commit C is GONE from history

git status
# nothing to commit, working tree clean  ← NO changes anywhere

ls file-c.txt
# ls: cannot access 'file-c.txt': No such file or directory
# ← File is GONE from disk! ⚠️
```

**Observation:** `--hard` removed the commit, unstaged the changes, AND **deleted the files from the working directory**. Everything is gone as if the commit never happened.

---

### Question 1: What is the difference between `--soft`, `--mixed`, and `--hard`?

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    git reset --soft HEAD~1                               │
│                                                                         │
│  Repository:  ❌ Commit removed from history                            │
│  Staging:     ✅ Changes KEPT in staging area (ready to re-commit)      │
│  Working Dir: ✅ Files untouched                                        │
│                                                                         │
│  Think: "Undo the commit, but I want to fix and re-commit"             │
├─────────────────────────────────────────────────────────────────────────┤
│                    git reset --mixed HEAD~1  (DEFAULT)                   │
│                                                                         │
│  Repository:  ❌ Commit removed from history                            │
│  Staging:     ❌ Changes MOVED BACK to working directory (unstaged)     │
│  Working Dir: ✅ Files untouched                                        │
│                                                                         │
│  Think: "Undo the commit AND unstage, but keep my files"               │
├─────────────────────────────────────────────────────────────────────────┤
│                    git reset --hard HEAD~1                               │
│                                                                         │
│  Repository:  ❌ Commit removed from history                            │
│  Staging:     ❌ Staging area cleared                                   │
│  Working Dir: ❌ Files DELETED from working directory ⚠️                │
│                                                                         │
│  Think: "Nuke everything — pretend this never happened"                │
└─────────────────────────────────────────────────────────────────────────┘
```

### Visual Summary

```
                        Repository    Staging Area    Working Directory
                        (commits)     (index)         (files on disk)

 git reset --soft         ❌              ✅               ✅
 git reset --mixed        ❌              ❌               ✅
 git reset --hard         ❌              ❌               ❌

 Legend:  ✅ = preserved    ❌ = cleared/removed
```

| Mode | Commit | Staging | Working Dir | Analogy |
|------|:------:|:-------:|:-----------:|---------|
| `--soft` | ❌ Removed | ✅ Kept | ✅ Kept | "Unseal the box but keep contents packed" |
| `--mixed` | ❌ Removed | ❌ Cleared | ✅ Kept | "Unseal the box AND unpack, but keep items on desk" |
| `--hard` | ❌ Removed | ❌ Cleared | ❌ Deleted | "Throw the whole box in the trash" 🗑️ |

---

### Question 2: Which one is destructive and why?

**`git reset --hard` is the destructive one.** It's the only mode that **deletes files from your working directory**. Once those files are gone, they cannot be recovered through normal Git operations (unless they were previously committed — then `git reflog` can help).

```bash
# ⚠️ THIS IS DESTRUCTIVE:
git reset --hard HEAD~3
# The last 3 commits are gone
# All associated file changes are DELETED from disk
# No "undo" button — unless you know git reflog

# Recovery (if the commits existed before):
git reflog
# Find the commit hash BEFORE the reset
git reset --hard HEAD@{1}
# Restored! (only because reflog saved the reference)
```

**`--soft` and `--mixed` are non-destructive** because they keep your files intact. You can always re-stage and re-commit.

> ⚠️ **Warning:** Even `--hard` can't delete files that were never committed. But if you had uncommitted changes in your working directory when you did `--hard`, those changes are **permanently lost** — reflog can't help.

---

### Question 3: When would you use each one?

| Mode | When to Use | Real-World Scenario |
|------|------------|---------------------|
| `--soft` | Fix the last commit (change message, add files) | "Oops, I forgot to include a file in the last commit" |
| `--soft` | Combine multiple commits into one | "I want to squash my last 3 commits into one clean commit" |
| `--mixed` | Unstage everything and rethink what to commit | "I staged too much — let me re-organize my commits" |
| `--mixed` | Undo a commit but keep working on the files | "This commit wasn't right, let me rework the changes" |
| `--hard` | Completely abandon work and start fresh | "This experiment failed — throw it all away" |
| `--hard` | Reset to a known good state | "My working directory is a mess — reset to last commit" |

### Practical Examples

```bash
# Scenario 1: "I forgot a file in my last commit"
git reset --soft HEAD~1
git add forgotten-file.txt
git commit -m "Add feature X (with all files this time)"

# Scenario 2: "I want to squash last 3 commits into one"
git reset --soft HEAD~3
git commit -m "Add complete feature X"

# Scenario 3: "I staged the wrong files"
git reset --mixed HEAD
# (or just: git reset)
# All files are unstaged, but still in your working directory

# Scenario 4: "Throw away everything since yesterday"
git reset --hard HEAD~5
# ⚠️ Gone forever (unless reflog saves you)
```

---

### Question 4: Should you ever use `git reset` on commits that are already pushed?

**No! Almost never.** Resetting pushed commits is dangerous because:

1. **It rewrites history** — your remote will reject the push (unless you `--force`)
2. **`git push --force` overwrites remote history** — teammates who pulled those commits will have broken histories
3. **Force-pushing can permanently delete teammates' work** if they've based their commits on yours

```
┌────────────────────────────────────────────────────────────────────┐
│  WHAT HAPPENS IF YOU RESET + FORCE-PUSH SHARED COMMITS             │
│                                                                     │
│  You reset:   A ── B ── C    →    A ── B                           │
│  You push:    git push --force  (overwrites remote)                 │
│                                                                     │
│  Teammate:    A ── B ── C ── D ── E  (based work on C!)            │
│  Teammate pulls: 💥 CONFLICT — C doesn't exist on remote anymore   │
│  Their D and E commits are now orphaned                             │
│                                                                     │
│  ⚠️ NEVER do this on shared branches like main or develop          │
└────────────────────────────────────────────────────────────────────┘
```

**Instead, use `git revert`** for commits that have been pushed. Revert creates a new commit that undoes the changes — history is preserved, no one's work is affected.

```bash
# ❌ WRONG (for shared branches):
git reset --hard HEAD~1
git push --force

# ✅ CORRECT (for shared branches):
git revert HEAD
git push
```

> 💡 **Exception:** It's okay to `git reset` + `git push --force` on **your own personal branches** that no one else is working on. Many developers clean up their feature branches before creating a PR.

---

## Task 2: Git Revert — Observations & Answers

### Hands-On Walkthrough

```bash
# Create 3 commits: X, Y, Z
echo "Commit X content" > file-x.txt
git add file-x.txt && git commit -m "Commit X: Add file-x"

echo "Commit Y content" > file-y.txt
git add file-y.txt && git commit -m "Commit Y: Add file-y"

echo "Commit Z content" > file-z.txt
git add file-z.txt && git commit -m "Commit Z: Add file-z"

git log --oneline
# z9z9z9z (HEAD -> main) Commit Z: Add file-z
# y8y8y8y Commit Y: Add file-y
# x7x7x7x Commit X: Add file-x

# Revert commit Y (the MIDDLE one)
git revert y8y8y8y
# Git opens editor for revert commit message
# Default: "Revert 'Commit Y: Add file-y'"

git log --oneline
# r1r1r1r (HEAD -> main) Revert "Commit Y: Add file-y"   ← NEW revert commit
# z9z9z9z Commit Z: Add file-z                            ← Still here
# y8y8y8y Commit Y: Add file-y                            ← STILL IN HISTORY!
# x7x7x7x Commit X: Add file-x                           ← Still here

ls file-y.txt
# ls: cannot access 'file-y.txt': No such file or directory
# The file is GONE (changes undone) but the commit is STILL in history
```

### Key Observation

**Commit Y is still in the history!** Revert didn't remove it — instead, it created a **new commit** (`r1r1r1r`) that applies the **inverse** of commit Y's changes. The timeline is preserved, and everyone can see:
1. What was done (commit Y)
2. That it was undone (the revert commit)
3. Why it was undone (the revert commit message)

```
BEFORE REVERT:
  X ◄── Y ◄── Z  (HEAD)

AFTER REVERT:
  X ◄── Y ◄── Z ◄── R  (HEAD)
                     ▲
               Revert commit
               (applies the INVERSE of Y's changes)
               Y is still in history — it's just been "cancelled out"
```

---

### Question 1: How is `git revert` different from `git reset`?

| Aspect | `git reset` | `git revert` |
|--------|:-----------:|:------------:|
| **What it does** | Moves HEAD backward, erasing commits from history | Creates a NEW commit that undoes a previous commit |
| **History** | ❌ Rewrites history (commits disappear) | ✅ Preserves history (adds a new commit) |
| **Direction** | Goes backward (removes commits) | Goes forward (adds an "undo" commit) |
| **Working directory** | Depends on mode (--soft/--mixed/--hard) | Always applies inverse changes |
| **Force push needed?** | ✅ Yes (if commits were pushed) | ❌ No — it's just a new commit |

### Visual Comparison

```
GIT RESET (erases history):
  BEFORE:  A ── B ── C ── D  (HEAD)
  AFTER:   A ── B  (HEAD)
           C and D are gone from history
           (still in reflog for ~90 days)

GIT REVERT (preserves history):
  BEFORE:  A ── B ── C ── D  (HEAD)
  AFTER:   A ── B ── C ── D ── R  (HEAD)
           R is a new commit that undoes D's changes
           All commits are still visible in history
```

---

### Question 2: Why is revert considered safer than reset for shared branches?

**Revert is safer because it doesn't rewrite history.** Here's why this matters:

```
┌──────────────────────────────────────────────────────────────────┐
│  RESET on a shared branch:                                        │
│                                                                   │
│  You:      A ── B ── C   →   A ── B  (pushed with --force)       │
│  Teammate: A ── B ── C ── D ── E  (still has C)                  │
│  Result:   💥 Teammate's history diverges from remote             │
│            They must force-pull or manually reconcile             │
│            Their commits D and E may be lost                      │
│                                                                   │
│  REVERT on a shared branch:                                       │
│                                                                   │
│  You:      A ── B ── C   →   A ── B ── C ── R  (pushed normally) │
│  Teammate: A ── B ── C ── D ── E  (still has C)                  │
│  Result:   ✅ Teammate does 'git pull' — gets R cleanly           │
│            No conflicts, no broken history                        │
│            Everyone's commits are preserved                       │
└──────────────────────────────────────────────────────────────────┘
```

**In summary:**
- **Reset** requires `git push --force`, which overwrites the remote and breaks teammates' work
- **Revert** is a normal commit that can be pushed normally — teammates just `git pull` as usual
- **Revert** preserves an audit trail — you can see what was done and what was undone
- **Reset** erases evidence — it looks like the bad commit never happened

---

### Question 3: When would you use revert vs reset?

| Scenario | Use Reset ✅ | Use Revert ✅ |
|----------|:----------:|:-----------:|
| Fix the last commit **before pushing** | ✅ `--soft` | — |
| Undo a commit on a **shared/pushed** branch | ❌ | ✅ |
| Squash local commits **before pushing** | ✅ `--soft` | — |
| Undo a specific commit in the **middle** of history | ❌ | ✅ |
| Completely discard **local** experimental work | ✅ `--hard` | — |
| Need to preserve **audit trail** | ❌ | ✅ |
| Undo a merge commit on **production** | ❌ | ✅ |
| Clean up your **personal** feature branch | ✅ | — |

> 💡 **Rule of thumb:** If the commits have been **pushed** → use `revert`. If they're **local only** → use `reset`.

---

## Task 3: Reset vs Revert — Summary Comparison

| | `git reset` | `git revert` |
|---|---|---|
| **What it does** | Moves HEAD backward, removing commits from the branch history | Creates a **new commit** that undoes the changes of a specified commit |
| **Removes commit from history?** | ✅ Yes — the commit disappears from `git log` (still in reflog for ~90 days) | ❌ No — the original commit stays in history, a new "undo" commit is added |
| **Safe for shared/pushed branches?** | ❌ **No** — requires `git push --force` which can destroy teammates' work | ✅ **Yes** — it's just a new commit, push normally |
| **Working directory** | Depends on mode: `--soft` (staged), `--mixed` (unstaged), `--hard` (deleted) | Applies inverse changes, may trigger merge conflicts |
| **Direction** | Moves **backward** in history | Moves **forward** (adds new commit) |
| **When to use** | Local/unpushed commits: fixing, squashing, discarding experiments | Shared/pushed commits: safely undoing changes while preserving history |
| **Risk level** | ⚠️ Medium (`--soft`/`--mixed`) to 🔴 High (`--hard`) | 🟢 Low — non-destructive by design |
| **Requires force push?** | ✅ Yes (if commits were shared) | ❌ No |
| **Can undo a middle commit?** | ❌ Not easily — resets ALL commits after the target | ✅ Yes — can revert any specific commit |
| **Audit trail** | ❌ No record that the commit ever existed | ✅ Full record: original commit + revert commit |

### Decision Flowchart

```
                    ┌─────────────────────────┐
                    │ Need to undo a commit?  │
                    └────────────┬────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │ Has it been pushed to   │
                    │ a shared remote?        │
                    └────┬──────────────┬─────┘
                         │              │
                    YES  │              │  NO
                         │              │
                    ┌────▼─────┐   ┌────▼──────────────────┐
                    │ Use      │   │ What do you want to   │
                    │ REVERT   │   │ keep?                 │
                    │          │   └────┬─────────┬────────┘
                    │ Safe for │        │         │
                    │ everyone │   Everything  Nothing
                    └──────────┘   staged       at all
                                       │         │
                                  ┌────▼────┐ ┌──▼──────┐
                                  │ --soft  │ │ --hard  │
                                  │ reset   │ │ reset   │
                                  └─────────┘ └─────────┘
```

---

## Task 4: Branching Strategies

### 1. GitFlow

#### How It Works

GitFlow uses **multiple long-lived branches** with clear roles and a structured process for features, releases, and hotfixes.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              GITFLOW                                        │
│                                                                             │
│  main ──────●──────────────────────────●──────────────●──────────▶          │
│              │                          ▲              ▲                     │
│              │              ┌───────────┘    ┌────────┘                     │
│              │              │                │                              │
│  release ────┼──────────────●────────────────┼──────────────────▶          │
│              │              ▲                │                              │
│              │              │                │                              │
│  develop ────●──────●───●───●────────●───●───●──────────────────▶          │
│                     │   ▲        │   ▲                                      │
│                     │   │        │   │                                      │
│  feature/   ────────●───┘   ─────●───┘                                     │
│  login                   feature/                                           │
│                          signup                                             │
│                                                                             │
│  hotfix  ───────────────────────────────────●──▶  (merged to main+develop) │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### Branch Roles

| Branch | Purpose | Lifetime |
|--------|---------|----------|
| `main` | Production-ready code, tagged releases | Permanent |
| `develop` | Integration branch for features | Permanent |
| `feature/*` | New features | Temporary (merged to develop) |
| `release/*` | Prepare a release (bug fixes, versioning) | Temporary (merged to main + develop) |
| `hotfix/*` | Emergency production fixes | Temporary (merged to main + develop) |

#### When/Where It's Used

- Large teams with **scheduled release cycles** (e.g., every 2 weeks / monthly)
- Enterprise software, mobile apps, products with version numbers
- Teams that need **parallel release preparation** and development

#### Pros & Cons

| ✅ Pros | ❌ Cons |
|---------|---------|
| Clear separation of concerns | Complex — many branches to manage |
| Supports parallel development + release prep | Slow for fast-moving teams |
| Hotfix path for emergencies | Develop branch can become stale |
| Well-defined process for everyone | Merge conflicts accumulate |
| Good for versioned software | Overkill for small teams / web apps |

---

### 2. GitHub Flow

#### How It Works

GitHub Flow is **simple**: there's only `main` and short-lived feature branches. Everything goes through Pull Requests.

```
┌──────────────────────────────────────────────────────────────────┐
│                          GITHUB FLOW                              │
│                                                                   │
│  main ──────●──────────●──────────●──────────●───────────▶       │
│              \        /            \        /                     │
│               ● ── ● ──            ● ── ● ──                    │
│              feature/              feature/                       │
│              login                 settings                      │
│              (PR + merge)          (PR + merge)                  │
│                                                                   │
│  Steps:                                                           │
│  1. Branch from main                                              │
│  2. Make commits                                                  │
│  3. Open a Pull Request                                           │
│  4. Code review + discuss                                         │
│  5. Deploy/test from the branch                                   │
│  6. Merge to main                                                 │
└──────────────────────────────────────────────────────────────────┘
```

#### The Rules

1. `main` is **always deployable**
2. Create a **descriptive branch** from main for any work
3. Commit regularly and push to the remote
4. Open a **Pull Request** when ready for review
5. After approval, **merge** to main
6. **Deploy** immediately after merging

#### When/Where It's Used

- **Web applications** with continuous deployment (SaaS, web services)
- **Startups** shipping fast with small teams
- **Open-source projects** on GitHub (this is what GitHub itself uses!)
- Teams that deploy **multiple times per day**

#### Pros & Cons

| ✅ Pros | ❌ Cons |
|---------|---------|
| Dead simple — easy to learn | No release branch concept |
| Perfect for continuous deployment | Harder to manage multiple versions |
| PR-based workflow enforces code review | Assumes `main` is always deployable |
| Fast iteration cycles | Less control for scheduled releases |
| Minimal branch management | Not ideal for mobile apps with version numbers |

---

### 3. Trunk-Based Development

#### How It Works

Everyone commits to `main` (the "trunk") directly, or through **very short-lived branches** (< 1 day). Feature flags control what's visible in production.

```
┌──────────────────────────────────────────────────────────────────┐
│                    TRUNK-BASED DEVELOPMENT                        │
│                                                                   │
│  main ──●──●──●──●──●──●──●──●──●──●──●──●──●──●──●──▶          │
│          \  /    \  /          \  /                                │
│           ●       ●            ●                                  │
│          tiny    tiny          tiny                    Feature      │
│          branch  branch        branch                 flags        │
│          (hours) (hours)       (1 day max)            control      │
│                                                       visibility   │
│                                                                   │
│  Everyone pushes small changes directly to main                   │
│  Feature flags hide incomplete work from users                    │
│  Short-lived branches exist only for a few hours                  │
└──────────────────────────────────────────────────────────────────┘
```

#### Key Principles

1. **Small, frequent commits** directly to main (or via branches that live < 1 day)
2. **Feature flags** control visibility of incomplete features
3. **CI/CD pipeline** runs on every push to main
4. **No long-lived branches** — everything merges quickly
5. **Release from main** — use tags or release branches that branch off

#### When/Where It's Used

- **High-velocity teams** (Google, Meta, Netflix)
- Teams with **strong CI/CD** pipelines and automated testing
- **Large monorepos** where long-lived branches cause major merge pain
- Companies that deploy **continuously** (multiple times per hour)

#### Pros & Cons

| ✅ Pros | ❌ Cons |
|---------|---------|
| Eliminates merge conflicts (small, frequent changes) | Requires strong CI/CD and automated tests |
| Fastest possible feedback loop | Feature flags add complexity |
| Encourages small, focused commits | Not suitable for teams without CI/CD |
| Used by Google, Meta, Netflix | Requires mature engineering culture |
| No stale branches | Can be chaotic without discipline |

---

### Strategy Comparison At-a-Glance

| Feature | GitFlow | GitHub Flow | Trunk-Based |
|---------|:-------:|:-----------:|:-----------:|
| **Complexity** | 🔴 High | 🟢 Low | 🟡 Medium |
| **Long-lived branches** | ✅ main + develop | Only main | Only main |
| **Feature branches** | ✅ Long-lived | ✅ Short/medium | ✅ Very short (hours) |
| **Release process** | Release branches | Deploy from main | Deploy from main + feature flags |
| **CI/CD requirement** | Optional | Recommended | **Required** |
| **Best team size** | Large (10+ devs) | Small-Medium (2-10) | Any (with CI/CD) |
| **Deploy frequency** | Weekly / monthly | Daily / multiple per day | Continuously |
| **Learning curve** | Steep | Easy | Medium |
| **Merge conflicts** | 🔴 Common | 🟡 Moderate | 🟢 Rare |

---

### Strategic Questions Answered

#### Which strategy for a startup shipping fast?

> **GitHub Flow** ✅ — It's simple, fast, and built for continuous deployment. A startup needs to ship quickly without the overhead of managing multiple branches. The PR-based workflow still ensures code quality without slowing things down.
>
> If the startup is very mature with strong CI/CD, **Trunk-Based Development** is even faster but requires more discipline and automated testing.

#### Which strategy for a large team with scheduled releases?

> **GitFlow** ✅ — It was designed exactly for this scenario. The separate `develop`, `release`, and `hotfix` branches allow:
> - Developers to work on features without affecting the release
> - QA to stabilize the release branch while development continues
> - Emergency hotfixes to be applied without derailing the release
>
> For very large teams (50+ engineers), **Trunk-Based with release branches** can also work well (this is what Google does).

#### Which strategy does a popular open-source project use?

> **Kubernetes** uses a modified **trunk-based / GitHub Flow hybrid**:
> - `main` branch is the primary development branch
> - Feature branches are done via **forks + Pull Requests**
> - Release branches (`release-1.28`, `release-1.29`) are created for each release
> - Cherry-picks are used to backport fixes to release branches
>
> **React** (Meta) uses **trunk-based development**:
> - All development happens on `main`
> - Releases are tagged from `main`
> - Feature flags control what's enabled
>
> **Linux Kernel** uses a **unique hierarchical model**:
> - Linus Torvalds manages the `master` branch
> - Subsystem maintainers have their own trees
> - Changes flow up through a hierarchy of maintainers via pull requests (email-based!)

---

## 🧠 Summary

```
┌──────────────────────────────────────────────────────────────────┐
│                    KEY CONCEPTS — DAY 25                          │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  RESET                                                           │
│  • --soft   → undo commit, keep changes staged                   │
│  • --mixed  → undo commit, keep changes unstaged (DEFAULT)       │
│  • --hard   → undo commit, DELETE all changes ⚠️                 │
│  • NEVER reset pushed/shared commits                             │
│                                                                  │
│  REVERT                                                          │
│  • Creates a NEW commit that undoes a previous one               │
│  • History is preserved — safe for shared branches               │
│  • Use for anything that's been pushed                           │
│                                                                  │
│  BRANCHING STRATEGIES                                            │
│  • GitFlow    → complex, structured, scheduled releases          │
│  • GitHub Flow → simple, PR-based, continuous deployment         │
│  • Trunk-Based → everyone on main, feature flags, fastest        │
│                                                                  │
│  DECISION RULE                                                   │
│  • Pushed → revert    |    Local → reset                         │
│  • Startup → GitHub Flow    |    Enterprise → GitFlow            │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

<div align="center">

**Day 25 Complete ✅ — Reset, Revert & Branching Strategies mastered!** 🧠

*"The best undo is the one that doesn't break the team."*

**#90DaysOfDevOps #TrainWithShubham**

</div>
