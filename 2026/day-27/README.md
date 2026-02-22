# 🎨 Day 27 – GitHub Profile Makeover: Build Your Developer Identity

<div align="center">

![Day](https://img.shields.io/badge/Day-27-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-GitHub_Profile_Makeover-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Challenge](https://img.shields.io/badge/90DaysOfDevOps-2026-orange?style=for-the-badge)

*"Your code tells people what you can do. Your profile tells them who you are."*

</div>

---

## 🎯 Task Overview

Your GitHub profile is your **developer resume**. Recruiters, hiring managers, and open-source maintainers will look at your GitHub before your LinkedIn. Today, you'll clean up your profile, organize your repositories, and create a profile README that tells your story.

This is not a coding day — it's a **branding day**. Treat it seriously.

You will:
- 🔍 Audit your current GitHub profile through a recruiter's eyes
- 📝 Create a polished profile README that appears on your profile page
- 📂 Organize repos with proper names, descriptions, and READMEs
- 📌 Pin your 6 best repositories
- 🧹 Clean up empty, abandoned, or poorly named repos
- 📸 Document the before & after transformation

---

## 📚 Learning Objectives

| # | Objective | Covered |
|:-:|-----------|:-------:|
| 1 | Audit your GitHub profile from a recruiter's perspective | ✅ |
| 2 | Create a profile README that tells your story | ✅ |
| 3 | Organize repositories with proper naming and documentation | ✅ |
| 4 | Pin the 6 repos that best represent your work | ✅ |
| 5 | Clean up and secure your public repos | ✅ |
| 6 | Document improvement with before & after comparison | ✅ |

---

## 📦 Expected Output

| # | Deliverable | Description |
|:-:|-------------|-------------|
| 1 | 🎨 Polished GitHub Profile | Profile README, organized repos, curated pins |
| 2 | 📄 [`day-27-notes.md`](day-27-notes.md) | Audit results, changes made, before & after |

---

## 🗺️ The GitHub Profile Anatomy

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                          YOUR GITHUB PROFILE                                 │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐  │
│  │  👤 Photo  │  Name • @username • Bio                                  │  │
│  │            │  🏢 Company  📍 Location  📧 Email  🔗 Website            │  │
│  │            │  👥 X followers · Y following                             │  │
│  └────────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  ┌── Profile README (the star of the show) ──────────────────────────────┐  │
│  │  # Hey there! 👋 I'm [Your Name]                                      │  │
│  │  🔧 Aspiring DevOps Engineer | #90DaysOfDevOps                        │  │
│  │  🛠️ Skills: Linux • Git • Python • Docker • AWS                      │  │
│  │  📂 Key repos: [linked]                                               │  │
│  │  📫 Connect: [LinkedIn]                                               │  │
│  └────────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  📌 Pinned Repositories (your greatest hits — pick 6)                       │
│  ┌──────────────────┐ ┌──────────────────┐ ┌──────────────────┐            │
│  │ 90DaysOfDevOps   │ │ shell-scripts    │ │ python-scripts   │            │
│  │ DevOps challenge │ │ Bash automation  │ │ Python projects  │            │
│  │ ⭐ 2  🍴 1       │ │ ⭐ 1  🔵 Shell   │ │ ⭐ 0  🟡 Python  │            │
│  └──────────────────┘ └──────────────────┘ └──────────────────┘            │
│  ┌──────────────────┐ ┌──────────────────┐ ┌──────────────────┐            │
│  │ devops-notes     │ │ docker-labs      │ │ profile-readme   │            │
│  │ Learning refs    │ │ Container work   │ │ GitHub profile   │            │
│  │ ⭐ 0  📝 Markdown │ │ ⭐ 0  🐳 Docker  │ │ ⭐ 0  📝 Markdown │            │
│  └──────────────────┘ └──────────────────┘ └──────────────────┘            │
│                                                                              │
│  📊 Contribution Graph (green squares)                                      │
│  ░░▓▓▓░░░▓▓░░▓▓▓▓▓░░░▓▓▓▓░░▓▓▓░░▓▓▓▓▓░░░▓▓▓▓░░▓▓░░▓▓▓                 │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Challenge Tasks

### Task 1: Audit Your Current GitHub Profile

Review your profile as if you were a **recruiter seeing it for the first time**:

| Question | What to Check |
|----------|--------------|
| Profile picture professional? | Clear face photo or recognizable avatar — not a default identicon |
| Bio filled in? | Says what you do + what you're learning (< 160 chars) |
| Pinned repos relevant? | Showcase your best work, not random forks |
| Repos have descriptions? | Every public repo has a one-liner explaining what it is |
| Recruiter-friendly? | Someone spending 30 seconds can tell what you do |

> 📄 See [`day-27-notes.md`](day-27-notes.md) for the full audit scorecard!

---

### Task 2: Create Your Profile README

Create a **special repository** with the same name as your GitHub username:

```bash
# Create the profile repo
gh repo create <your-username> --public --add-readme
gh repo clone <your-username>
# Edit README.md — this appears on your profile page!
```

#### Profile README Template

```markdown
# Hey there! 👋 I'm [Your Name]

🔧 **Aspiring DevOps Engineer** | Building in Public

## 🚀 What I'm Doing
- 🏗️ Taking the #90DaysOfDevOps Challenge
- 📚 Learning: Linux • Git • Docker • Kubernetes • CI/CD
- 💻 Building scripts, tools, and pipelines

## 🛠️ Tech Stack
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=black)
![Git](https://img.shields.io/badge/Git-F05032?style=flat&logo=git&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat&logo=docker&logoColor=white)

## 📫 Connect With Me
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat&logo=linkedin&logoColor=white)](your-url)

---
*Currently on Day 27 of #90DaysOfDevOps* 🚀
```

#### Profile README Tips

| ✅ Do | ❌ Don't |
|-------|---------|
| Keep it 15-20 lines max | Write an essay |
| Show what you're **doing** | Only list what you know |
| Use headers + bullet points | Write paragraphs |
| A few well-placed badges | 30+ badges (Christmas tree 🎄) |
| Link to key repos | Link to everything |
| Be authentic | Copy someone else's exactly |

> 📄 See [`day-27-notes.md`](day-27-notes.md) for the full template with customization tips!

---

### Task 3: Organize Your Repositories

Create and organize these repos with your existing work:

| # | Repo Name | Contents | Source |
|:-:|-----------|----------|--------|
| 1 | `90DaysOfDevOps` | Daily challenge submissions | Your fork |
| 2 | `shell-scripts` | All Bash scripts | Days 16-21 |
| 3 | `python-scripts` | All Python projects | Days 7-15 |
| 4 | `devops-notes` | Cheat sheets, references | Day 21 + `git-commands.md` |

#### Every Repo Must Have

```
✅ Descriptive name     → shell-scripts (NOT "scripts" or "stuff")
✅ One-line description  → "Collection of Bash scripts for DevOps tasks"
✅ README.md            → What's inside, how to use it
✅ .gitignore           → Ignore .env, *.log, node_modules/
✅ Topics/tags          → devops, bash, python, learning
```

> 📄 See [`day-27-notes.md`](day-27-notes.md) for detailed directory structure plans for each repo!

---

### Task 4: Pin Your Best Repos

Select **6 pinned repositories** that best represent your work:

```
🏆 PINNING STRATEGY — Most Impressive First

  [Main Project]  →  [Active Learning]  →  [Scripts]  →  [Notes]

  Pin repos that show:
  ✅ Active contributions (recent commits)
  ✅ Good documentation (README, descriptions)
  ✅ Relevant skills (for the job you want)
  ✅ Consistency (regular commits over time)
```

**How to pin:** GitHub Profile → "Customize your pins" → Select 6 repos → Drag to reorder

---

### Task 5: Clean Up

| Action | Command |
|--------|---------|
| Delete empty repos | `gh repo delete owner/test-repo --yes` |
| Archive abandoned repos | `gh repo archive owner/old-project` |
| Rename unclear repos | `gh repo rename better-name` |
| Check for secrets | `git log --all -S "password" --oneline` |
| Add missing descriptions | `gh repo edit --description "Description"` |

> ⚠️ **If you find exposed API keys or passwords**, rotate them immediately and use BFG Repo-Cleaner to remove from history!

---

### Task 6: Before & After

Document **3 improvements** you made and **why**:

```
BEFORE                              AFTER
┌──────────────────────┐            ┌──────────────────────┐
│ 👤 [identicon]        │            │ 👤 [professional]     │
│ [no bio]              │     →      │ DevOps Engineer |    │
│ [random pinned repos] │            │ #90DaysOfDevOps      │
│ [no descriptions]     │            │ [profile README]     │
│                       │            │ [curated pins]       │
│ "Who is this?"        │            │ "Active DevOps       │
│                       │            │  learner!" ✅        │
└──────────────────────┘            └──────────────────────┘
```

> 📄 See [`day-27-notes.md`](day-27-notes.md) for the complete before & after with improvement details!

---

## ✅ Task Completion Checklist

- [x] 🔍 **Profile Audit** — Reviewed profile picture, bio, pins, descriptions, recruiter impression
- [x] 📝 **Profile README** — Created `<username>/<username>` repo with polished README
- [x] 📂 **90DaysOfDevOps** — Well-organized with daily folders and comprehensive READMEs
- [x] 📂 **Shell Scripts** — Planned dedicated repo for Days 16-21 scripts
- [x] 📂 **Python Scripts** — Planned dedicated repo for Days 7-15 projects
- [x] 📂 **DevOps Notes** — Planned central knowledge base repo
- [x] 📌 **Pinned Repos** — Curated 6 best repos representing skills and activity
- [x] 🧹 **Cleanup** — Deleted/archived empty repos, renamed unclear ones, checked for secrets
- [x] 📸 **Before & After** — Documented 3 improvements with rationale
- [x] 📄 **`day-27-notes.md`** — Complete profile makeover documentation

---

## 🧠 Key Takeaways

1. **Your GitHub profile is seen before your resume** — Recruiters and hiring managers check GitHub. A polished profile sets you apart from candidates with empty/messy profiles.

2. **Profile README = Controlled first impression** — Without one, visitors see a blank page. With one, you tell your story in 15 seconds.

3. **Every repo needs 3 things** — A descriptive name, a one-line description, and a README. Repos without these are invisible to recruiters.

4. **Pin strategically** — Your 6 pinned repos are "greatest hits." Choose repos that show activity, documentation, and relevant skills.

5. **Clean up is as important as building** — Empty repos, exposed secrets, and unclear names hurt your image. Regular cleanup is part of being a professional developer.

6. **Treat your GitHub like a portfolio** — Would you show a messy portfolio to a client? Apply the same standard to your GitHub profile.

---

## 💡 Tips for a Good Profile README

- Keep it **short** — 15-20 lines max
- Use headers and bullet points — don't write paragraphs
- Show what you're **doing**, not just what you **know**
- A few well-placed badges are fine, but don't turn it into a Christmas tree
- Look at profiles you admire for inspiration — but make yours authentic

---

## 📤 Submission

1. Add your `day-27-notes.md` (with before/after descriptions) to `2026/day-27/`
2. Share the link to your updated GitHub profile
3. Push to your fork

---

## 🌐 Learn in Public

Share your before & after GitHub profile screenshots on LinkedIn. Tag people who inspired your profile.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

---

<div align="center">

**Happy Learning! 🎉**  
**TrainWithShubham**

</div>
