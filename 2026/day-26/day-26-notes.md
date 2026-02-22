# 📝 Day 26 Notes — GitHub CLI: Manage GitHub from Your Terminal

<div align="center">

![Day](https://img.shields.io/badge/Day-26-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-GitHub_CLI-green?style=for-the-badge)

*Observations, answers, and hands-on learnings from Day 26 tasks*

</div>

---

## 📑 Table of Contents

1. [Task 1: Install and Authenticate](#task-1-install-and-authenticate)
2. [Task 2: Working with Repositories](#task-2-working-with-repositories)
3. [Task 3: Issues](#task-3-issues)
4. [Task 4: Pull Requests](#task-4-pull-requests)
5. [Task 5: GitHub Actions & Workflows (Preview)](#task-5-github-actions--workflows-preview)
6. [Task 6: Useful `gh` Tricks](#task-6-useful-gh-tricks)

---

## Task 1: Install and Authenticate

### Installation

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install gh

# Fedora/RHEL
sudo dnf install gh

# macOS (Homebrew)
brew install gh

# Verify installation
gh --version
# gh version 2.x.x (2026-xx-xx)
```

### Authentication

```bash
# Interactive login (recommended for first time)
gh auth login
# ? What account do you want to log into?  GitHub.com
# ? What is your preferred protocol for Git operations?  HTTPS
# ? Authenticate Git with your GitHub credentials?  Yes
# ? How would you like to authenticate GitHub CLI?  Login with a web browser
# ! First copy your one-time code: XXXX-XXXX
# Press Enter to open github.com in your browser...
# ✓ Authentication complete.
# ✓ Logged in as rameez

# Verify authentication
gh auth status
# github.com
#   ✓ Logged in to github.com as rameez
#   ✓ Git operations for github.com configured to use https protocol.
#   ✓ Token: gho_************************************

# Check which account is active
gh api user --jq '.login'
# Output: rameez
```

### Question: What authentication methods does `gh` support?

The GitHub CLI supports **four authentication methods**:

| Method | Command | Best For |
|--------|---------|----------|
| **Web Browser** (OAuth) | `gh auth login` → "Login with a web browser" | Interactive use, first-time setup |
| **Personal Access Token (PAT)** | `gh auth login --with-token < token.txt` | Automation, scripts, CI/CD pipelines |
| **SSH Key** | `gh auth login` → Protocol: SSH | Users who prefer SSH over HTTPS |
| **GitHub App Token** | Set `GH_TOKEN` environment variable | Enterprise automation, GitHub Apps |

```bash
# Method 1: Interactive browser login (default)
gh auth login

# Method 2: Token-based (for automation/CI)
echo "ghp_your_personal_access_token" | gh auth login --with-token

# Method 3: Using environment variable (CI/CD)
export GH_TOKEN="ghp_your_personal_access_token"
gh api user   # Uses the token from env variable

# Method 4: SSH protocol
gh auth login -p ssh
```

#### Token Scopes

```bash
# Check what scopes your token has
gh auth status

# Refresh token with additional scopes
gh auth refresh -s repo,workflow,admin:org
```

> 💡 **For DevOps/CI pipelines**, use `GH_TOKEN` environment variable or `--with-token`. Never use interactive browser login in automation scripts.

---

## Task 2: Working with Repositories

### Hands-On Walkthrough

```bash
# 1. Create a new GitHub repo from the terminal
gh repo create test-gh-cli --public --description "Testing GitHub CLI" --add-readme
# ✓ Created repository rameez/test-gh-cli on GitHub
# ✓ Added README.md

# 2. Clone a repo using gh
gh repo clone rameez/test-gh-cli
# Cloning into 'test-gh-cli'...
# Same effect as: git clone https://github.com/rameez/test-gh-cli.git

# 3. View details of a repo
gh repo view rameez/test-gh-cli
# rameez/test-gh-cli
# Testing GitHub CLI
#
# README
# ...

# With web view:
gh repo view rameez/test-gh-cli --web
# Opens in browser

# 4. List all your repositories
gh repo list
# rameez/90DaysOfDevOps           fork    public  2026-02-22
# rameez/devops-git-practice      source  public  2026-02-22
# rameez/test-gh-cli              source  public  2026-02-22

# With more details:
gh repo list --limit 10 --json name,isPrivate,updatedAt

# 5. Open a repo in browser from terminal
gh browse
# Opens current repo in default browser

gh browse --repo rameez/test-gh-cli
# Opens specific repo

# 6. Delete the test repo (careful!)
gh repo delete rameez/test-gh-cli --yes
# ✓ Deleted repository rameez/test-gh-cli
```

### Key `gh repo` Commands at a Glance

| Command | What It Does |
|---------|-------------|
| `gh repo create <name>` | Create a new repo on GitHub |
| `gh repo clone <owner/repo>` | Clone a repo to local machine |
| `gh repo fork <owner/repo>` | Fork a repo to your account |
| `gh repo view <owner/repo>` | View repo details |
| `gh repo list` | List your repositories |
| `gh repo delete <owner/repo>` | Delete a repository ⚠️ |
| `gh repo edit` | Edit repo settings (description, visibility, etc.) |
| `gh repo rename <new-name>` | Rename a repository |
| `gh browse` | Open current repo in browser |

---

## Task 3: Issues

### Hands-On Walkthrough

```bash
# 1. Create an issue with title, body, and label
gh issue create \
  --title "Fix login page responsiveness" \
  --body "The login page breaks on mobile devices under 375px width. Need to add responsive CSS breakpoints." \
  --label "bug" \
  --repo rameez/devops-git-practice

# Interactive mode (prompts for details):
gh issue create
# ? Title: Fix login page responsiveness
# ? Body: <opens editor>
# ? Labels: bug
# Creating issue in rameez/devops-git-practice
# https://github.com/rameez/devops-git-practice/issues/1

# 2. List all open issues
gh issue list
# #  TITLE                            LABELS  UPDATED
# 1  Fix login page responsiveness    bug     about 1 minute ago

gh issue list --state all                  # Include closed issues
gh issue list --label "bug"                # Filter by label
gh issue list --assignee "@me"             # Issues assigned to you

# 3. View a specific issue
gh issue view 1
# Fix login page responsiveness  #1
# Open • rameez opened about 1 minute ago • 0 comments
#
# Labels: bug
#
# The login page breaks on mobile devices...

gh issue view 1 --web              # Open in browser

# 4. Close an issue
gh issue close 1
# ✓ Closed issue #1 (Fix login page responsiveness)

# Reopen if needed:
gh issue reopen 1

# Close with a comment:
gh issue close 1 --comment "Fixed in PR #2"
```

### Question: How could you use `gh issue` in a script or automation?

`gh issue` combined with `--json` output makes it perfect for automation:

```bash
# 1. Auto-create issues from a bug tracker
#!/bin/bash
BUGS=("Fix timeout error" "Update dependencies" "Add logging")
for bug in "${BUGS[@]}"; do
    gh issue create --title "$bug" --label "auto-generated" --repo owner/repo
done

# 2. Get issue data as JSON for processing
gh issue list --json number,title,labels,state --limit 100 \
  | jq '.[] | select(.state == "OPEN")'

# 3. Auto-close stale issues
gh issue list --state open --json number,updatedAt \
  | jq -r '.[] | select(.updatedAt < "2026-01-01") | .number' \
  | xargs -I {} gh issue close {} --comment "Closing stale issue"

# 4. Generate a daily issues report
echo "## Open Issues Report - $(date)"
gh issue list --json number,title,labels --jq '.[] | "- #\(.number): \(.title)"'

# 5. Assign issues from a CI pipeline
gh issue create --title "Build failed: $CI_COMMIT_SHA" \
  --body "CI build failed. [View logs]($CI_JOB_URL)" \
  --label "ci-failure" --assignee "@me"
```

> 💡 **DevOps use case:** Automatically create issues when CI/CD pipelines fail, link issues to commits/PRs, and generate reports with `--json` + `jq`.

---

## Task 4: Pull Requests

### Hands-On Walkthrough: Complete PR Flow from Terminal

```bash
# 1. Create a branch, make changes, push, and create PR — ALL from terminal
git switch -c feature/add-contributing-guide
echo "# Contributing Guide" > CONTRIBUTING.md
echo "1. Fork the repo" >> CONTRIBUTING.md
echo "2. Create a feature branch" >> CONTRIBUTING.md
echo "3. Submit a PR" >> CONTRIBUTING.md
git add CONTRIBUTING.md
git commit -m "Add contributing guide"
git push -u origin feature/add-contributing-guide

# Create the PR
gh pr create \
  --title "Add contributing guide" \
  --body "This PR adds a CONTRIBUTING.md file with guidelines for new contributors." \
  --base main \
  --label "documentation"

# Or auto-fill from commit message:
gh pr create --fill
# ✓ Created pull request #2

# 2. List all open PRs
gh pr list
# #  TITLE                      BRANCH                           UPDATED
# 2  Add contributing guide     feature/add-contributing-guide   about 1 minute ago

gh pr list --state all               # Include merged/closed
gh pr list --author "@me"            # Your PRs only
gh pr list --label "bug"             # Filter by label

# 3. View PR details
gh pr view 2
# Add contributing guide  #2
# Open • rameez wants to merge 1 commit into main from feature/add-contributing-guide
# +4 -0 • No checks
#
# This PR adds a CONTRIBUTING.md file...

# View with full diff:
gh pr diff 2

# Check PR status (checks, reviews, merge status):
gh pr checks 2
# ✓ All checks have passed

gh pr status
# Current branch
#   #2  Add contributing guide [feature/add-contributing-guide]
#   - Checks passing

# 4. Merge the PR
gh pr merge 2
# ? What merge method would you like to use?
#   > Create a merge commit
#     Rebase and merge
#     Squash and merge
# ? Delete the branch? Yes
# ✓ Merged pull request #2
# ✓ Deleted branch feature/add-contributing-guide
```

### Question 1: What merge methods does `gh pr merge` support?

`gh pr merge` supports the **same three merge strategies** as the GitHub UI:

| Method | Flag | What It Does | History |
|--------|------|-------------|---------|
| **Merge commit** | `--merge` | Creates a merge commit with two parents | Non-linear (shows branch) |
| **Squash and merge** | `--squash` | Combines all PR commits into one | Linear, clean |
| **Rebase and merge** | `--rebase` | Replays commits on top of base | Linear, preserves individual commits |

```bash
# Merge with explicit method
gh pr merge 2 --merge                 # Merge commit
gh pr merge 2 --squash                # Squash into one commit
gh pr merge 2 --rebase                # Rebase onto base

# Auto-delete branch after merge
gh pr merge 2 --squash --delete-branch

# Auto-merge when checks pass (merge later)
gh pr merge 2 --auto --squash
# ✓ Pull request #2 will be automatically merged when all requirements are met
```

### Question 2: How would you review someone else's PR using `gh`?

```bash
# View the PR
gh pr view 42 --repo owner/repo

# Check out the PR branch locally
gh pr checkout 42
# Creates a local branch and switches to it
# Now you can test the code locally!

# View the diff
gh pr diff 42

# Leave a review comment
gh pr review 42 --comment --body "Looks good! Just one suggestion on line 25."

# Approve the PR
gh pr review 42 --approve --body "LGTM! Ship it! 🚀"

# Request changes
gh pr review 42 --request-changes --body "Please fix the failing tests before merging."

# Add a comment (not a review)
gh pr comment 42 --body "Have you considered adding unit tests for this?"
```

### Complete PR Workflow — Terminal Only

```bash
# 1. Fetch and checkout someone's PR
gh pr checkout 42

# 2. Test the code locally
npm test                              # Run tests
npm start                             # Run the app

# 3. Leave your review
gh pr review 42 --approve --body "Tested locally, all good! ✅"

# 4. Merge (if you have permission)
gh pr merge 42 --squash --delete-branch

# 5. Switch back to main
git switch main
git pull
```

---

## Task 5: GitHub Actions & Workflows (Preview)

### Hands-On Walkthrough

```bash
# 1. List workflow runs on any public repo with GitHub Actions
gh run list --repo kubernetes/kubernetes --limit 5
# STATUS  TITLE                          WORKFLOW          BRANCH  EVENT  ID          ELAPSED
# ✓       Merge pull request #123456     CI                main    push   12345678    5m30s
# ✓       Update dependencies            CodeQL Analysis   main    push   12345677    3m12s
# X       Fix flaky test                 Unit Tests        pr/789  pr     12345676    8m45s

gh run list --repo actions/runner --limit 5

# 2. View status of a specific workflow run
gh run view 12345678 --repo kubernetes/kubernetes
# ✓ main Merge pull request #123456 · 12345678
# Triggered via push about 2 hours ago
#
# JOBS
# ✓ build (3m12s)
# ✓ test-linux (5m30s)
# ✓ test-macos (4m15s)
# ✓ lint (1m02s)

# View logs of a specific job
gh run view 12345678 --log --repo kubernetes/kubernetes

# Watch a run in real-time
gh run watch 12345678 --repo owner/repo

# List all workflows in a repo
gh workflow list --repo owner/repo

# View a specific workflow
gh workflow view "CI" --repo owner/repo
```

### Question: How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?

`gh run` and `gh workflow` are powerful for **monitoring, triggering, and automating CI/CD**:

```bash
# 1. Trigger a workflow manually (workflow_dispatch)
gh workflow run deploy.yml --ref main
# Useful for: manual deployments, nightly builds

# 2. Wait for a workflow to complete (blocking)
gh run watch --exit-status
# Returns non-zero exit code if the run fails
# Useful in scripts that depend on CI passing

# 3. Check if CI passed before deploying
RUN_ID=$(gh run list --workflow "CI" --limit 1 --json databaseId --jq '.[0].databaseId')
gh run view $RUN_ID --exit-status
if [ $? -eq 0 ]; then
    echo "CI passed! Deploying..."
    gh workflow run deploy.yml
else
    echo "CI failed! Aborting deployment."
    exit 1
fi

# 4. Download build artifacts
gh run download $RUN_ID --name "build-output"

# 5. Re-run failed jobs
gh run rerun $RUN_ID --failed

# 6. Monitor deployments in a script
while true; do
    STATUS=$(gh run view $RUN_ID --json status --jq '.status')
    echo "Current status: $STATUS"
    [ "$STATUS" = "completed" ] && break
    sleep 30
done

# 7. Create a deployment dashboard
echo "## CI/CD Dashboard - $(date)"
gh run list --limit 10 --json status,name,conclusion,createdAt \
  --jq '.[] | "\(.status) | \(.name) | \(.conclusion // "running") | \(.createdAt)"'
```

#### DevOps Automation Scenarios

| Scenario | Commands Used |
|----------|-------------|
| **Deploy after CI passes** | `gh run watch --exit-status` → `gh workflow run deploy.yml` |
| **Nightly builds** | `gh workflow run nightly.yml` (triggered by cron or script) |
| **Rollback on failure** | `gh run view --exit-status` → `gh workflow run rollback.yml` |
| **Download release artifacts** | `gh run download` → deploy to server |
| **Re-run flaky tests** | `gh run rerun --failed` |
| **Slack/Teams notifications** | `gh run view --json` → parse → send notification |

> 💡 **In a real DevOps pipeline,** `gh` commands replace manual GitHub clicks. Combined with shell scripts, they enable fully automated PR creation, CI monitoring, and deployment workflows.

---

## Task 6: Useful `gh` Tricks

### 1. `gh api` — Raw GitHub API Calls

```bash
# Get your profile info
gh api user
# Returns JSON with your GitHub profile

# Get repo info
gh api repos/rameez/devops-git-practice

# List repo contributors
gh api repos/owner/repo/contributors --jq '.[].login'

# Get number of stars
gh api repos/torvalds/linux --jq '.stargazers_count'
# Output: 185000

# Create a label via API
gh api repos/owner/repo/labels -f name="priority:high" -f color="FF0000"

# Paginate through results
gh api repos/owner/repo/issues --paginate --jq '.[].title'
```

### 2. `gh gist` — Manage GitHub Gists

```bash
# Create a gist from a file
gh gist create script.sh --desc "Useful DevOps script" --public
# ✓ Created gist https://gist.github.com/rameez/abc123

# Create from stdin
echo "Hello from the terminal!" | gh gist create --filename hello.txt

# List your gists
gh gist list

# View a gist
gh gist view abc123

# Edit a gist
gh gist edit abc123

# Delete a gist
gh gist delete abc123
```

### 3. `gh release` — Create and Manage Releases

```bash
# Create a release with auto-generated notes
gh release create v1.0.0 --title "Version 1.0.0" --generate-notes
# ✓ Created release v1.0.0

# Create with custom notes
gh release create v1.0.0 --title "Version 1.0.0" --notes "First stable release!"

# Upload assets to a release
gh release create v1.0.0 ./build/app.zip ./build/checksums.txt

# List releases
gh release list

# Download release assets
gh release download v1.0.0 --pattern "*.zip"

# Create a draft release
gh release create v2.0.0-beta --draft --prerelease --title "v2.0.0 Beta"

# Delete a release
gh release delete v1.0.0 --yes
```

### 4. `gh alias` — Custom Shortcuts

```bash
# Create aliases for commands you use often
gh alias set prs 'pr list --author "@me"'
gh prs
# Lists all YOUR open PRs

gh alias set co 'pr checkout'
gh co 42
# Checks out PR #42

gh alias set myissues 'issue list --assignee "@me" --state open'
gh myissues
# Lists all open issues assigned to you

gh alias set last-run 'run list --limit 1'
gh last-run
# Shows the latest CI run

# List all aliases
gh alias list

# Delete an alias
gh alias delete prs
```

### 5. `gh search` — Search GitHub from Terminal

```bash
# Search for repos
gh search repos "kubernetes devops" --sort stars --limit 5
# Lists top 5 repos matching the query

# Search for repos by language
gh search repos --language python --stars ">1000" --limit 10

# Search issues across GitHub
gh search issues "fix memory leak" --repo kubernetes/kubernetes

# Search PRs
gh search prs "add feature" --state open --repo owner/repo

# Search code
gh search code "func main" --language go --repo owner/repo
```

---

## 🧠 Summary

```
┌──────────────────────────────────────────────────────────────────┐
│                    KEY CONCEPTS — DAY 26                          │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  SETUP                                                           │
│  • gh auth login → authenticate (browser, token, SSH)            │
│  • GH_TOKEN env var for CI/CD automation                         │
│                                                                  │
│  REPOS                                                           │
│  • gh repo create/clone/view/list/delete                         │
│  • gh browse → open in browser                                   │
│                                                                  │
│  ISSUES                                                          │
│  • gh issue create/list/view/close                               │
│  • --json + jq for automation scripts                            │
│                                                                  │
│  PULL REQUESTS                                                   │
│  • gh pr create/list/view/merge/checkout/review                  │
│  • Merge methods: --merge, --squash, --rebase                    │
│  • gh pr checkout → test PRs locally                             │
│                                                                  │
│  ACTIONS (Preview)                                               │
│  • gh run list/view/watch/rerun                                  │
│  • gh workflow run/list/view                                     │
│                                                                  │
│  POWER TOOLS                                                     │
│  • gh api     → raw GitHub API calls                             │
│  • gh gist    → create/manage gists                              │
│  • gh release → create/manage releases                           │
│  • gh alias   → custom shortcuts                                 │
│  • gh search  → search repos/issues/PRs/code                    │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Most-Used `gh` Commands — Quick Reference

| Category | Command | What It Does |
|----------|---------|-------------|
| **Auth** | `gh auth login` | Authenticate with GitHub |
| **Auth** | `gh auth status` | Check login status |
| **Repo** | `gh repo create <name>` | Create a new repo |
| **Repo** | `gh repo clone <repo>` | Clone a repo |
| **Repo** | `gh browse` | Open repo in browser |
| **Issue** | `gh issue create` | Create an issue |
| **Issue** | `gh issue list` | List open issues |
| **Issue** | `gh issue close <#>` | Close an issue |
| **PR** | `gh pr create` | Create a pull request |
| **PR** | `gh pr list` | List open PRs |
| **PR** | `gh pr checkout <#>` | Checkout a PR locally |
| **PR** | `gh pr merge <#>` | Merge a PR |
| **PR** | `gh pr review <#>` | Review a PR |
| **Run** | `gh run list` | List workflow runs |
| **Run** | `gh run view <id>` | View run details |
| **Run** | `gh run watch` | Watch a run in real-time |
| **API** | `gh api <endpoint>` | Make raw API calls |
| **Misc** | `gh gist create` | Create a gist |
| **Misc** | `gh release create` | Create a release |
| **Misc** | `gh alias set` | Create custom shortcuts |

---

<div align="center">

**Day 26 Complete ✅ — GitHub CLI mastered!** 🖥️

*"Why click when you can type? The terminal is the DevOps engineer's natural habitat."*

**#90DaysOfDevOps #TrainWithShubham**

</div>
