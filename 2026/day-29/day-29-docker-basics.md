# 🐳 Day 29 — Docker Basics: Your First Containers

<div align="center">

![Day](https://img.shields.io/badge/Day-29-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Docker_Basics-green?style=for-the-badge)

*Understand containers, install Docker, and run your first real applications in isolation*

</div>

---

## 📑 Table of Contents

1. [Task 1: What is Docker?](#task-1-what-is-docker)
2. [Task 2: Install Docker](#task-2-install-docker)
3. [Task 3: Run Real Containers](#task-3-run-real-containers)
4. [Task 4: Explore Docker Commands](#task-4-explore-docker-commands)
5. [Docker Commands Cheat Sheet](#-docker-commands-cheat-sheet)

---

## Task 1: What is Docker?

### The Problem Docker Solves — "It Works on My Machine!"

Imagine you and your friend both work on a web application. You develop it on your laptop running Ubuntu 22.04 with Python 3.11 and a specific version of PostgreSQL. Everything works perfectly.

You send the code to your friend. They run it on their macOS laptop with Python 3.9 and a different PostgreSQL version. **It breaks.**

Your friend says: *"It doesn't work!"*
You say: *"But it works on my machine!"*

This is the **#1 problem in software development**. Docker was created to solve exactly this.

```
THE PROBLEM:

  Developer A                Developer B               Production Server
  ┌──────────┐              ┌──────────┐              ┌──────────┐
  │ Ubuntu   │              │ macOS    │              │ Amazon   │
  │ Python 3.11│            │ Python 3.9│             │ Linux    │
  │ PostgreSQL│             │ MySQL    │              │ ???      │
  │ 14.2     │              │ 8.0      │              │          │
  └──────────┘              └──────────┘              └──────────┘
       ✅ Works                  ❌ Broken                ❌ Who knows?

THE SOLUTION (Docker):

  Developer A                Developer B               Production Server
  ┌──────────┐              ┌──────────┐              ┌──────────┐
  │ 🐳 Docker│              │ 🐳 Docker│              │ 🐳 Docker│
  │ Container│              │ Container│              │ Container│
  │ ┌──────┐ │              │ ┌──────┐ │              │ ┌──────┐ │
  │ │Ubuntu│ │              │ │Ubuntu│ │              │ │Ubuntu│ │
  │ │Py3.11│ │              │ │Py3.11│ │              │ │Py3.11│ │
  │ │PG14.2│ │              │ │PG14.2│ │              │ │PG14.2│ │
  │ └──────┘ │              │ └──────┘ │              │ └──────┘ │
  └──────────┘              └──────────┘              └──────────┘
       ✅ Works                  ✅ Works                  ✅ Works!

  SAME container, SAME environment, EVERYWHERE.
```

---

### What is a Container?

A **container** is a lightweight, standalone package that contains **everything needed to run an application** — the code, runtime, libraries, system tools, and settings. It runs in isolation from other containers and the host system.

Think of it like a **shipping container** on a cargo ship:

```
REAL-WORLD ANALOGY:

  Before shipping containers (1950s):
  🍎🥛📦🧊🪵🧱  ← Every item loaded individually
  Different sizes, shapes, handling requirements
  Slow, error-prone, expensive

  After shipping containers (standardized):
  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐
  │ 🍎  │ │ 🥛  │ │ 📦  │ │ 🧊  │  ← Everything in standard boxes
  └─────┘ └─────┘ └─────┘ └─────┘
  Same size, stackable, works on any ship/truck/train
  Fast, reliable, cheap

  Docker containers are the same idea for SOFTWARE:
  ┌─────────┐ ┌─────────┐ ┌─────────┐
  │ Web App │ │ Database│ │ Cache   │  ← Each app in its own container
  │ + Deps  │ │ + Deps  │ │ + Deps  │
  └─────────┘ └─────────┘ └─────────┘
  Runs the same on any machine with Docker installed
```

**In one sentence:** A container is a portable box that holds your application and everything it needs, so it runs the same way everywhere.

---

### Containers vs Virtual Machines — What's the Real Difference?

Both containers and VMs solve the "works on my machine" problem, but they do it very differently:

```
VIRTUAL MACHINE (Heavy)                   CONTAINER (Lightweight)

┌─────────────────────────┐              ┌─────────────────────────┐
│         App A           │              │    App A    │   App B   │
├─────────────────────────┤              ├────────────┤────────────┤
│    Libraries/Deps       │              │  Libs/Deps │ Libs/Deps │
├─────────────────────────┤              ├────────────┴────────────┤
│     Guest OS            │              │     Container Runtime   │
│  (Ubuntu, Windows, etc) │              │        (Docker)         │
│     Full OS! ~2-10 GB   │              │        ~100 MB          │
├─────────────────────────┤              ├─────────────────────────┤
│      Hypervisor         │              │        Host OS          │
│  (VMware, VirtualBox)   │              │   (Linux, macOS, Win)   │
├─────────────────────────┤              ├─────────────────────────┤
│      Hardware           │              │       Hardware          │
└─────────────────────────┘              └─────────────────────────┘

Each VM has its OWN full OS                Containers SHARE the host OS kernel
Heavy (GBs), slow to start                Light (MBs), start in seconds
```

#### Comparison Table

| Feature | Virtual Machine | Container |
|---------|:--------------:|:---------:|
| **Size** | GBs (includes full OS) | MBs (only app + dependencies) |
| **Startup time** | Minutes | Seconds (often < 1 second) |
| **Resource usage** | Heavy (each VM runs a full OS) | Light (shares host OS kernel) |
| **Isolation** | 🔒 Strong (hardware-level) | 🔓 Good (process-level) |
| **Portability** | Limited (tied to hypervisor) | ✅ Run anywhere Docker runs |
| **Density** | 5-20 VMs per server | 100s-1000s of containers per server |
| **Use case** | Running different OSes, strong isolation | Packaging and deploying applications |
| **Example** | Running Windows on a Mac | Running an Nginx web server |

#### When to Use Which?

| Scenario | Use VM ✅ | Use Container ✅ |
|----------|:-------:|:---------------:|
| Need to run Windows on Linux | ✅ | ❌ |
| Deploy a web application | ❌ | ✅ |
| Complete OS isolation (security) | ✅ | ❌ |
| Microservices architecture | ❌ | ✅ |
| Running 100+ instances | ❌ | ✅ |
| Testing on different OS versions | ✅ | ❌ |
| CI/CD pipelines | ❌ | ✅ |

> 💡 **In modern DevOps, containers are the default.** VMs are used when you need full OS isolation (e.g., running Windows on Linux, security-sensitive workloads, or legacy applications).

---

### What is the Docker Architecture?

Docker has 5 key components that work together:

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                          DOCKER ARCHITECTURE                                 │
│                                                                              │
│                                                                              │
│  YOU (User)                                                                  │
│    │                                                                         │
│    │  docker run nginx                                                       │
│    │  docker build .                                                         │
│    │  docker pull ubuntu                                                     │
│    ▼                                                                         │
│  ┌────────────────┐         ┌────────────────────────────────────────────┐   │
│  │  Docker Client │────────▶│          Docker Daemon (dockerd)          │   │
│  │  (docker CLI)  │         │                                            │   │
│  │                │         │  The "brain" that does the actual work:    │   │
│  │  Receives your │         │  • Builds images                           │   │
│  │  commands and  │         │  • Pulls images from registries            │   │
│  │  sends them to │         │  • Creates and runs containers             │   │
│  │  the daemon    │         │  • Manages networks and volumes            │   │
│  └────────────────┘         │                                            │   │
│                              │  ┌──────────┐ ┌──────────┐ ┌──────────┐  │   │
│                              │  │Container │ │Container │ │Container │  │   │
│                              │  │  Nginx   │ │  MySQL   │ │  Redis   │  │   │
│                              │  └──────────┘ └──────────┘ └──────────┘  │   │
│                              └──────────────────┬───────────────────────┘   │
│                                                  │                           │
│                                          Pull / Push Images                  │
│                                                  │                           │
│                              ┌───────────────────▼───────────────────────┐   │
│                              │        Docker Registry (Docker Hub)       │   │
│                              │                                           │   │
│                              │  A "library" of pre-built images:        │   │
│                              │  nginx, ubuntu, python, node, postgres   │   │
│                              │  mysql, redis, mongo, alpine, ...        │   │
│                              │                                           │   │
│                              │  hub.docker.com                          │   │
│                              └───────────────────────────────────────────┘   │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

#### The 5 Key Components Explained Simply

| Component | What It Is | Analogy |
|-----------|-----------|---------|
| **Docker Client** | The command-line tool you type commands into (`docker run`, `docker build`) | The steering wheel — you tell Docker what to do |
| **Docker Daemon** | The background service that actually does the work (building, running, managing) | The engine — it does the heavy lifting |
| **Docker Image** | A read-only template/blueprint for creating containers (like a recipe) | A cookie cutter — you use it to make cookies (containers) |
| **Docker Container** | A running instance of an image — the actual application | The cookie — made from the cutter, each one is independent |
| **Docker Registry** | A library of pre-built images (Docker Hub is the most popular) | An app store — download ready-made images |

#### Image vs Container — The Key Difference

```
IMAGE (Blueprint)                  CONTAINER (Running Instance)
┌─────────────────┐               ┌─────────────────┐
│                 │               │                 │
│  nginx:latest   │──── Run ────▶│   Container 1   │  (Port 8080)
│                 │               │   Running Nginx │
│  Read-only      │               └─────────────────┘
│  Can't change   │
│  Stored on disk │────  Run ────▶┌─────────────────┐
│                 │               │   Container 2   │  (Port 8081)
│  Like a class   │               │   Running Nginx │
│  in programming │               └─────────────────┘
│                 │
└─────────────────┘────  Run ────▶┌─────────────────┐
                                  │   Container 3   │  (Port 8082)
  ONE image can create            │   Running Nginx │
  MANY containers                 └─────────────────┘
```

- **Image** = Blueprint / Recipe / Class → You never change it
- **Container** = Running instance / Cookie / Object → You create, start, stop, delete them

---

### How Does Docker Actually Work? (The Simple Version)

When you type `docker run nginx`, here's what happens step by step:

```
Step 1: You type the command
  $ docker run nginx

Step 2: Docker Client sends the command to Docker Daemon

Step 3: Docker Daemon checks — "Do I have the nginx image locally?"
  └── NO?  → Download (pull) it from Docker Hub
  └── YES? → Use the local copy

Step 4: Docker Daemon creates a new container from the image
  └── Assigns it a unique ID
  └── Creates an isolated filesystem
  └── Sets up networking

Step 5: Docker Daemon starts the container
  └── The nginx process starts running inside the container
  └── The container is now live and serving web pages!

Step 6: You can interact with it
  └── docker ps         → See it running
  └── docker logs nginx → See its output
  └── docker stop nginx → Stop it
  └── docker rm nginx   → Delete it
```

---

## Task 2: Install Docker

### Installation on Ubuntu/Debian

```bash
# 1. Update package index
sudo apt update

# 2. Install prerequisites
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# 3. Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 4. Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Install Docker Engine
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# 6. Add your user to the docker group (so you don't need sudo every time)
sudo usermod -aG docker $USER

# 7. Log out and log back in for the group change to take effect
# Or run: newgrp docker

# 8. Verify installation
docker --version
# Docker version 27.x.x, build abc1234

docker info
# Shows detailed information about your Docker installation
```

### Verify with Hello World

```bash
docker run hello-world

# Output:
# Hello from Docker!
# This message shows that your installation appears to be working correctly.
#
# To generate this message, Docker took the following steps:
#  1. The Docker client contacted the Docker daemon.
#  2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
#  3. The Docker daemon created a new container from that image which runs the
#     executable that produces the output you are currently reading.
#  4. The Docker daemon streamed that output to the Docker client, which sent it
#     to your terminal.
```

### What Just Happened? (Breaking Down the Output)

```
When you ran "docker run hello-world":

  ┌──────────┐     "Run hello-world"    ┌──────────────┐
  │  Docker   │ ──────────────────────▶  │    Docker     │
  │  Client   │                          │    Daemon     │
  └──────────┘                           └──────┬───────┘
                                                 │
                              "Do I have it locally? NO"
                                                 │
                                        ┌────────▼────────┐
                                        │   Docker Hub     │
                                        │  (Registry)      │
                                        │                  │
                                        │  📦 hello-world  │
                                        └────────┬────────┘
                                                 │
                                       Download (pull) image
                                                 │
                                        ┌────────▼────────┐
                                        │    Container     │
                                        │  Runs, prints    │
                                        │  "Hello from     │
                                        │   Docker!"       │
                                        │  Then exits      │
                                        └─────────────────┘
```

---

## Task 3: Run Real Containers

### 3.1 Run an Nginx Web Server

```bash
# Run Nginx and map port 80 inside the container to port 8080 on your host
docker run -d -p 8080:80 --name my-nginx nginx

# Breaking down the flags:
# -d           → Run in detached mode (background)
# -p 8080:80   → Map host port 8080 to container port 80
# --name       → Give the container a friendly name
# nginx        → The image to use (from Docker Hub)
```

Now open your browser and go to `http://localhost:8080` — you'll see the Nginx welcome page!

```
PORT MAPPING EXPLAINED:

  Your Computer (Host)             Docker Container
  ┌──────────────────┐            ┌──────────────────┐
  │                  │            │                  │
  │  Browser         │            │   Nginx Server   │
  │  http://         │            │   Listening on   │
  │  localhost:8080  │───────────▶│   port 80        │
  │                  │  mapping   │                  │
  │  Port 8080       │  ────────▶ │  Port 80         │
  │                  │            │                  │
  └──────────────────┘            └──────────────────┘

  -p 8080:80  means:
  "When someone connects to MY port 8080,
   forward it to the CONTAINER's port 80"
```

```bash
# Verify it's running
docker ps
# CONTAINER ID  IMAGE  COMMAND                 STATUS       PORTS                  NAMES
# a1b2c3d4e5f6  nginx  "/docker-entrypoint.…"  Up 2 mins    0.0.0.0:8080->80/tcp   my-nginx

# Check the logs
docker logs my-nginx
# Shows Nginx access and error logs

# Stop the container
docker stop my-nginx

# Start it again
docker start my-nginx
```

---

### 3.2 Run an Ubuntu Container (Interactive Mode)

```bash
# Run Ubuntu in interactive mode
docker run -it --name my-ubuntu ubuntu bash

# Breaking down the flags:
# -i  → Interactive (keep stdin open)
# -t  → Allocate a pseudo-terminal (gives you a command prompt)
# ubuntu → The image to use
# bash → The command to run inside the container
```

Now you're **inside the container** — it's like a mini Linux machine!

```bash
# You're now inside the container (notice the prompt changed)
root@a1b2c3d4e5f6:/# 

# Explore! It's a real Ubuntu system:
cat /etc/os-release
# Ubuntu 24.04 LTS

ls /
# bin  boot  dev  etc  home  lib  ...

whoami
# root

apt update && apt install -y curl
# You can install packages inside the container!

# Exit the container
exit
# You're back on your host machine
```

```
INTERACTIVE MODE EXPLAINED:

  Your Terminal                    Docker Container
  ┌──────────────────┐            ┌──────────────────┐
  │                  │            │                  │
  │  $ docker run    │            │  root@abc123:/#  │
  │    -it ubuntu    │            │                  │
  │    bash          │───────────▶│  You're inside   │
  │                  │  keyboard  │  the container!  │
  │  You type here   │───────────▶│  Commands run    │
  │                  │            │  in here         │
  │  Output shows    │◀───────────│  Output comes    │
  │  here            │            │  from here       │
  └──────────────────┘            └──────────────────┘

  It's like SSH-ing into a remote server,
  except the "server" is a container on your machine!
```

---

### 3.3 Container Management Commands

```bash
# List all RUNNING containers
docker ps
# CONTAINER ID  IMAGE  COMMAND  STATUS       PORTS                  NAMES
# a1b2c3d4e5f6  nginx  "..."    Up 5 mins    0.0.0.0:8080->80/tcp   my-nginx

# List ALL containers (including stopped ones)
docker ps -a
# CONTAINER ID  IMAGE       STATUS                     NAMES
# a1b2c3d4e5f6  nginx       Up 5 mins                  my-nginx
# b2c3d4e5f6a7  ubuntu      Exited (0) 2 minutes ago   my-ubuntu
# c3d4e5f6a7b8  hello-world Exited (0) 10 minutes ago  silly_name

# Stop a running container
docker stop my-nginx
# my-nginx

# Start a stopped container
docker start my-nginx

# Remove a stopped container
docker rm my-ubuntu
# my-ubuntu

# Force remove a running container (stop + remove)
docker rm -f my-nginx

# Remove ALL stopped containers at once
docker container prune
# WARNING! This will remove all stopped containers.
# Are you sure? [y/N] y
```

```
CONTAINER LIFECYCLE:

  docker run     docker stop     docker start     docker rm
  ┌──────────▶ ┌──────────▶ ┌──────────────▶ ┌──────────▶
  │            │            │                │
  │  CREATED   │  RUNNING   │   STOPPED      │  REMOVED
  │            │            │   (still on    │  (gone
  │            │            │    disk)       │   forever)
  │            │            │                │
  └────────────┘            └────────────────┘

  A stopped container STILL EXISTS on disk.
  You need "docker rm" to actually delete it.
  Think of "stop" as pausing, "rm" as deleting.
```

---

## Task 4: Explore Docker Commands

### 4.1 Detached Mode vs Foreground Mode

```bash
# FOREGROUND (default) — output is in your terminal, blocks your shell
docker run nginx
# You see Nginx logs scrolling by...
# Your terminal is busy. You can't type anything.
# Press Ctrl+C to stop.

# DETACHED (-d) — runs in the background, your terminal is free
docker run -d nginx
# abc123def456   ← Just prints the container ID and gives you back your prompt
# Your terminal is free. The container runs in the background.

# Check what's running in the background
docker ps
```

```
FOREGROUND:                    DETACHED:
┌──────────────┐               ┌──────────────┐
│ Terminal     │               │ Terminal     │
│              │               │              │
│ $ docker run │               │ $ docker run │
│   nginx      │               │   -d nginx   │
│              │               │ abc123       │
│ [logs flow]  │               │ $            │  ← You can type!
│ [logs flow]  │               │ $ docker ps  │  ← Container runs
│ [logs flow]  │               │ [shows nginx]│     in background
│ [blocked!]   │               │ $            │
└──────────────┘               └──────────────┘
```

---

### 4.2 Custom Container Names

```bash
# Without a name — Docker assigns a random funny name
docker run -d nginx
# Docker names it something like "vibrant_pascal" or "sleepy_newton"

# With a custom name — much easier to manage!
docker run -d --name web-server nginx
docker run -d --name database postgres
docker run -d --name cache redis

# Now you can reference them by name:
docker stop web-server
docker logs database
docker exec -it cache bash
```

---

### 4.3 Port Mapping

```bash
# Run Nginx on different ports
docker run -d -p 8080:80 --name web1 nginx    # Host 8080 → Container 80
docker run -d -p 8081:80 --name web2 nginx    # Host 8081 → Container 80
docker run -d -p 9090:80 --name web3 nginx    # Host 9090 → Container 80

# Now you have 3 Nginx servers running on different ports!
# http://localhost:8080 → web1
# http://localhost:8081 → web2
# http://localhost:9090 → web3
```

```
MULTIPLE CONTAINERS, DIFFERENT PORTS:

  Your Computer (Host)
  ┌──────────────────────────────────────────────┐
  │                                              │
  │  Port 8080 ──────▶ ┌──────────┐             │
  │                    │  web1    │ (Nginx:80)   │
  │                    └──────────┘             │
  │                                              │
  │  Port 8081 ──────▶ ┌──────────┐             │
  │                    │  web2    │ (Nginx:80)   │
  │                    └──────────┘             │
  │                                              │
  │  Port 9090 ──────▶ ┌──────────┐             │
  │                    │  web3    │ (Nginx:80)   │
  │                    └──────────┘             │
  │                                              │
  │  Each container thinks it's using port 80    │
  │  but they're mapped to different host ports  │
  └──────────────────────────────────────────────┘
```

---

### 4.4 Container Logs

```bash
# View all logs
docker logs my-nginx

# Follow logs in real-time (like tail -f)
docker logs -f my-nginx

# Show only the last 20 lines
docker logs --tail 20 my-nginx

# Show logs with timestamps
docker logs -t my-nginx

# Combine: last 10 lines with timestamps, then follow
docker logs --tail 10 -t -f my-nginx
```

---

### 4.5 Execute Commands Inside a Running Container

```bash
# Run a single command inside a running container
docker exec my-nginx cat /etc/nginx/nginx.conf
# Shows the Nginx configuration file

# Open an interactive shell inside a running container
docker exec -it my-nginx bash
# root@abc123:/# ← You're inside the running Nginx container!
# ls /usr/share/nginx/html/
# index.html
# exit

# Run commands without entering the container
docker exec my-nginx ls /var/log/nginx/
docker exec my-nginx whoami
docker exec my-nginx hostname
```

```
docker exec vs docker run:

  docker run       → Creates a NEW container from an image
  docker exec      → Runs a command inside an EXISTING container

  Think of it like:
  docker run  = Buy a new car and drive it
  docker exec = Open the hood of your existing car and look inside
```

---

## 🔧 Docker Commands Cheat Sheet

### Container Lifecycle

| Command | What It Does | Example |
|---------|-------------|---------|
| `docker run <image>` | Create and start a new container | `docker run nginx` |
| `docker run -d <image>` | Run in background (detached) | `docker run -d nginx` |
| `docker run -it <image> bash` | Run interactively (with shell) | `docker run -it ubuntu bash` |
| `docker run -p H:C <image>` | Map host port H to container port C | `docker run -p 8080:80 nginx` |
| `docker run --name X <image>` | Give the container a name | `docker run --name web nginx` |
| `docker start <name>` | Start a stopped container | `docker start my-nginx` |
| `docker stop <name>` | Stop a running container | `docker stop my-nginx` |
| `docker restart <name>` | Restart a container | `docker restart my-nginx` |
| `docker rm <name>` | Remove a stopped container | `docker rm my-nginx` |
| `docker rm -f <name>` | Force remove (even if running) | `docker rm -f my-nginx` |

### Inspection & Monitoring

| Command | What It Does | Example |
|---------|-------------|---------|
| `docker ps` | List running containers | `docker ps` |
| `docker ps -a` | List ALL containers (including stopped) | `docker ps -a` |
| `docker logs <name>` | View container output/logs | `docker logs my-nginx` |
| `docker logs -f <name>` | Follow logs in real-time | `docker logs -f my-nginx` |
| `docker exec -it <name> bash` | Open a shell inside a container | `docker exec -it my-nginx bash` |
| `docker exec <name> <cmd>` | Run a command inside a container | `docker exec my-nginx ls /` |
| `docker inspect <name>` | View detailed container info (JSON) | `docker inspect my-nginx` |
| `docker stats` | Live resource usage (CPU, memory) | `docker stats` |
| `docker top <name>` | Show running processes in a container | `docker top my-nginx` |

### Image Management

| Command | What It Does | Example |
|---------|-------------|---------|
| `docker images` | List local images | `docker images` |
| `docker pull <image>` | Download an image from Docker Hub | `docker pull ubuntu` |
| `docker rmi <image>` | Remove a local image | `docker rmi nginx` |
| `docker image prune` | Remove unused images | `docker image prune` |

### Cleanup

| Command | What It Does |
|---------|-------------|
| `docker container prune` | Remove all stopped containers |
| `docker image prune` | Remove unused images |
| `docker system prune` | Remove all unused data (containers, images, networks) |
| `docker system prune -a` | Remove EVERYTHING unused (⚠️ aggressive cleanup) |

---

## 🧠 Summary

```
┌──────────────────────────────────────────────────────────────────┐
│                    KEY CONCEPTS — DAY 29                          │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  WHAT IS DOCKER?                                                 │
│  • Solves "it works on my machine" — same container everywhere   │
│  • Container = portable package (app + everything it needs)      │
│  • Image = blueprint (read-only) → Container = running instance  │
│                                                                  │
│  CONTAINERS vs VMs                                               │
│  • VMs: Full OS, GBs, minutes to start                          │
│  • Containers: Shared kernel, MBs, seconds to start              │
│  • Modern DevOps uses containers by default                      │
│                                                                  │
│  DOCKER ARCHITECTURE                                             │
│  • Client (CLI) → Daemon (engine) → Registry (Docker Hub)       │
│  • You type commands → daemon does the work → pulls from Hub    │
│                                                                  │
│  ESSENTIAL COMMANDS                                              │
│  • docker run       → Create and start a container               │
│  • docker ps        → List running containers                    │
│  • docker stop/rm   → Stop / delete containers                   │
│  • docker logs      → View container output                      │
│  • docker exec      → Run commands inside a container            │
│                                                                  │
│  KEY FLAGS                                                       │
│  • -d      → Detached (background)                               │
│  • -it     → Interactive terminal                                │
│  • -p H:C  → Port mapping (host:container)                       │
│  • --name  → Custom container name                               │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

<div align="center">

**Day 29 Complete ✅ — First Docker containers running!** 🐳

*"Containers don't just solve deployment problems — they change how you think about infrastructure."*

**#90DaysOfDevOps #TrainWithShubham**

</div>
