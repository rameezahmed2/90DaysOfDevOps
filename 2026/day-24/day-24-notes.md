# 📝 Day 24 Notes — Advanced Git: Merge, Rebase, Stash & Cherry Pick

<div align="center">

![Day](https://img.shields.io/badge/Day-24-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Advanced_Git-green?style=for-the-badge)

*Observations, answers, and hands-on learnings from Day 24 tasks*

</div>

---

## 📑 Table of Contents

1. [Task 1: Git Merge — Observations & Answers](#task-1-git-merge--observations--answers)
2. [Task 2: Git Rebase — Observations & Answers](#task-2-git-rebase--observations--answers)
3. [Task 3: Squash Commit vs Merge Commit](#task-3-squash-commit-vs-merge-commit)
4. [Task 4: Git Stash — Observations & Answers](#task-4-git-stash--observations--answers)
5. [Task 5: Cherry Picking — Observations & Answers](#task-5-cherry-picking--observations--answers)

---

## Task 1: Git Merge — Observations & Answers

### Hands-On Walkthrough

#### Scenario A: Fast-Forward Merge

```bash
# Starting from main
git switch main

# Create feature-login and add commits
git switch -c feature-login
echo "Login page HTML" > login.html
git add login.html && git commit -m "Add login page structure"
echo "Login validation JS" > login.js
git add login.js && git commit -m "Add login validation logic"

# Switch back to main and merge
git switch main
git merge feature-login
# Output: Fast-forward
#  login.html | 1 +
#  login.js   | 1 +
#  2 files changed, 2 insertions(+)
```

**Observation:** Git performed a **fast-forward** merge because `main` had not moved forward since we branched off. Git simply moved the `main` pointer forward to the latest commit on `feature-login`.

```
BEFORE MERGE:                         AFTER MERGE (fast-forward):

main                                          main, feature-login
  │                                              │
  ▼                                              ▼
  C1 ◄── C2 ◄── C3                   C1 ◄── C2 ◄── C3
                  ▲
                  │
              feature-login
```

#### Scenario B: Merge Commit (Three-Way Merge)

```bash
# Create feature-signup and add commits
git switch -c feature-signup
echo "Signup form" > signup.html
git add signup.html && git commit -m "Add signup form"

# Go back to main and add a commit THERE too
git switch main
echo "Updated homepage" > index.html
git add index.html && git commit -m "Update homepage on main"

# Now merge feature-signup — main has diverged!
git merge feature-signup
# Git opens editor for merge commit message
# Output: Merge made by the 'ort' strategy.
```

**Observation:** This time Git created a **merge commit** because both `main` and `feature-signup` had new commits since they diverged. Git had to combine changes from both, creating a new "merge commit" with two parents.

```
BEFORE MERGE:                         AFTER MERGE (merge commit):

  C1 ◄── C2 ◄── C4 (main)            C1 ◄── C2 ◄── C4 ◄── M (main)
               │                                    │        ▲
               └── C3 (feature-signup)              └── C3 ──┘
                                                      (feature-signup)
                                             M = merge commit (two parents)
```

---

### Question 1: What is a fast-forward merge?

A **fast-forward merge** occurs when the **target branch (e.g., `main`) has NOT moved forward** since the feature branch was created. There's a clean, linear path from the target branch to the source branch.

Instead of creating a merge commit, Git simply **moves the branch pointer forward** to the latest commit on the source branch. No new commit is created.

```
 FAST-FORWARD:
 
 main ──▶ C1 ◄── C2 ◄── C3 ◄── C4 ◁── feature-login
 
 After: git merge feature-login
 
 main ──▶ C1 ◄── C2 ◄── C3 ◄── C4 ◁── main (moved forward) + feature-login
```

**Conditions for fast-forward:**
- No new commits on the target branch since branching
- The target branch is strictly behind the source branch
- Clean, straight-line history — no divergence

> 💡 You can force a merge commit even when fast-forward is possible: `git merge --no-ff feature-login`. This is useful for preserving branch history in the log.

---

### Question 2: When does Git create a merge commit instead?

Git creates a **merge commit** (also called a **three-way merge**) when **both branches have independent commits** — they've diverged from their common ancestor.

```
 THREE-WAY MERGE:
 
 Common ancestor: C2
       ┌── C4 ── C5  (main)
 C1 ── C2
       └── C3 ── C6  (feature-signup)
 
 After: git merge feature-signup
 
       ┌── C4 ── C5 ──┐
 C1 ── C2              M  ◁── main (merge commit with TWO parents)
       └── C3 ── C6 ──┘
```

A merge commit is special because it has **two parents** — it records the fact that two lines of development were combined. This makes the history accurate but slightly more complex.

| Merge Type | When It Happens | New Commit? | History |
|-----------|-----------------|:-----------:|---------|
| **Fast-forward** | Target branch hasn't moved | ❌ No | Linear, clean |
| **Merge commit** | Both branches have new commits | ✅ Yes (with 2 parents) | Shows branch structure |

---

### Question 3: What is a merge conflict?

A **merge conflict** happens when Git **cannot automatically decide** how to combine changes from two branches. This occurs when:

1. **Both branches modified the same line(s)** of the same file
2. **One branch deleted a file** that the other branch modified
3. **Both branches added a file** with the same name but different content

#### Creating a Conflict Intentionally

```bash
# On main: edit line 1 of README.md
git switch main
echo "Welcome to our app - Version 2.0" > README.md
git add README.md && git commit -m "Update welcome message on main"

# On feature branch: edit the SAME line
git switch feature-login
echo "Welcome to the Login Portal" > README.md
git add README.md && git commit -m "Update welcome message on feature-login"

# Try to merge — CONFLICT!
git switch main
git merge feature-login
# CONFLICT (content): Merge conflict in README.md
# Automatic merge failed; fix conflicts and then commit the result.
```

#### What the Conflict Looks Like

```
<<<<<<< HEAD
Welcome to our app - Version 2.0
=======
Welcome to the Login Portal
>>>>>>> feature-login
```

| Marker | Meaning |
|--------|---------|
| `<<<<<<< HEAD` | Start of YOUR changes (current branch) |
| `=======` | Separator between the two versions |
| `>>>>>>> feature-login` | End of THEIR changes (incoming branch) |

#### Resolving the Conflict

```bash
# 1. Edit the file — choose what to keep (or combine both)
echo "Welcome to our app - Login Portal v2.0" > README.md

# 2. Mark the conflict as resolved
git add README.md

# 3. Complete the merge
git commit -m "Resolve merge conflict in README.md"
```

> ⚠️ **Never leave conflict markers** (`<<<<<<<`, `=======`, `>>>>>>>`) in your code! Always resolve them before committing.

---

## Task 2: Git Rebase — Observations & Answers

### Hands-On Walkthrough

```bash
# Create feature-dashboard from main
git switch main
git switch -c feature-dashboard

# Add commits on feature-dashboard
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

# Now rebase feature-dashboard onto main
git switch feature-dashboard
git rebase main
# Successfully rebased and updated refs/heads/feature-dashboard.

# Visualize the result
git log --oneline --graph --all
```

### Before vs After Rebase

```
BEFORE REBASE:

       ┌── D1 ── D2 ── D3  (feature-dashboard)
 C1 ── C2
       └── C4  (main)

AFTER REBASE:

                       ┌── D1' ── D2' ── D3'  (feature-dashboard)
 C1 ── C2 ── C4 (main)
 
 Notice: D1', D2', D3' are NEW commits (re-created on top of main)
 The original D1, D2, D3 are gone — they were rewritten
```

---

### Question 1: What does rebase actually do to your commits?

Rebase **replays your branch's commits on top of another branch**, one by one, creating **brand-new commits** in the process. Here's what happens step by step:

```
Step 1: Git finds the common ancestor (C2)
Step 2: Git saves the diffs of D1, D2, D3 (your commits)
Step 3: Git resets your branch to the tip of main (C4)
Step 4: Git replays each saved diff on top of C4:
         C4 → D1' → D2' → D3' (new commits with new hashes!)
```

**Key point:** The rebased commits (`D1'`, `D2'`, `D3'`) have **different SHA hashes** than the originals (`D1`, `D2`, `D3`) — even though the code changes are the same. This is because the parent commit changed, and the hash depends on the parent.

---

### Question 2: How is the history different from a merge?

| Aspect | Merge | Rebase |
|--------|:-----:|:------:|
| **History shape** | Non-linear (branches visible) | Linear (straight line) |
| **Merge commit?** | ✅ Yes (with 2 parents) | ❌ No extra commit |
| **Original commits preserved?** | ✅ Yes — untouched | ❌ No — rewritten with new hashes |
| **Shows branching?** | ✅ You can see where work happened in parallel | ❌ Looks like it was all done sequentially |
| **Complexity** | More complex graph | Cleaner, simpler graph |

#### Visual Comparison

```
MERGE RESULT:                          REBASE RESULT:

       ┌── D1 ── D2 ── D3 ──┐          C1 ── C2 ── C4 ── D1' ── D2' ── D3'
 C1 ── C2                     M                    (main)  (feature-dashboard)
       └── C4 ──────────────┘
            (main)                      Clean, linear — as if D1-D3 were written
                                        AFTER C4 (even though they weren't)
 Merge commit M has two parents
 You can see the branch structure
```

> 💡 **Merge preserves truth** (shows parallel work happened). **Rebase preserves clarity** (shows a clean, linear story).

---

### Question 3: Why should you NEVER rebase commits that have been pushed and shared?

Rebase **rewrites commit history** — it creates entirely new commits with new SHA hashes. If other team members have already based their work on the original commits, rebasing causes:

```
┌───────────────────────────────────────────────────────────────┐
│  WHAT GOES WRONG WHEN YOU REBASE SHARED COMMITS               │
│                                                               │
│  You had:     A ── B ── C  (pushed to GitHub)                 │
│  Teammate:    A ── B ── C ── X ── Y (based work on C)        │
│                                                               │
│  You rebase:  A ── B' ── C'  (pushed with --force)            │
│                                                               │
│  Teammate tries to pull:                                      │
│  🔥 CHAOS — Git sees B' and C' as DIFFERENT commits           │
│  than B and C. Their X and Y are now orphaned.                │
│  They get conflicts, duplicates, and broken history.          │
└───────────────────────────────────────────────────────────────┘
```

**The Golden Rule of Rebase:**

> ⚠️ **"Do not rebase commits that exist outside your repository and that people may have based work on."** — *Pro Git*

It's safe to rebase **your own local commits** that haven't been pushed. Once commits are shared, use **merge** instead.

---

### Question 4: When would you use rebase vs merge?

| Scenario | Use Merge ✅ | Use Rebase ✅ |
|----------|:----------:|:-----------:|
| Combining a **shared/public** branch | ✅ | ❌ |
| Cleaning up **local** commits before pushing | ❌ | ✅ |
| Preserving exact branch **history** | ✅ | ❌ |
| Creating a **clean, linear** history | ❌ | ✅ |
| Working on a **team feature** branch | ✅ | ❌ |
| Updating your **local** feature branch with latest main | Either | ✅ (preferred) |
| **Open-source PRs** (clean commit history) | ❌ | ✅ |

### Common Workflow

```bash
# While working on a feature, keep it up-to-date with main:
git switch feature-dashboard
git rebase main                       # Replay your commits on top of latest main
# (Resolve any conflicts that appear)

# When the feature is ready, merge into main:
git switch main
git merge feature-dashboard           # Or use --no-ff for explicit merge commit
```

> 💡 **Best practice:** Rebase to update, merge to integrate. Use rebase to keep your feature branch current, then merge the feature into main when it's complete.

---

## Task 3: Squash Commit vs Merge Commit

### Hands-On Walkthrough

#### Scenario A: Squash Merge

```bash
# Create feature-profile with many small commits
git switch -c feature-profile
echo "Profile page" > profile.html
git add profile.html && git commit -m "Add profile page"
echo "Profile name field" >> profile.html
git add profile.html && git commit -m "Add name field"
echo "Profile email field" >> profile.html
git add profile.html && git commit -m "Add email field"
echo "Profile avatar upload" >> profile.html
git add profile.html && git commit -m "Fix typo in profile"
echo "Profile bio section" >> profile.html
git add profile.html && git commit -m "Add bio section"

# Squash merge into main
git switch main
git merge --squash feature-profile
# Squash commit -- not updating HEAD
# Automatic merge went well; stopped before committing

git commit -m "Add complete profile page feature"

# Check the log
git log --oneline -5
# abc1234 (HEAD -> main) Add complete profile page feature
# ... (previous commits)
# Notice: Only ONE commit! All 5 commits were squashed into one.
```

**Observation:** The 5 small commits on `feature-profile` were **combined into a single commit** on `main`. The individual commit history from the feature branch is gone.

#### Scenario B: Regular Merge (No Squash)

```bash
# Create feature-settings with commits
git switch -c feature-settings
echo "Settings page" > settings.html
git add settings.html && git commit -m "Add settings page"
echo "Dark mode toggle" >> settings.html
git add settings.html && git commit -m "Add dark mode toggle"
echo "Notification prefs" >> settings.html
git add settings.html && git commit -m "Add notification preferences"

# Regular merge into main
git switch main
git merge feature-settings

# Check the log
git log --oneline -5
# def5678 (HEAD -> main) Merge branch 'feature-settings'
# 111aaaa Add notification preferences
# 222bbbb Add dark mode toggle
# 333cccc Add settings page
# abc1234 Add complete profile page feature
# Notice: ALL 3 individual commits + the merge commit appear!
```

---

### Question 1: What does squash merging do?

**Squash merging** takes **all the commits** from a branch and **combines them into a single changeset** that is staged (but not committed) on the target branch. You then commit it as one new commit.

```
BEFORE SQUASH MERGE:

 main ── C1 ── C2
                └── A ── B ── C ── D ── E  (feature-profile: 5 commits)

AFTER SQUASH MERGE:

 main ── C1 ── C2 ── S  (one commit containing ALL changes from A+B+C+D+E)

 The feature branch's individual commits are NOT preserved in main's history.
```

**Important notes:**
- `--squash` does NOT create a merge commit — it stages the combined changes
- You must manually `git commit` after `--squash`
- The feature branch is NOT marked as merged (Git still sees it as unmerged)

---

### Question 2: When would you use squash merge vs regular merge?

| Scenario | Use Squash Merge ✅ | Use Regular Merge ✅ |
|----------|:------------------:|:-------------------:|
| Feature with many "WIP" / "fix typo" commits | ✅ | ❌ |
| Each commit is meaningful and reviewable | ❌ | ✅ |
| You want a **clean `main` history** | ✅ | ❌ |
| You want to **preserve detailed history** | ❌ | ✅ |
| Open-source PR with messy commits | ✅ | ❌ |
| Debugging — need to `git bisect` individual changes | ❌ | ✅ |
| Compliance / audit — need complete history | ❌ | ✅ |

---

### Question 3: What is the trade-off of squashing?

| Advantage | Disadvantage |
|-----------|-------------|
| ✅ Clean, readable `main` history | ❌ Lose granular commit details |
| ✅ One commit per feature — easy to revert | ❌ Can't `git bisect` within the feature |
| ✅ Hides messy "WIP" commits | ❌ Large diffs can be hard to review |
| ✅ Simpler `git log` output | ❌ Branch not marked as "merged" in Git |
| ✅ Easy rollback (`git revert <squash-commit>`) | ❌ Lose individual author attribution if pairing |

> 💡 **Rule of thumb:** If your commits tell a **useful story** → regular merge. If they're **noise** (typo fixes, "WIP", "oops") → squash.

---

## Task 4: Git Stash — Observations & Answers

### Hands-On Walkthrough

```bash
# Start working on a file
git switch main
echo "Work in progress - new navbar" >> index.html

# Oh no! Urgent issue on another branch.
# Try to switch — Git warns you!
git switch feature-login
# error: Your local changes to the following files would be overwritten by checkout:
#   index.html
# Please commit your changes or stash them before you switch branches.

# Stash the work-in-progress
git stash push -m "WIP: new navbar design"
# Saved working directory and index state On main: WIP: new navbar design

# Now you can switch freely
git switch feature-login
# ... fix the urgent issue ...
echo "Hotfix applied" > hotfix.txt
git add hotfix.txt && git commit -m "Apply emergency hotfix"

# Switch back and restore your work
git switch main
git stash pop
# Your WIP changes are back!
```

#### Multiple Stashes

```bash
# Stash #1
echo "Feature A work" >> file-a.txt
git stash push -m "WIP: Feature A"

# Stash #2
echo "Feature B work" >> file-b.txt
git stash push -m "WIP: Feature B"

# List all stashes
git stash list
# stash@{0}: On main: WIP: Feature B
# stash@{1}: On main: WIP: Feature A

# Apply a specific stash (not the latest)
git stash apply stash@{1}
# Applies Feature A changes without removing it from stash list

# Drop a specific stash
git stash drop stash@{1}
```

---

### Question 1: What is the difference between `git stash pop` and `git stash apply`?

| Aspect | `git stash pop` | `git stash apply` |
|--------|:---------------:|:------------------:|
| **Restores changes?** | ✅ Yes | ✅ Yes |
| **Removes stash from list?** | ✅ Yes — automatically deleted | ❌ No — stays in the list |
| **Use case** | "I'm done context-switching, give me my work back" | "I want to try these changes but keep a backup" |
| **Risk** | If a conflict occurs, stash is NOT deleted (safe) | None — stash is always preserved |
| **Analogy** | Taking a book OUT of a locker (locker is empty) | Photocopying a book from a locker (book stays) |

```bash
# pop = apply + drop (if no conflicts)
git stash pop           # Apply and remove from list

# apply = restore but keep backup
git stash apply         # Apply but stash remains in list
git stash drop          # Manually remove when you're confident
```

> 💡 **Use `apply`** when you might need to apply the same stash to multiple branches. **Use `pop`** for the common case of "just give me my stuff back."

---

### Question 2: When would you use stash in a real-world workflow?

| Scenario | Why Stash Helps |
|----------|----------------|
| **Urgent hotfix** needed mid-feature | Stash WIP → switch to main → fix → switch back → pop |
| **Code review** request on another branch | Stash → switch → review → switch back → pop |
| **Pull latest changes** when you have uncommitted work | Stash → pull → pop (avoids dirty working directory conflicts) |
| **Experiment** with discarding changes temporarily | Stash → test clean state → pop to restore |
| **Context-switching** between multiple tasks | Maintain separate stashes with descriptive messages |
| **Quick branch comparison** | Stash → see clean branch state → pop |

### Real-World Stash Workflow

```bash
# 1. You're coding a feature...
echo "Login form validation" >> auth.js

# 2. Manager: "URGENT! Production bug on main!"
git stash push -m "WIP: login validation - halfway done"

# 3. Fix the bug
git switch main
git switch -c hotfix/prod-bug-42
echo "Bug fix applied" >> critical-module.js
git add . && git commit -m "Fix production crash in critical module"
git switch main && git merge hotfix/prod-bug-42
git push origin main

# 4. Back to your feature
git switch feature-login
git stash pop
# You're exactly where you left off!
```

---

## Task 5: Cherry Picking — Observations & Answers

### Hands-On Walkthrough

```bash
# Create feature-hotfix with 3 commits
git switch main
git switch -c feature-hotfix

echo "Commit 1: Database migration" > migration.sql
git add migration.sql && git commit -m "Add database migration script"

echo "Commit 2: Critical security patch" > security-patch.py
git add security-patch.py && git commit -m "Fix critical security vulnerability"

echo "Commit 3: UI color update" > ui-update.css
git add ui-update.css && git commit -m "Update UI color scheme"

# Find the commit hash of the SECOND commit (security patch)
git log --oneline
# c3c3c3c (HEAD -> feature-hotfix) Update UI color scheme
# b2b2b2b Fix critical security vulnerability    ← THIS ONE
# a1a1a1a Add database migration script

# Switch to main and cherry-pick ONLY the security patch
git switch main
git cherry-pick b2b2b2b
# [main xyz789] Fix critical security vulnerability
# 1 file changed, 1 insertion(+)

# Verify — only the security patch was applied
git log --oneline -3
# xyz789 (HEAD -> main) Fix critical security vulnerability
# ... (previous main commits)

ls security-patch.py   # EXISTS ✅
ls migration.sql       # Does NOT exist ❌  (wasn't cherry-picked)
ls ui-update.css       # Does NOT exist ❌  (wasn't cherry-picked)
```

---

### Question 1: What does cherry-pick do?

**`git cherry-pick`** takes a **single specific commit** from one branch and **applies it to your current branch** as a new commit. It's like saying: *"I only want THIS one change, not the entire branch."*

```
BEFORE CHERRY-PICK:

main ── C1 ── C2
                └── A ── B ── C  (feature-hotfix)
                         ▲
                    we want ONLY this commit

AFTER CHERRY-PICK:

main ── C1 ── C2 ── B'  (B' is a NEW commit with the same changes as B)
                └── A ── B ── C  (feature-hotfix — unchanged)
```

**Key details:**
- Cherry-pick creates a **new commit** (`B'`) with a **new hash** — it's not the same commit moved over
- The original commit (`B`) stays on its branch — nothing is removed
- The change (diff) is identical, but the commit metadata differs (different parent, different hash)

---

### Question 2: When would you use cherry-pick in a real project?

| Scenario | Why Cherry-Pick |
|----------|----------------|
| **Hotfix needed on main** | A bug fix was committed on a feature branch, but it's urgent — cherry-pick it to `main` without merging the whole feature |
| **Backporting** | A fix on the latest release needs to be applied to an older release branch |
| **Selective release** | A feature branch has 10 commits, but only 2 are ready for production |
| **Recovering lost work** | You accidentally deleted a branch — cherry-pick individual commits from the reflog |
| **Cross-team collaboration** | Another team's branch has a utility function you need, but their branch isn't ready to merge |

### Real-World Example: Hotfix Flow

```bash
# Developer found a critical bug while working on feature-payments
# The fix is commit f4e5d6c on the feature branch

# DevOps engineer cherry-picks JUST the fix onto main
git switch main
git cherry-pick f4e5d6c
git push origin main
# Production is fixed! The rest of feature-payments continues development.
```

---

### Question 3: What can go wrong with cherry-picking?

| Risk | Explanation |
|------|-------------|
| **Merge conflicts** | If the cherry-picked commit touches code that's different on your branch, Git can't auto-merge |
| **Duplicate commits** | If you later merge the entire branch, the same change exists twice (with different hashes) — Git may or may not detect this |
| **Missing context** | The cherry-picked commit may depend on earlier commits you didn't pick — the code might break |
| **Lost traceability** | It becomes harder to track where a change came from since it has a different hash on each branch |
| **Divergent branches** | Heavy cherry-picking can cause branches to diverge in confusing ways |

#### Handling Cherry-Pick Conflicts

```bash
git cherry-pick abc1234
# If conflict occurs:
# CONFLICT (content): Merge conflict in file.py

# 1. Resolve the conflict in the file
vim file.py

# 2. Stage the resolved file
git add file.py

# 3. Continue the cherry-pick
git cherry-pick --continue

# Or abort if it's too messy
git cherry-pick --abort
```

> ⚠️ **Cherry-pick is a scalpel, not a sword.** Use it sparingly for specific, isolated changes. For bringing full features together, use **merge** or **rebase**.

---

## 🧠 Summary

```
┌──────────────────────────────────────────────────────────────────┐
│                    KEY CONCEPTS — DAY 24                          │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  MERGING                                                         │
│  • Fast-forward  → branch pointer moves forward (no divergence)  │
│  • Merge commit  → combines diverged branches (two parents)      │
│  • Conflicts     → same line edited in both branches             │
│                                                                  │
│  REBASING                                                        │
│  • Replays commits on top of another branch                      │
│  • Creates NEW commits (different hashes)                        │
│  • NEVER rebase shared/pushed commits                            │
│  • Rebase to update, merge to integrate                          │
│                                                                  │
│  SQUASH                                                          │
│  • Combines all branch commits into ONE                          │
│  • Clean history, but lose granular details                      │
│  • Useful for messy "WIP" branches                               │
│                                                                  │
│  STASH                                                           │
│  • Temporarily saves uncommitted work                            │
│  • pop = apply + remove    |    apply = restore + keep           │
│  • Essential for context-switching                               │
│                                                                  │
│  CHERRY-PICK                                                     │
│  • Copies ONE specific commit to current branch                  │
│  • Creates a new commit (new hash, same changes)                 │
│  • Use sparingly — risk of duplicates and conflicts              │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 🔄 Merge vs Rebase vs Squash vs Cherry-Pick — At a Glance

| Feature | Merge | Rebase | Squash Merge | Cherry-Pick |
|---------|:-----:|:------:|:------------:|:-----------:|
| **Brings in ALL commits?** | ✅ | ✅ | ✅ (combined) | ❌ (one only) |
| **Creates merge commit?** | ✅ (if not FF) | ❌ | ❌ | ❌ |
| **Rewrites history?** | ❌ | ✅ | ✅ | ❌ (adds new) |
| **Linear history?** | ❌ | ✅ | ✅ | N/A |
| **Safe for shared branches?** | ✅ | ❌ | ✅ | ✅ |
| **Best for** | Team collaboration | Clean local updates | Messy feature branches | Targeted fixes |

---

<div align="center">

**Day 24 Complete ✅ — Advanced Git operations mastered!** 🚀

*"Merge to collaborate, rebase to clean up, stash to context-switch, cherry-pick to rescue."*

**#90DaysOfDevOps #TrainWithShubham**

</div>
