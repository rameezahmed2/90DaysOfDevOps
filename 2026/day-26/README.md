# 🖥️ Day 26 – GitHub CLI: Manage GitHub from Your Terminal

<div align="center">

![Day](https://img.shields.io/badge/Day-26-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-GitHub_CLI-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Challenge](https://img.shields.io/badge/90DaysOfDevOps-2026-orange?style=for-the-badge)

*"Why click when you can type? The terminal is the DevOps engineer's natural habitat."*

</div>

---

## 🎯 Task Overview

Every time you switch to the browser to create a PR, check an issue, or manage a repo — you lose context. The **GitHub CLI (`gh`)** lets you do all of that **without leaving your terminal**. For DevOps engineers, this is essential — especially when you start automating workflows, scripting PR reviews, and managing repos at scale.

You will:
- 🔑 Install and authenticate the GitHub CLI
- 📂 Create, clone, view, and delete repos from terminal
- 🐛 Manage issues entirely from the command line
- 🔀 Create, review, and merge Pull Requests without a browser
- ⚡ Preview GitHub Actions workflow monitoring
- 🛠️ Explore power tools: API calls, gists, releases, aliases, and search

---

## 📚 Learning Objectives

| # | Objective | Covered |
|:-:|-----------|:-------:|
| 1 | Install GitHub CLI and authenticate with your account | ✅ |
| 2 | Manage repositories from the terminal (create, clone, delete) | ✅ |
| 3 | Create, list, view, and close issues from the terminal | ✅ |
| 4 | Complete the PR lifecycle: create → review → merge (all from terminal) | ✅ |
| 5 | Monitor GitHub Actions workflow runs | ✅ |
| 6 | Use power tools: `gh api`, `gh gist`, `gh release`, `gh alias`, `gh search` | ✅ |

---

## 📦 Expected Output

| # | Deliverable | Description |
|:-:|-------------|-------------|
| 1 | 📄 [`day-26-notes.md`](day-26-notes.md) | Observations, hands-on walkthroughs, and automation scripts |
| 2 | 📄 [`git-commands.md`](../day-22/git-commands.md) | Updated with all `gh` commands — completes the Days 22–26 reference |

---

## 🗺️ GitHub CLI — What You Can Do from Terminal

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                          GITHUB CLI (gh) CAPABILITIES                        │
│                                                                              │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │
│   │  gh repo     │  │  gh issue    │  │  gh pr       │  │  gh run      │       │
│   │  ─────────── │  │  ─────────── │  │  ─────────── │  │  ─────────── │       │
│   │  create      │  │  create      │  │  create      │  │  list        │       │
│   │  clone       │  │  list        │  │  list        │  │  view        │       │
│   │  fork        │  │  view        │  │  checkout    │  │  watch       │       │
│   │  view        │  │  close       │  │  review      │  │  rerun       │       │
│   │  list        │  │  label       │  │  merge       │  │  download    │       │
│   │  delete      │  │  reopen      │  │  diff        │  │              │       │
│   └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘       │
│                                                                              │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │
│   │  gh api      │  │  gh gist     │  │  gh release  │  │  gh search   │       │
│   │  ─────────── │  │  ─────────── │  │  ─────────── │  │  ─────────── │       │
│   │  Raw GitHub  │  │  Create/mgmt │  │  Create tags │  │  repos       │       │
│   │  API calls   │  │  code snips  │  │  Upload bins │  │  issues      │       │
│   │  + jq parse  │  │              │  │  Auto notes  │  │  PRs / code  │       │
│   └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘       │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Challenge Tasks

### Task 1: Install and Authenticate

```bash
# Install (Ubuntu/Debian)
sudo apt update && sudo apt install gh

# Install (macOS)
brew install gh

# Verify
gh --version

# Authenticate
gh auth login
# Follow the interactive prompts:
# → GitHub.com → HTTPS → Yes → Login with browser

# Verify authentication
gh auth status
# ✓ Logged in to github.com as rameez
```

#### Authentication Methods

| Method | Best For | Command |
|--------|----------|---------|
| 🌐 **Browser (OAuth)** | First-time / interactive use | `gh auth login` |
| 🔑 **Personal Access Token** | CI/CD, automation | `gh auth login --with-token` |
| 🔐 **SSH Key** | SSH-preferring users | `gh auth login -p ssh` |
| 🔧 **Environment Variable** | CI/CD pipelines | `export GH_TOKEN=ghp_...` |

> 📄 See [`day-26-notes.md`](day-26-notes.md) for details on token scopes and CI/CD authentication!

---

### Task 2: Working with Repositories

```bash
# Create a new GitHub repo (public, with README)
gh repo create test-gh-cli --public --description "Testing GitHub CLI" --add-readme
# ✓ Created repository rameez/test-gh-cli

# Clone using gh
gh repo clone rameez/test-gh-cli

# View repo details
gh repo view rameez/test-gh-cli

# List all your repos
gh repo list

# Open repo in browser
gh browse

# Delete the test repo
gh repo delete rameez/test-gh-cli --yes
# ✓ Deleted repository
```

#### Key Repo Commands

| Command | What It Does |
|---------|-------------|
| `gh repo create <name> --public` | Create new public repo |
| `gh repo clone <repo>` | Clone a repo |
| `gh repo fork <repo> --clone` | Fork + clone in one step |
| `gh repo view` | View repo details |
| `gh repo list` | List your repositories |
| `gh browse` | Open in browser |

> 📄 See [`day-26-notes.md`](day-26-notes.md) for all repo management options!

---

### Task 3: Issues

```bash
# Create an issue with title, body, and label
gh issue create \
  --title "Fix login page responsiveness" \
  --body "Login page breaks on mobile under 375px width." \
  --label "bug"
# ✓ Created issue #1

# List all open issues
gh issue list

# View a specific issue
gh issue view 1

# Close an issue
gh issue close 1 --comment "Fixed in PR #2"
# ✓ Closed issue #1
```

#### Automation Example

```bash
# Auto-create issues from CI failures
gh issue create \
  --title "Build failed: ${COMMIT_SHA:0:7}" \
  --body "CI build failed. [View logs]($CI_JOB_URL)" \
  --label "ci-failure" --assignee "@me"

# Get issues as JSON for scripting
gh issue list --json number,title,state | jq '.[] | select(.state == "OPEN")'
```

> 📄 See [`day-26-notes.md`](day-26-notes.md) for more automation scripts with `--json` and `jq`!

---

### Task 4: Pull Requests

#### Complete PR Flow — Terminal Only 🚀

```bash
# 1. Create branch + make changes + push
git switch -c feature/add-contributing-guide
echo "# Contributing Guide" > CONTRIBUTING.md
git add CONTRIBUTING.md
git commit -m "Add contributing guide"
git push -u origin feature/add-contributing-guide

# 2. Create PR
gh pr create --title "Add contributing guide" --body "Adds guidelines for contributors" --base main
# ✓ Created pull request #2

# 3. View PR details + checks
gh pr view 2
gh pr checks 2
gh pr diff 2

# 4. Review (for someone else's PR)
gh pr checkout 42              # Test locally
gh pr review 42 --approve      # Approve it

# 5. Merge PR
gh pr merge 2 --squash --delete-branch
# ✓ Merged pull request #2
# ✓ Deleted branch
```

#### Merge Methods

| Method | Flag | Use Case |
|--------|------|----------|
| Merge commit | `--merge` | Preserve full branch history |
| Squash | `--squash` | Clean history, one commit per feature |
| Rebase | `--rebase` | Linear history, preserve individual commits |

```bash
# Auto-merge when CI passes
gh pr merge 2 --auto --squash
# ✓ Will auto-merge when all checks pass
```

> 📄 See [`day-26-notes.md`](day-26-notes.md) for the complete PR review workflow!

---

### Task 5: GitHub Actions & Workflows (Preview)

```bash
# List workflow runs on a public repo
gh run list --repo actions/runner --limit 5

# View a specific run
gh run view <run-id> --repo owner/repo

# Watch a run in real-time
gh run watch <run-id>

# Trigger a workflow manually
gh workflow run deploy.yml --ref main

# List all workflows
gh workflow list
```

#### DevOps Automation with `gh run`

| Use Case | Command |
|----------|---------|
| Deploy after CI passes | `gh run watch --exit-status && gh workflow run deploy.yml` |
| Re-run failed jobs | `gh run rerun <id> --failed` |
| Download build artifacts | `gh run download <id>` |
| Monitor in real-time | `gh run watch <id>` |

> 📄 See [`day-26-notes.md`](day-26-notes.md) for CI/CD pipeline automation scripts!

---

### Task 6: Useful `gh` Tricks

| Tool | Command | What It Does |
|------|---------|-------------|
| **API** | `gh api user` | Raw GitHub API calls + `jq` parsing |
| **Gists** | `gh gist create file.sh` | Create/manage code snippets |
| **Releases** | `gh release create v1.0.0 --generate-notes` | Create releases with auto-generated notes |
| **Aliases** | `gh alias set prs 'pr list --author "@me"'` | Custom shortcuts for frequent commands |
| **Search** | `gh search repos "devops" --sort stars` | Search repos, issues, PRs from terminal |

```bash
# Power move: create custom aliases
gh alias set prs 'pr list --author "@me"'
gh alias set myissues 'issue list --assignee "@me"'
gh alias set last-run 'run list --limit 1'

# Now use them:
gh prs                    # Your open PRs
gh myissues               # Issues assigned to you
gh last-run               # Latest CI run
```

> 📄 See [`day-26-notes.md`](day-26-notes.md) for detailed examples of each power tool!

---

## 📊 Days 22–26 Git & GitHub Journey — Complete!

```
┌──────────────────────────────────────────────────────────────────┐
│                  YOUR GIT & GITHUB JOURNEY                       │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  Day 22  │  Git Basics: init, add, commit, log, diff            │
│  Day 23  │  Branching & GitHub: switch, push, pull, fork        │
│  Day 24  │  Advanced: merge, rebase, stash, cherry-pick         │
│  Day 25  │  Undo: reset (soft/mixed/hard), revert, strategies   │
│  Day 26  │  GitHub CLI: repos, issues, PRs, Actions — terminal  │
│                                                                  │
│  📖 git-commands.md: 40 commands across 17 sections             │
│                                                                  │
│  You can now manage the ENTIRE Git & GitHub workflow             │
│  without ever opening a browser! 🚀                              │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## ✅ Task Completion Checklist

- [x] 🔑 **Installed & Authenticated** — `gh` installed, logged in via browser/token
- [x] 🔐 **Auth Methods** — Understood browser, PAT, SSH, and env variable options
- [x] 📂 **Repo Management** — Create, clone, view, list, browse, delete from terminal
- [x] 🐛 **Issues** — Create, list, view, close with labels and comments
- [x] 🤖 **Issue Automation** — JSON output + `jq` for scripting
- [x] 🔀 **Pull Requests** — Complete lifecycle: create → review → merge from terminal
- [x] 🔍 **PR Reviews** — Checkout, diff, approve/comment/request-changes
- [x] 🎯 **Merge Methods** — Merge commit, squash, rebase understood
- [x] ⚡ **GitHub Actions** — List runs, view status, watch in real-time
- [x] 🛠️ **Power Tools** — API, gists, releases, aliases, search explored
- [x] 📄 **`day-26-notes.md`** — Full walkthrough with automation examples
- [x] 📖 **`git-commands.md`** — Updated to 40 commands across 17 sections (Days 22–26 complete!)

---

## 📔 Ongoing Task

> **Your `git-commands.md` is now a comprehensive Git & GitHub handbook!** With **40 commands across 17 sections** covering everything from `git init` to `gh pr merge`, you've built a personal reference that rivals official documentation. This completes the Git & GitHub section of your DevOps journey (Days 22–26).

---

## 🧠 Key Takeaways

1. **`gh` replaces browser clicks with terminal commands** — Everything you do on GitHub's UI can be done faster from the terminal, especially repetitive tasks.

2. **`--json` flag unlocks automation** — Combined with `jq`, you can pipe GitHub data into scripts for monitoring, reporting, and automated workflows.

3. **PR lifecycle without a browser** — Create branch → commit → push → create PR → review → merge — all from your terminal with `gh pr`.

4. **`gh pr checkout` is a game-changer** — You can test someone's PR locally before approving it, without manually adding remotes or fetching branches.

5. **GitHub Actions from terminal** — `gh run watch` lets you monitor CI/CD in real-time. `gh workflow run` lets you trigger deployments from scripts.

6. **Custom aliases save time** — `gh alias set` creates shortcuts for your most-used commands. Build your own personal `gh` toolkit.

7. **This completes your Git & GitHub toolkit** — Over Days 22–26, you've progressed from `git init` to managing the entire GitHub workflow from your terminal. You're ready for advanced DevOps tooling!

---

## 💡 Hints

- `gh help` and `gh <command> --help` are your best friends
- Most `gh` commands work with `--repo owner/repo` to target a specific repo
- Use `--json` flag with most commands to get machine-readable output (useful for scripting)
- `gh pr create --fill` auto-fills the PR title and body from your commits

---

## 📤 Submission

1. Add your `day-26-notes.md` to `2026/day-26/`
2. Update `git-commands.md` with `gh` commands — this completes your Git & GitHub reference from Days 22–26
3. Push to your fork
4. Add your submission for Community Builder of the week on discord

---

## 🌐 Learn in Public

Share your favorite `gh` commands or a screenshot of creating a PR from the terminal on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

---

<div align="center">

**Happy Learning! 🎉**  
**TrainWithShubham**

</div>
