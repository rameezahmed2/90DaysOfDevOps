# ⏪ Day 25 – Git Reset vs Revert & Branching Strategies

<div align="center">

![Day](https://img.shields.io/badge/Day-25-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Reset_Revert_&_Strategies-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Challenge](https://img.shields.io/badge/90DaysOfDevOps-2026-orange?style=for-the-badge)

*"The best undo is the one that doesn't break the team."*

</div>

---

## 🎯 Task Overview

You'll learn how to **undo mistakes** safely — one of the most important and frequently needed skills in Git. You'll also explore **branching strategies** used by real engineering teams at Google, Meta, Netflix, and open-source projects to manage code at scale.

You will:
- ⏪ Master `git reset` (soft, mixed, hard) — understand what each mode preserves
- ↩️ Use `git revert` to safely undo changes on shared branches
- ⚖️ Compare reset vs revert — know when to use which
- 🏗️ Research GitFlow, GitHub Flow, and Trunk-Based Development strategies
- 🧠 Make strategic decisions about which workflow fits which team

---

## 📚 Learning Objectives

| # | Objective | Covered |
|:-:|-----------|:-------:|
| 1 | Understand the three modes of `git reset` | ✅ |
| 2 | Know which reset mode is destructive and why | ✅ |
| 3 | Use `git revert` to safely undo pushed commits | ✅ |
| 4 | Compare reset vs revert with a decision framework | ✅ |
| 5 | Research and document three branching strategies | ✅ |
| 6 | Recommend strategies for different team sizes | ✅ |
| 7 | Update `git-commands.md` with Days 22–25 commands | ✅ |

---

## 📦 Expected Output

| # | Deliverable | Description |
|:-:|-------------|-------------|
| 1 | 📄 [`day-25-notes.md`](day-25-notes.md) | Observations, comparisons, and branching strategy research |
| 2 | 📄 [`git-commands.md`](../day-22/git-commands.md) | Updated with reset, revert, and all Days 22–25 commands |

---

## 🗺️ Reset vs Revert — Visual Map

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                                                                              │
│   GIT RESET (rewrites history — moves HEAD backward):                       │
│                                                                              │
│   BEFORE:   A ── B ── C ── D  (HEAD → main)                                │
│   AFTER:    A ── B  (HEAD → main)                                           │
│             C and D disappear from git log (still in reflog ~90 days)       │
│                                                                              │
│   --soft:   Commit ❌  |  Staging ✅  |  Files ✅     (least destructive)   │
│   --mixed:  Commit ❌  |  Staging ❌  |  Files ✅     (default)              │
│   --hard:   Commit ❌  |  Staging ❌  |  Files ❌     (most destructive)    │
│                                                                              │
│   ─────────────────────────────────────────────────────────────────────────  │
│                                                                              │
│   GIT REVERT (preserves history — adds a new "undo" commit):                │
│                                                                              │
│   BEFORE:   A ── B ── C ── D  (HEAD → main)                                │
│   AFTER:    A ── B ── C ── D ── R  (HEAD → main)                           │
│             R = new commit that undoes D's changes                          │
│             ALL original commits remain in history                          │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Challenge Tasks

### Task 1: Git Reset — Hands-On

#### Setup: Create 3 commits

```bash
echo "Commit A content" > file-a.txt
git add file-a.txt && git commit -m "Commit A: Add file-a"

echo "Commit B content" > file-b.txt
git add file-b.txt && git commit -m "Commit B: Add file-b"

echo "Commit C content" > file-c.txt
git add file-c.txt && git commit -m "Commit C: Add file-c"

git log --oneline
# c3c3c3c Commit C: Add file-c
# b2b2b2b Commit B: Add file-b
# a1a1a1a Commit A: Add file-a
```

#### Experiment 1: `--soft` Reset

```bash
git reset --soft HEAD~1

git log --oneline
# b2b2b2b Commit B: Add file-b  ← Commit C removed from history
# a1a1a1a Commit A: Add file-a

git status
# Changes to be committed:
#   new file: file-c.txt        ← Changes are STAGED ✅

ls file-c.txt                   # File EXISTS on disk ✅
```

> 💡 `--soft` = "Undo the commit, but keep changes ready to re-commit"

#### Experiment 2: `--mixed` Reset (Default)

```bash
# Re-commit, then:
git reset --mixed HEAD~1
# (or just: git reset HEAD~1)

git status
# Untracked files:
#   file-c.txt                  ← Changes are UNSTAGED (in working dir only)

ls file-c.txt                   # File EXISTS on disk ✅
```

> 💡 `--mixed` = "Undo the commit AND unstage, but keep my files"

#### Experiment 3: `--hard` Reset ⚠️

```bash
# Re-add, re-commit, then:
git reset --hard HEAD~1

git status
# nothing to commit, working tree clean

ls file-c.txt
# ls: cannot access 'file-c.txt': No such file or directory
# ⚠️ File is GONE from disk!
```

> ⚠️ `--hard` = "Nuke everything — pretend this never happened"

#### The Three Modes — Side by Side

```
                    Commit    Staging    Working Dir
 git reset --soft     ❌        ✅          ✅       "Undo commit only"
 git reset --mixed    ❌        ❌          ✅       "Undo + unstage" (DEFAULT)
 git reset --hard     ❌        ❌          ❌       "Delete everything" ⚠️
```

#### Questions Answered

| Question | Quick Answer |
|----------|-------------|
| Difference between modes? | Soft keeps staged, mixed keeps files, hard deletes everything |
| Which is destructive? | `--hard` — only mode that deletes files from disk |
| When to use each? | Soft: re-commit. Mixed: re-organize. Hard: discard entirely |
| Reset pushed commits? | **Never** on shared branches — use `revert` instead |

> 📄 See [`day-25-notes.md`](day-25-notes.md) for full detailed answers with recovery tips!

---

### Task 2: Git Revert — Hands-On

```bash
# Create 3 commits: X, Y, Z
echo "X" > file-x.txt && git add file-x.txt && git commit -m "Commit X"
echo "Y" > file-y.txt && git add file-y.txt && git commit -m "Commit Y"
echo "Z" > file-z.txt && git add file-z.txt && git commit -m "Commit Z"

# Revert commit Y (the middle one)
git log --oneline
# z9z9z9z Commit Z
# y8y8y8y Commit Y      ← revert this one
# x7x7x7x Commit X

git revert y8y8y8y

git log --oneline
# r1r1r1r Revert "Commit Y"    ← NEW revert commit
# z9z9z9z Commit Z              ← Still here
# y8y8y8y Commit Y              ← STILL IN HISTORY (but changes undone)
# x7x7x7x Commit X              ← Still here
```

**Key observation:** Commit Y is **still in the history**! Revert created a NEW commit that applies the inverse of Y's changes. The timeline is preserved.

> 📄 See [`day-25-notes.md`](day-25-notes.md) for explanations on why revert is safer!

---

### Task 3: Reset vs Revert — Summary

| | `git reset` | `git revert` |
|---|---|---|
| **What it does** | Moves HEAD backward, removing commits | Creates a new commit that undoes changes |
| **Removes commit from history?** | ✅ Yes — commits vanish from `git log` | ❌ No — original commit remains, new "undo" commit added |
| **Safe for shared/pushed branches?** | ❌ **No** — requires `--force` push, breaks teammates | ✅ **Yes** — just a normal new commit |
| **When to use** | Local/unpushed commits only | Pushed/shared commits, production branches |

### Decision Flowchart

```
              Need to undo a commit?
                      │
           Has it been pushed/shared?
              ┌───────┴───────┐
              │               │
             YES              NO
              │               │
         Use REVERT      What do you want to keep?
         (safe for       ┌────┬────┐
         everyone)       │    │    │
                      staged  files  nothing
                         │    │    │
                      --soft --mixed --hard
```

> 📄 See [`day-25-notes.md`](day-25-notes.md) for the full comparison table!

---

### Task 4: Branching Strategies

Research and document three branching strategies:

#### 1. GitFlow

```
 main ─────●──────────────────●────────●──────▶  (releases only)
            │                  ▲        ▲
 develop ───●──●──●──●──●──●──●──●──●──●──────▶  (integration)
               │  ▲     │  ▲
 feature/ ─────●──┘  ───●──┘                      (isolated work)
 hotfix  ──────────────────────────────●──▶        (emergency fixes)
```

| Aspect | Details |
|--------|---------|
| **How it works** | Two permanent branches (`main` + `develop`) plus feature, release, and hotfix branches |
| **Best for** | Large teams, scheduled releases, versioned software |
| **Pros** | Clear process, parallel development, hotfix path |
| **Cons** | Complex, many branches, slow for fast-moving teams |

#### 2. GitHub Flow

```
 main ──────●──────●──────●──────●──────▶  (always deployable)
             \    /        \    /
              ●──●          ●──●            (feature branches + PRs)
```

| Aspect | Details |
|--------|---------|
| **How it works** | Single `main` branch + short-lived feature branches + Pull Requests |
| **Best for** | Startups, web apps, continuous deployment |
| **Pros** | Simple, fast, PR-based code review |
| **Cons** | No release branches, assumes main is always deployable |

#### 3. Trunk-Based Development

```
 main ──●──●──●──●──●──●──●──●──●──●──●──▶  (everyone commits here)
         \/ \/ \/                              (tiny branches, hours only)
         Feature flags control visibility
```

| Aspect | Details |
|--------|---------|
| **How it works** | Everyone commits to `main` directly or via very short-lived branches (< 1 day) |
| **Best for** | High-velocity teams with strong CI/CD (Google, Meta, Netflix) |
| **Pros** | No merge conflicts, fastest feedback, encourages small commits |
| **Cons** | Requires CI/CD, feature flags add complexity |

#### Strategic Recommendations

| Question | Recommendation |
|----------|---------------|
| Startup shipping fast? | **GitHub Flow** — simple, fast, PR-based |
| Large team, scheduled releases? | **GitFlow** — structured, parallel work |
| Favorite open-source project? | Kubernetes uses trunk-based/GitHub Flow hybrid with release branches |

> 📄 See [`day-25-notes.md`](day-25-notes.md) for full diagrams, pro/con analysis, and real-world examples!

---

### Task 5: Git Commands Reference Update

> 📖 The [`git-commands.md`](../day-22/git-commands.md) has been continuously updated across Days 22–25 and now contains:

| Day | Commands Added | Total |
|:---:|---------------|:-----:|
| Day 22 | Setup, Workflow, Viewing, History, Undo, Remove | 10 |
| Day 23 | Branching, Switching, Remotes, Push/Pull/Fetch, Clone/Fork, Stash | 20 |
| Day 24 | Advanced Merging, Rebase, Cherry-Pick, Reflog | 26 |
| Day 25 | Reset (--soft/--mixed/--hard), Revert | **30** |

The reference now spans **16 organized sections** covering every Git command from setup to advanced undo operations.

---

## ✅ Task Completion Checklist

- [x] ⏪ **`git reset --soft`** — Undid commit, changes stayed staged
- [x] ⏪ **`git reset --mixed`** — Undid commit, changes moved to working directory
- [x] ⏪ **`git reset --hard`** — Undid commit, everything deleted from disk
- [x] ❓ **Reset Questions** — Differences, destructiveness, use cases, pushed commits
- [x] ↩️ **`git revert`** — Reverted middle commit, original stayed in history
- [x] ↩️ **Revert Questions** — Reset vs revert, safety, when to use each
- [x] ⚖️ **Comparison Table** — Reset vs revert with decision flowchart
- [x] 🏗️ **GitFlow** — Documented with diagram, use case, pros/cons
- [x] 🏗️ **GitHub Flow** — Documented with diagram, use case, pros/cons
- [x] 🏗️ **Trunk-Based** — Documented with diagram, use case, pros/cons
- [x] 🧠 **Strategic Questions** — Startup, enterprise, and open-source recommendations
- [x] 📖 **`git-commands.md`** — Updated with 30 commands across 16 sections (Days 22–25)

---

## 📔 Ongoing Task

> **Your `git-commands.md` now covers Days 22–25** with 30 commands across 16 sections! This living document has grown from a simple reference into a comprehensive Git handbook. Keep updating it as you learn more advanced Git topics.

---

## 🧠 Key Takeaways

1. **`git reset` rewrites history, `git revert` preserves it** — This is the most important distinction. Reset erases commits; revert creates new "undo" commits.

2. **Only `--hard` is truly destructive** — `--soft` and `--mixed` keep your files safe. `--hard` deletes files from disk with no undo (unless reflog saves you).

3. **Pushed = Revert. Local = Reset.** — This is the golden rule of undoing changes. Never force-push reset commits on shared branches.

4. **Reflog is your safety net** — Even after `--hard` reset, `git reflog` can help you recover commits that existed before. It tracks every HEAD movement for ~90 days.

5. **No branching strategy is universally best** — GitFlow suits enterprises with releases. GitHub Flow suits startups. Trunk-Based suits teams with strong CI/CD. Choose based on your team size, release cadence, and CI/CD maturity.

6. **Feature flags unlock Trunk-Based Development** — The "everyone commits to main" strategy requires feature flags to hide incomplete work from production users.

7. **Your Git journey is now complete (Days 22–25)** — You've covered everything from `git init` to branching strategies. You can confidently use Git for any DevOps workflow.

---

## 💡 Hints

- `git reflog` is your safety net — it shows everything Git has done, even after a hard reset
- For branching strategies, look at how projects like Kubernetes, React, or Linux kernel manage branches
- Use `git log --oneline --graph --all` to visualize the impact of reset and revert

---

## 📤 Submission

1. Add your `day-25-notes.md` to `2026/day-25/`
2. Update `git-commands.md` — commit and push
3. Push to your fork
4. Add your submission for Community Builder of the week on discord

---

## 🌐 Learn in Public

Share your Reset vs Revert comparison or your branching strategy notes on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

---

<div align="center">

**Happy Learning! 🎉**  
**TrainWithShubham**

</div>
