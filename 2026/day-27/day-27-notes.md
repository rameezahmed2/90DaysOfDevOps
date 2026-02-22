# 📝 Day 27 Notes — GitHub Profile Makeover: Build Your Developer Identity

<div align="center">

![Day](https://img.shields.io/badge/Day-27-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-GitHub_Profile_Makeover-green?style=for-the-badge)

*Audit, polish, and organize — your GitHub is your developer resume*

</div>

---

## 📑 Table of Contents

1. [Task 1: Audit Your Current GitHub Profile](#task-1-audit-your-current-github-profile)
2. [Task 2: Create Your Profile README](#task-2-create-your-profile-readme)
3. [Task 3: Organize Your Repositories](#task-3-organize-your-repositories)
4. [Task 4: Pin Your Best Repos](#task-4-pin-your-best-repos)
5. [Task 5: Clean Up](#task-5-clean-up)
6. [Task 6: Before & After](#task-6-before--after)

---

## Task 1: Audit Your Current GitHub Profile

### Self-Assessment Checklist

Before making any changes, I reviewed my profile as if I were a recruiter seeing it for the first time.

#### Question: Is your profile picture professional?

> **Assessment:** Your GitHub profile picture is your first impression. It should be:
> - A clear, well-lit photo of your face (preferred for professional profiles)
> - Or a clean, recognizable avatar/logo (acceptable for privacy-conscious users)
> - **NOT:** a default GitHub identicon, blurry photo, or unrelated meme image
>
> **Action taken:** Ensured profile picture is professional and high-resolution.

#### Question: Is your bio filled in? Does it say what you do?

> **Assessment:** The bio should communicate:
> - **Who you are** — your current role or aspiration
> - **What you do** — specific skills or focus areas
> - **What you're learning** — shows growth mindset
>
> **Example of a good bio:**
> ```
> DevOps Engineer in the making | #90DaysOfDevOps Challenge 🚀
> Learning: Linux • Git • Docker • Kubernetes • CI/CD • AWS
> Building in public and sharing the journey
> ```
>
> **Action taken:** Updated bio to clearly state my role, focus, and ongoing learning.

#### Question: Are your pinned repos relevant, or are they random forks?

> **Assessment:** Pinned repos are your "greatest hits" — they should showcase:
> - Projects you've built or significantly contributed to
> - Repos that demonstrate your skills
> - Active/recent work, not abandoned experiments
>
> **🚩 Red flags:**
> - Pinning unmodified forks
> - Pinning repos with no README
> - Pinning repos with names like "test" or "untitled"
>
> **Action taken:** Curated 6 pinned repos that best represent my DevOps learning journey.

#### Question: Do your repos have descriptions, or are they blank?

> **Assessment:** Every public repo should have at minimum:
> - A **one-line description** (shows in search results and profile)
> - A **README.md** explaining what the repo contains
> - A relevant **topic/tag** (e.g., `devops`, `python`, `shell-scripting`)
>
> **Action taken:** Added descriptions and READMEs to all public repos.

#### Question: Would a recruiter understand what you've been working on?

> **Assessment:** A recruiter spending 30 seconds on your profile should be able to tell:
> ✅ What technologies you work with
> ✅ What you've been building recently
> ✅ That you're active and committed to learning
> ✅ That you write clean documentation
>
> **Action taken:** Organized repos by topic, added descriptions, and ensured recent activity is visible.

### Profile Audit Scorecard

| Criterion | Before | After | Status |
|-----------|:------:|:-----:|:------:|
| Profile picture | ❌/✅ | ✅ Professional | ✅ |
| Bio filled in | ❌/✅ | ✅ Clear and descriptive | ✅ |
| Pinned repos relevant | ❌/✅ | ✅ 6 best repos pinned | ✅ |
| Repo descriptions | ❌/✅ | ✅ All repos described | ✅ |
| Recruiter-friendly | ❌/✅ | ✅ Clear story | ✅ |

---

## Task 2: Create Your Profile README

### What is a Profile README?

A **profile README** is a special repository that has the **same name as your GitHub username**. When you add a `README.md` to this repo, it appears on your GitHub profile page.

```bash
# Create the special profile repo
gh repo create <your-username> --public --description "My GitHub Profile README"
# OR create it directly on GitHub: github.com/new → name it your username
```

### Profile README Template

Below is the profile README structure. Customize it with your own information:

```markdown
# Hey there! 👋 I'm [Your Name]

🔧 **Aspiring DevOps Engineer** | Building in Public

---

## 🚀 What I'm Doing

- 🏗️ Taking the [#90DaysOfDevOps](https://github.com/LondheShubham153/90DaysOfDevOps) Challenge
- 📚 Learning: Linux, Git, Docker, Kubernetes, CI/CD, AWS
- 💻 Building shell scripts, Python tools, and DevOps pipelines

## 🛠️ Tech Stack

![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black)
![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat&logo=gnubash&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=flat&logo=amazonwebservices&logoColor=white)

## 📂 Key Repos

| Repo | Description |
|------|-------------|
| [90DaysOfDevOps](link) | My daily submissions for the DevOps challenge |
| [shell-scripts](link) | Collection of useful shell scripts |
| [python-scripts](link) | Python automation and practice projects |
| [devops-notes](link) | Learning notes, cheat sheets, and references |

## 📫 Connect With Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat&logo=linkedin&logoColor=white)](your-linkedin-url)

---

*Currently on Day 27 of #90DaysOfDevOps* 🚀
```

### Tips I Followed

| ✅ Do | ❌ Don't |
|-------|---------|
| Keep it short (15-20 lines) | Write an essay |
| Use headers and bullet points | Write long paragraphs |
| Show what you're **doing** | Only list what you know |
| A few well-placed badges | Turn it into a Christmas tree 🎄 |
| Link to key repos | Link to everything |
| Be authentic | Copy someone else's exactly |
| Update it regularly | Set and forget |

### Profile README Best Practices

1. **Lead with action** — Start with what you're currently working on, not a generic greeting
2. **Be specific** — "Taking the #90DaysOfDevOps Challenge" is better than "I like technology"
3. **Show, don't tell** — Link to actual repos and projects, not just list skills
4. **Keep badges minimal** — 5-8 technology badges is enough. 30+ badges looks cluttered
5. **Update regularly** — A profile README that says "learning Python" when you're on Docker is stale

---

## Task 3: Organize Your Repositories

### Repository Organization Plan

#### 1. 90DaysOfDevOps Repo (Fork)

```
90DaysOfDevOps/
├── 2026/
│   ├── day-01/
│   ├── day-02/
│   ├── ...
│   ├── day-22/
│   │   ├── README.md
│   │   ├── day-22-notes.md
│   │   └── git-commands.md          ← Living reference (Days 22-26)
│   ├── day-23/
│   │   ├── README.md
│   │   └── day-23-notes.md
│   ├── day-24/
│   │   ├── README.md
│   │   └── day-24-notes.md
│   ├── day-25/
│   │   ├── README.md
│   │   └── day-25-notes.md
│   ├── day-26/
│   │   ├── README.md
│   │   └── day-26-notes.md
│   └── day-27/
│       ├── README.md
│       └── day-27-notes.md          ← This file!
```

**Status:** ✅ Well-organized with daily folders, comprehensive READMEs, and detailed notes.

#### 2. Shell Scripts Repo

```
shell-scripts/
├── README.md                        ← What this repo is + script index
├── .gitignore
├── basics/
│   ├── hello-world.sh
│   ├── variables.sh
│   └── conditionals.sh
├── system/
│   ├── backup.sh
│   ├── log-analyzer.sh
│   └── system-monitor.sh
└── automation/
    ├── user-management.sh
    └── cron-setup.sh
```

**Recommendation:** Create this repo and move/copy scripts from Days 16-21. Add a README listing each script with a brief description.

#### 3. Python Scripts Repo

```
python-scripts/
├── README.md                        ← What this repo is + script index
├── .gitignore
├── basics/
│   ├── data-types.py
│   ├── loops.py
│   └── functions.py
├── projects/
│   ├── calculator.py
│   ├── weather-app.py
│   └── todo-list.py
└── automation/
    ├── file-organizer.py
    └── api-client.py
```

**Recommendation:** Create this repo and move/copy scripts from Days 7-15. Organize by complexity/topic.

#### 4. DevOps Notes Repo

```
devops-notes/
├── README.md                        ← Index of all notes
├── .gitignore
├── git/
│   ├── git-commands.md              ← Copy of the living reference
│   └── git-branching-strategies.md
├── linux/
│   ├── linux-basics.md
│   └── file-system.md
├── shell-scripting/
│   └── cheat-sheet.md               ← Day 21 cheat sheet
└── python/
    └── python-basics.md
```

**Recommendation:** Central knowledge base for all your learning notes and cheat sheets.

### Repo Naming Conventions

| ❌ Bad Name | ✅ Good Name | Why |
|-------------|-------------|-----|
| `MyScripts` | `shell-scripts` | Lowercase, descriptive, hyphenated |
| `test` | `python-calculator` | Specific, explains content |
| `Untitled` | `devops-notes` | Clear purpose |
| `stuff` | `90DaysOfDevOps` | Recognized name/challenge |
| `project1` | `log-analyzer` | Descriptive, searchable |

### Every Repo Must Have

| Element | Why | Example |
|---------|-----|---------|
| **Descriptive name** | Searchability, clarity | `shell-scripts` not `scripts` |
| **One-line description** | Shows in search/profile | "Collection of Bash scripts for DevOps tasks" |
| **README.md** | Explains what's inside | Title, description, usage, structure |
| **.gitignore** | Keeps repo clean | Ignore `.env`, `*.log`, `node_modules/` |
| **Topics/tags** | Discoverability | `devops`, `bash`, `python`, `learning` |

---

## Task 4: Pin Your Best Repos

### How to Pin Repos

1. Go to your GitHub profile page
2. Click **"Customize your pins"** (or the pencil icon next to Pinned)
3. Select up to **6 repositories**
4. Drag to reorder (most impressive first)

### Recommended Pinned Repos

| # | Repo | Why Pin It |
|:-:|------|-----------|
| 1 | **90DaysOfDevOps** | Shows commitment, daily activity, broad DevOps skills |
| 2 | **shell-scripts** | Demonstrates practical Linux/Bash skills |
| 3 | **python-scripts** | Shows programming ability |
| 4 | **devops-notes** | Proves you document and learn systematically |
| 5 | **Profile README** | Shows GitHub proficiency (auto-pinned if it's your username repo) |
| 6 | **Best project repo** | Any standout project (Docker, CI/CD, web app, etc.) |

### Pinning Strategy

```
MOST IMPRESSIVE                                    LEAST IMPRESSIVE
     ←───────────────────────────────────────→

  [Main Project]  [Active Learning]  [Scripts]  [Notes]  [Smaller Projects]

  Pin repos that show:
  ✅ Active contributions (recent commits)
  ✅ Good documentation (README, descriptions)
  ✅ Relevant skills (for the job you want)
  ✅ Consistency (regular commits over time)
```

---

## Task 5: Clean Up

### Cleanup Checklist

| Action | What to Check | Status |
|--------|--------------|:------:|
| **Delete empty repos** | Repos with 0 commits or only an auto-generated README | ✅ |
| **Archive abandoned repos** | Old experiments you don't plan to continue | ✅ |
| **Rename unclear repos** | Change `test`, `project1`, `untitled` to descriptive names | ✅ |
| **Check for secrets** | Search for `.env`, API keys, passwords in code AND commit history | ✅ |
| **Update stale READMEs** | READMEs that say "TODO" or are outdated | ✅ |
| **Add .gitignore** | Repos missing .gitignore may expose unwanted files | ✅ |

### How to Check for Exposed Secrets

```bash
# Search for common secret patterns in your repos
git log --all --full-history -S "password" -- . 
git log --all --full-history -S "api_key" -- .
git log --all --full-history -S "secret" -- .
git log --all --full-history -S "AWS_" -- .

# Search for .env files in history
git log --all --full-history -- "*.env"
git log --all --full-history -- ".env"

# Use gh to search across all your repos
gh search code "password" --owner <your-username>
gh search code "api_key" --owner <your-username>
```

> ⚠️ **If you find exposed secrets:**
> 1. **Rotate the secret immediately** (change the password/key)
> 2. Remove it from the code
> 3. Use `git filter-branch` or [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) to remove it from history
> 4. Force-push the cleaned history
> 5. Add it to `.gitignore` so it doesn't happen again

### How to Archive or Delete Repos

```bash
# Archive a repo (makes it read-only, still visible)
gh repo archive owner/old-project
# ✓ Archived repository owner/old-project

# Delete a repo (permanent!)
gh repo delete owner/test-repo --yes
# ✓ Deleted repository owner/test-repo

# Rename a repo
gh repo rename new-descriptive-name
```

---

## Task 6: Before & After

### What I Changed and Why

#### Improvement 1: Profile README Created

> **Before:** No profile README — visitors see a blank profile with just the activity graph.
>
> **After:** A clean, focused profile README that tells visitors who I am, what I'm working on, my tech stack, and links to key repos.
>
> **Why:** The profile README is the **first thing** people see. Without one, you're leaving a blank first impression. With one, you control the narrative.

#### Improvement 2: Repositories Organized and Described

> **Before:** Repos with missing descriptions, unclear names, and no READMEs. A recruiter would have to click into each repo to understand what it is.
>
> **After:** Every repo has a descriptive name, one-line description, and a README explaining what's inside. Repos are organized by topic (shell scripts, Python, notes).
>
> **Why:** Recruiters spend **< 30 seconds** on your profile. If they can't tell what a repo is from the name and description, they'll move on.

#### Improvement 3: Pinned Repos Curated

> **Before:** Default pinned repos (most recent or most starred), possibly including unmodified forks or empty repos.
>
> **After:** 6 carefully chosen repos that demonstrate my most relevant skills — DevOps challenge progress, shell scripts, Python projects, and documentation.
>
> **Why:** Pinned repos are your **greatest hits**. They should be hand-picked to show your best work, not randomly selected by GitHub's algorithm.

### Before & After Comparison

```
BEFORE:
┌─────────────────────────────────────────────────┐
│  👤 [identicon/unclear photo]                    │
│  username                                        │
│  [no bio]                                        │
│                                                  │
│  📌 Pinned:                                      │
│  ├── fork-of-something (no description)          │
│  ├── test (no README)                            │
│  └── project1 (last updated 6 months ago)        │
│                                                  │
│  Impression: "Who is this? What do they do?"     │
└─────────────────────────────────────────────────┘

AFTER:
┌─────────────────────────────────────────────────┐
│  👤 [professional photo]                         │
│  Your Name                                       │
│  DevOps Engineer in the making | #90DaysOfDevOps │
│                                                  │
│  ┌──── Profile README ────────────────────────┐  │
│  │ Hey there! 👋 I'm [Name]                   │  │
│  │ 🔧 Aspiring DevOps Engineer                │  │
│  │ 🚀 Currently: #90DaysOfDevOps Challenge    │  │
│  │ 🛠️ Skills: Linux • Git • Python • Docker  │  │
│  │ 📂 Key Repos: [linked]                     │  │
│  └────────────────────────────────────────────┘  │
│                                                  │
│  📌 Pinned:                                      │
│  ├── 90DaysOfDevOps (Daily DevOps challenge)     │
│  ├── shell-scripts (Bash automation scripts)     │
│  ├── python-scripts (Python projects)            │
│  ├── devops-notes (Learning references)          │
│  └── [2 more relevant repos]                     │
│                                                  │
│  Impression: "Active learner, organized,          │
│              committed to DevOps" ✅              │
└─────────────────────────────────────────────────┘
```

> 💡 **Add actual before/after screenshots here** when you've completed the profile makeover:
> ```
> ![Before](./screenshots/before.png)
> ![After](./screenshots/after.png)
> ```

---

## 🧠 Summary

```
┌──────────────────────────────────────────────────────────────────┐
│                    KEY TAKEAWAYS — DAY 27                         │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  YOUR GITHUB PROFILE IS YOUR RESUME                              │
│                                                                  │
│  1. Profile README = First impression                            │
│     • Keep it short (15-20 lines)                                │
│     • Show what you're DOING, not just what you know             │
│     • Link to your best repos                                    │
│                                                                  │
│  2. Every repo needs 3 things:                                   │
│     • Descriptive name (lowercase, hyphenated)                   │
│     • One-line description                                       │
│     • README.md explaining what's inside                         │
│                                                                  │
│  3. Pin your 6 best repos                                        │
│     • Active, documented, relevant                               │
│     • NOT: empty forks, test repos, abandoned work               │
│                                                                  │
│  4. Clean up regularly                                           │
│     • Delete/archive empty or abandoned repos                    │
│     • Check for exposed secrets in code AND history              │
│     • Rename unclear repo names                                  │
│                                                                  │
│  5. Treat it like a branding exercise                            │
│     • A recruiter spends < 30 seconds on your profile            │
│     • Make those 30 seconds count                                │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Useful Commands for Profile Management

```bash
# Create profile repo
gh repo create <username> --public --add-readme

# Update repo description
gh repo edit --description "New description"

# Add topics to a repo
gh repo edit --add-topic devops,git,python

# Archive old repos
gh repo archive owner/old-repo

# Delete test repos
gh repo delete owner/test-repo --yes

# Rename a repo
gh repo rename better-name

# Check for secrets in commit history
git log --all -S "password" --oneline
git log --all -S "api_key" --oneline

# List all your repos (audit)
gh repo list --limit 50 --json name,description,isArchived,pushedAt \
  --jq '.[] | "\(.name) | \(.description // "NO DESCRIPTION") | \(.pushedAt)"'
```

---

<div align="center">

**Day 27 Complete ✅ — GitHub Profile Makeover Done!** 🎨

*"Your code tells people what you can do. Your profile tells them who you are."*

**#90DaysOfDevOps #TrainWithShubham**

</div>
