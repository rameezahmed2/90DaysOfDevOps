# 🔀 Day 24 – Advanced Git: Merge, Rebase, Stash & Cherry Pick

<div align="center">

![Day](https://img.shields.io/badge/Day-24-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Advanced_Git-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Challenge](https://img.shields.io/badge/90DaysOfDevOps-2026-orange?style=for-the-badge)

*"Merge to collaborate, rebase to clean up, stash to context-switch, cherry-pick to rescue."*

</div>

---

## 🎯 Task Overview

You know how to branch and push to GitHub. Now it's time to learn how branches **come back together** — and what to do when you're in the middle of something and need to context-switch. These are the Git skills that separate beginners from **confident practitioners**.

You will:
- 🔀 Master merging — fast-forward, merge commits, and conflict resolution
- ♻️ Understand rebasing — how it rewrites history for a clean timeline
- 🗜️ Compare squash merge vs regular merge — trade-offs in history
- 📦 Use `git stash` to juggle multiple tasks seamlessly
- 🍒 Cherry-pick specific commits across branches like a surgeon

---

## 📚 Learning Objectives

| # | Objective | Covered |
|:-:|-----------|:-------:|
| 1 | Perform fast-forward and three-way merges | ✅ |
| 2 | Create and resolve merge conflicts intentionally | ✅ |
| 3 | Rebase a branch and understand history rewriting | ✅ |
| 4 | Compare squash merge vs regular merge | ✅ |
| 5 | Use `git stash` to save/restore work-in-progress | ✅ |
| 6 | Cherry-pick specific commits across branches | ✅ |
| 7 | Know when to use each strategy in production | ✅ |

---

## 📦 Expected Output

| # | Deliverable | Description |
|:-:|-------------|-------------|
| 1 | 📄 [`day-24-notes.md`](day-24-notes.md) | Observations, diagrams, and conceptual answers |
| 2 | 📄 [`git-commands.md`](../day-22/git-commands.md) | Updated with merge, rebase, cherry-pick, & reflog commands |

---

## 🗺️ Merge vs Rebase — Visual Map

```
┌──────────────────────────────────────────────────────────────────────────┐
│                                                                          │
│   MERGE (preserves branch structure):                                    │
│                                                                          │
│        ┌── D1 ── D2 ── D3 ──┐                                           │
│   C1 ── C2                    M  ◁── main (merge commit, 2 parents)     │
│        └── C4 ──────────────┘                                            │
│                                                                          │
│   ─────────────────────────────────────────────────────────────────────  │
│                                                                          │
│   REBASE (creates linear history):                                       │
│                                                                          │
│   C1 ── C2 ── C4 ── D1' ── D2' ── D3'  ◁── feature (rebased on main)  │
│                ▲                                                         │
│               main                                                       │
│                                                                          │
│   Commits are REPLAYED — D1', D2', D3' have new hashes                  │
│                                                                          │
│   ─────────────────────────────────────────────────────────────────────  │
│                                                                          │
│   SQUASH MERGE (one combined commit):                                    │
│                                                                          │
│   C1 ── C2 ── C4 ── S  ◁── main (single squash commit)                 │
│                                                                          │
│   All D1+D2+D3 changes combined into one commit S                       │
│                                                                          │
│   ─────────────────────────────────────────────────────────────────────  │
│                                                                          │
│   CHERRY-PICK (one specific commit):                                     │
│                                                                          │
│   C1 ── C2 ── C4 ── D2'   ◁── main (only commit D2 was picked)         │
│        └── D1 ── D2 ── D3  ◁── feature (unchanged)                     │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Challenge Tasks

### Task 1: Git Merge — Hands-On

#### Part A: Fast-Forward Merge

```bash
# Create feature-login from main, add commits
git switch main
git switch -c feature-login
echo "Login page HTML" > login.html
git add login.html && git commit -m "Add login page structure"
echo "Login validation JS" > login.js
git add login.js && git commit -m "Add login validation logic"

# Switch back to main and merge
git switch main
git merge feature-login
# Output: Fast-forward  ← main had NOT moved, so Git just moved the pointer
```

```
FAST-FORWARD:  main simply moves forward to feature-login's tip
  
  C1 ── C2 ── C3 ── C4   (main catches up, no new commit created)
                     ▲
                  main + feature-login
```

#### Part B: Three-Way Merge (Merge Commit)

```bash
# Create feature-signup, add commits
git switch -c feature-signup
echo "Signup form" > signup.html
git add signup.html && git commit -m "Add signup form"

# Go back to main and add a commit there TOO
git switch main
echo "Updated homepage" > index.html
git add index.html && git commit -m "Update homepage on main"

# Now merge — both branches have diverged!
git merge feature-signup -m "Merge feature-signup into main"
# Merge made by the 'ort' strategy.  ← Created a merge commit
```

```
THREE-WAY MERGE:  both branches have unique commits → merge commit created

       ┌── C5  (feature-signup)
  C1 ── C4
       └── C6  (main) ── M  (merge commit with TWO parents)
```

#### Part C: Creating a Merge Conflict (Intentionally)

```bash
# Edit the SAME line on both branches
git switch main
echo "Welcome to our app v2.0" > README.md
git add README.md && git commit -m "Update welcome message on main"

git switch feature-login
echo "Welcome to the Login Portal" > README.md
git add README.md && git commit -m "Update welcome on feature-login"

git switch main
git merge feature-login
# CONFLICT! Same line edited in both branches
# Edit the file, resolve markers (<<<<<<, ======, >>>>>>), then:
git add README.md
git commit -m "Resolve merge conflict in README.md"
```

#### Answers

> 📄 See [`day-24-notes.md`](day-24-notes.md) for detailed answers with ASCII diagrams on:
> - What is a fast-forward merge?
> - When does Git create a merge commit?
> - What is a merge conflict and how to resolve it?

---

### Task 2: Git Rebase — Hands-On

```bash
# Create feature-dashboard, add commits
git switch main
git switch -c feature-dashboard
echo "Dashboard layout" > dashboard.html
git add dashboard.html && git commit -m "Add dashboard layout"
echo "Dashboard charts" > charts.js
git add charts.js && git commit -m "Add dashboard charts"
echo "Dashboard styles" > dashboard.css
git add dashboard.css && git commit -m "Add dashboard styles"

# Move main ahead
git switch main
echo "Updated footer" > footer.html
git add footer.html && git commit -m "Update footer on main"

# Rebase feature-dashboard onto main
git switch feature-dashboard
git rebase main
# Successfully rebased and updated refs/heads/feature-dashboard.

# Visualize the result
git log --oneline --graph --all
```

#### Before vs After Rebase

```
BEFORE:                           AFTER:
                                  
       ┌── D1 ── D2 ── D3                          D1' ── D2' ── D3'
  C1 ── C2                          C1 ── C2 ── C4 ─┘
       └── C4 (main)                         (main)  (feature-dashboard)
                                  
  Branches diverge                 Linear! D1-D3 are replayed on top of C4
```

#### Key Questions Answered

| Question | Quick Answer |
|----------|-------------|
| What does rebase do? | Replays your commits on top of another branch, creating new commits with new hashes |
| How is history different? | Linear (no merge commits) vs branching (merge preserves branch structure) |
| Why never rebase shared commits? | Rewrites history — teammates who based work on old commits will face conflicts |
| Rebase vs merge? | Rebase to keep feature branches current; merge to integrate finished features |

> 📄 See [`day-24-notes.md`](day-24-notes.md) for the full explanation with the Golden Rule of Rebase!

---

### Task 3: Squash Commit vs Merge Commit

#### Squash Merge

```bash
# Create feature-profile with many small commits
git switch main
git switch -c feature-profile
echo "Profile page" > profile.html
git add profile.html && git commit -m "Add profile page"
echo "Name field" >> profile.html
git add profile.html && git commit -m "Add name field"
echo "Email field" >> profile.html
git add profile.html && git commit -m "Add email field"
echo "Fix typo" >> profile.html
git add profile.html && git commit -m "Fix typo in profile"
echo "Bio section" >> profile.html
git add profile.html && git commit -m "Add bio section"

# Squash merge — 5 commits become 1
git switch main
git merge --squash feature-profile
git commit -m "Add complete profile page feature"
# Result: ONE commit on main with ALL changes
```

#### Regular Merge (for comparison)

```bash
git switch -c feature-settings
echo "Settings" > settings.html
git add settings.html && git commit -m "Add settings page"
echo "Dark mode" >> settings.html
git add settings.html && git commit -m "Add dark mode toggle"

git switch main
git merge feature-settings
# Result: All individual commits + merge commit preserved in history
```

#### Comparison Table

| Aspect | Squash Merge | Regular Merge |
|--------|:------------:|:-------------:|
| **Commits on main** | 1 (combined) | All + merge commit |
| **History** | Clean, minimal | Full, detailed |
| **Traceability** | Less (granular details lost) | More (every change visible) |
| **Git bisect** | ❌ Can't isolate within feature | ✅ Can pinpoint exact commit |
| **Best for** | Messy "WIP" branches | Well-organized feature branches |

> 📄 See [`day-24-notes.md`](day-24-notes.md) for the full trade-off analysis!

---

### Task 4: Git Stash — Hands-On

```bash
# Start working on something
echo "New navbar design WIP" >> index.html

# Urgent task! Try to switch — Git blocks you
git switch feature-login
# error: Your local changes would be overwritten by checkout

# Stash your work
git stash push -m "WIP: new navbar design"
# Saved working directory and index state

# Now switch freely, do urgent work
git switch feature-login
echo "Hotfix" > hotfix.txt
git add hotfix.txt && git commit -m "Apply emergency hotfix"

# Come back and restore
git switch main
git stash pop
# Your WIP changes are back exactly where you left them!
```

#### Multiple Stashes

```bash
git stash push -m "WIP: Feature A"       # First stash
git stash push -m "WIP: Feature B"       # Second stash
git stash list                            # See all stashes
git stash apply stash@{1}                # Apply specific stash
git stash drop stash@{1}                 # Remove specific stash
```

#### `pop` vs `apply`

| Aspect | `git stash pop` | `git stash apply` |
|--------|:---------------:|:------------------:|
| **Restores changes** | ✅ | ✅ |
| **Removes from stash list** | ✅ Auto-deleted | ❌ Stays in list |
| **Use case** | "Give me my work back" | "Apply but keep backup" |

> 📄 See [`day-24-notes.md`](day-24-notes.md) for real-world stash workflow scenarios!

---

### Task 5: Cherry Picking

```bash
# Create feature-hotfix with 3 commits
git switch -c feature-hotfix
echo "DB migration" > migration.sql
git add migration.sql && git commit -m "Add database migration"
echo "Security fix" > security.py
git add security.py && git commit -m "Fix critical security bug"
echo "UI update" > ui.css
git add ui.css && git commit -m "Update UI colors"

# Find the security fix commit hash
git log --oneline
# c3c3c3c Update UI colors
# b2b2b2b Fix critical security bug      ← WANT THIS ONE
# a1a1a1a Add database migration

# Cherry-pick ONLY the security fix onto main
git switch main
git cherry-pick b2b2b2b
# Only the security fix is applied — nothing else!

# Verify
git log --oneline -3
ls security.py     # EXISTS ✅
ls migration.sql   # Does NOT exist ❌
ls ui.css           # Does NOT exist ❌
```

> 📄 See [`day-24-notes.md`](day-24-notes.md) for when to use cherry-pick and potential pitfalls!

---

## 🔄 Strategy Comparison — When to Use What

| Scenario | Merge ✅ | Rebase ✅ | Squash ✅ | Cherry-Pick ✅ |
|----------|:-------:|:--------:|:--------:|:-------------:|
| Integrate finished feature into main | ✅ | — | — | — |
| Update feature branch with latest main | — | ✅ | — | — |
| Clean up messy "WIP" commits | — | — | ✅ | — |
| Hotfix needed from a feature branch | — | — | — | ✅ |
| Public/shared branch | ✅ | ❌ | ✅ | ✅ |
| Linear history needed | — | ✅ | ✅ | — |
| Preserve detailed commit history | ✅ | ✅ | ❌ | — |
| Backport fix to older release | — | — | — | ✅ |

---

## ✅ Task Completion Checklist

- [x] 🔀 **Fast-Forward Merge** — Performed when main hadn't moved, understood pointer movement
- [x] 🔀 **Three-Way Merge** — Created when both branches diverge, understood merge commits
- [x] 💥 **Merge Conflict** — Created intentionally, resolved with conflict markers
- [x] ♻️ **Rebase** — Replayed commits on top of main, observed linear history
- [x] ⚠️ **Golden Rule** — Never rebase shared commits (understood why)
- [x] 🗜️ **Squash Merge** — Combined 5 commits into 1, compared with regular merge
- [x] 📦 **Git Stash** — Saved WIP, switched branches, restored work
- [x] 📦 **Multiple Stashes** — Listed, applied specific, dropped stashes
- [x] 🍒 **Cherry-Pick** — Picked a single commit from another branch
- [x] 📄 **`day-24-notes.md`** — All observations and questions answered
- [x] 📖 **`git-commands.md` Updated** — Added rebase, cherry-pick, squash, reflog commands

---

## 📔 Ongoing Task

> **Keep updating `git-commands.md`** with every new Git command you learn. Today you added: advanced merge strategies (`--no-ff`, `--squash`), `git rebase` (standard + interactive), `git cherry-pick`, and `git reflog`. Your reference now has **26 commands** across **15 sections**!

---

## 🧠 Key Takeaways

1. **Merge preserves truth, rebase preserves clarity** — Merge shows the actual branch history. Rebase creates a clean, linear timeline. Both have their place.

2. **Fast-forward ≠ merge commit** — If the target branch hasn't moved, Git just moves the pointer forward (no merge commit). If both branches have unique commits, Git creates a merge commit with two parents.

3. **The Golden Rule of Rebase** — Never rebase commits that have been pushed and shared with others. Rebase rewrites history, which breaks teammates' work.

4. **Squash for messy branches** — If your branch has "WIP", "fix typo", "oops" commits, squash them into one clean commit before merging to main.

5. **Stash is your lifesaver** — When you need to context-switch mid-work, `git stash` is faster and safer than creating a "WIP" commit.

6. **Cherry-pick is a scalpel** — Use it for surgical, targeted changes (hotfixes, backports). For full features, always use merge or rebase.

7. **Reflog is your time machine** — Even after deleting branches, failed rebases, or accidental resets, `git reflog` can help you recover lost commits for ~90 days.

---

## 💡 Hints

- Visualize history: `git log --oneline --graph --all`
- To intentionally create a merge conflict: edit the **same line** of the **same file** on two branches
- Stash with a message: `git stash push -m "description"`
- Cherry-pick needs a commit hash — find it with `git log --oneline`
- Use `git reflog` if you lose commits after a rebase

---

## 📤 Submission

1. Add your `day-24-notes.md` to `2026/day-24/`
2. Update `git-commands.md` with all new commands and commit
3. Push to your fork
4. Add your submission for Community Builder of the week on discord

---

## 🌐 Learn in Public

Share your merge vs rebase comparison on LinkedIn — a diagram or screenshot of `git log --graph` goes a long way!

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

---

<div align="center">

**Happy Learning! 🎉**  
**TrainWithShubham**

</div>
