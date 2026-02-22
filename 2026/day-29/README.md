# 🐳 Day 29 – Introduction to Docker

<div align="center">

![Day](https://img.shields.io/badge/Day-29-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Docker_Basics-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Challenge](https://img.shields.io/badge/90DaysOfDevOps-2026-orange?style=for-the-badge)

*"Containers don't just solve deployment problems — they change how you think about infrastructure."*

</div>

---

## 🎯 Task Overview

Today's goal is to **understand what Docker is and run your first container**. Docker is the foundation of modern deployment — every CI/CD pipeline, Kubernetes cluster, and microservice architecture starts with containers.

You will:
- 🧠 Learn why containers exist and how they differ from VMs
- 🔧 Install Docker on your machine
- 🚀 Run and explore containers from Docker Hub
- 🔍 Master essential Docker commands

---

## 📚 Learning Objectives

| # | Objective | Covered |
|:-:|-----------|:-------:|
| 1 | Understand what containers are and why we need them | ✅ |
| 2 | Explain containers vs VMs — the real difference | ✅ |
| 3 | Understand Docker architecture (client, daemon, registry, images, containers) | ✅ |
| 4 | Install Docker and verify the installation | ✅ |
| 5 | Run containers in detached and interactive modes | ✅ |
| 6 | Master container lifecycle commands (run, stop, start, rm, logs, exec) | ✅ |

---

## 📦 Expected Output

| # | Deliverable | Description |
|:-:|-------------|-------------|
| 1 | 📄 [`day-29-docker-basics.md`](day-29-docker-basics.md) | Comprehensive Docker notes with visual diagrams and explanations |
| 2 | 📸 Screenshots | Running containers (Nginx, Ubuntu, hello-world) |

---

## 🗺️ Docker — The Big Picture

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                        WHY DOCKER EXISTS                                     │
│                                                                              │
│  THE PROBLEM:                                                                │
│                                                                              │
│    Developer A          Developer B          Production Server               │
│    ┌──────────┐        ┌──────────┐        ┌──────────┐                     │
│    │ Ubuntu   │        │ macOS    │        │ Amazon   │                     │
│    │ Python 3.11        │ Python 3.9│        │ Linux    │                     │
│    │ PG 14.2  │        │ MySQL 8  │        │ ???      │                     │
│    └──────────┘        └──────────┘        └──────────┘                     │
│       ✅ Works            ❌ Broken            ❌ ???                         │
│                                                                              │
│  THE SOLUTION (Docker):                                                      │
│                                                                              │
│    Developer A          Developer B          Production Server               │
│    ┌──────────┐        ┌──────────┐        ┌──────────┐                     │
│    │🐳 Docker │        │🐳 Docker │        │🐳 Docker │                     │
│    │ Same     │        │ Same     │        │ Same     │                     │
│    │ Container│        │ Container│        │ Container│                     │
│    └──────────┘        └──────────┘        └──────────┘                     │
│       ✅ Works            ✅ Works            ✅ Works!                       │
│                                                                              │
│  SAME container → SAME environment → EVERYWHERE                             │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔧 Challenge Tasks

### Task 1: What is Docker?

Research and write short notes on:
- **What is a container and why do we need them?**
- **Containers vs Virtual Machines** — what's the real difference?
- **Docker architecture** — daemon, client, images, containers, registry

#### Containers vs VMs at a Glance

```
VM (Heavy)                           Container (Lightweight)
┌──────────────┐                    ┌──────────────────┐
│    App A     │                    │  App A  │  App B │
├──────────────┤                    ├─────────┴────────┤
│  Guest OS    │ ← Full OS (GBs)    │ Container Runtime │ ← Shared kernel (MBs)
├──────────────┤                    ├──────────────────┤
│  Hypervisor  │                    │     Host OS      │
├──────────────┤                    ├──────────────────┤
│   Hardware   │                    │    Hardware      │
└──────────────┘                    └──────────────────┘
Startup: Minutes                    Startup: Seconds
Size: GBs                           Size: MBs
```

| Feature | Virtual Machine | Container |
|---------|:--------------:|:---------:|
| **Size** | GBs (full OS) | MBs (app + deps only) |
| **Startup** | Minutes | Seconds |
| **Isolation** | Hardware-level (strong) | Process-level (good) |
| **Density** | 5-20 per server | 100s-1000s per server |
| **Use case** | Different OSes, strong isolation | App deployment, microservices |

#### Docker Architecture

```
  YOU ──▶ Docker Client (CLI) ──▶ Docker Daemon (engine) ──▶ Docker Hub (registry)
                                        │
                                  ┌─────┴─────┐
                                  │ Containers │
                                  └───────────┘
```

| Component | Role | Analogy |
|-----------|------|---------|
| **Client** | CLI where you type commands | Steering wheel |
| **Daemon** | Background engine that does the work | Car engine |
| **Image** | Read-only blueprint for containers | Cookie cutter |
| **Container** | Running instance of an image | The cookie |
| **Registry** | Library of pre-built images (Docker Hub) | App store |

> 📄 See [`day-29-docker-basics.md`](day-29-docker-basics.md) for full architecture diagrams and beginner-friendly explanations!

---

### Task 2: Install Docker

```bash
# Ubuntu/Debian installation
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add your user to docker group (no more sudo)
sudo usermod -aG docker $USER
# Log out and back in

# Verify
docker --version
docker info

# Test with hello-world
docker run hello-world
# ✅ "Hello from Docker!" = Installation successful
```

> 📄 See [`day-29-docker-basics.md`](day-29-docker-basics.md) for full installation steps and hello-world output breakdown!

---

### Task 3: Run Real Containers

#### 3.1 Run Nginx (Web Server)

```bash
docker run -d -p 8080:80 --name my-nginx nginx
# Open http://localhost:8080 in your browser → Nginx welcome page!
```

#### 3.2 Run Ubuntu (Interactive)

```bash
docker run -it --name my-ubuntu ubuntu bash
# You're inside a mini Linux machine!
# root@abc123:/# whoami → root
# exit to leave
```

#### 3.3 Container Management

```bash
docker ps                # List running containers
docker ps -a             # List ALL containers (including stopped)
docker stop my-nginx     # Stop a container
docker start my-nginx    # Start it again
docker rm my-nginx       # Remove it (must be stopped first)
docker rm -f my-nginx    # Force remove (stop + delete)
```

```
Container Lifecycle:

  docker run ──▶ RUNNING ──▶ docker stop ──▶ STOPPED ──▶ docker rm ──▶ GONE
```

> 📄 See [`day-29-docker-basics.md`](day-29-docker-basics.md) for port mapping diagrams, interactive mode explanation, and step-by-step walkthroughs!

---

### Task 4: Explore Docker Commands

| # | Concept | Command | What It Does |
|:-:|---------|---------|-------------|
| 1 | **Detached mode** | `docker run -d nginx` | Runs in background, frees your terminal |
| 2 | **Custom name** | `docker run --name web nginx` | Names the container for easy reference |
| 3 | **Port mapping** | `docker run -p 8080:80 nginx` | Maps host:8080 → container:80 |
| 4 | **View logs** | `docker logs my-nginx` | See container output |
| 5 | **Follow logs** | `docker logs -f my-nginx` | Real-time log streaming |
| 6 | **Exec into container** | `docker exec -it my-nginx bash` | Open shell inside running container |
| 7 | **Run single command** | `docker exec my-nginx ls /` | Run one command inside container |
| 8 | **Resource usage** | `docker stats` | Live CPU/memory monitoring |

> 📄 See [`day-29-docker-basics.md`](day-29-docker-basics.md) for comprehensive Docker commands cheat sheet!

---

## ✅ Task Completion Checklist

- [x] 🧠 **What is Docker** — Containers explained, "works on my machine" problem solved
- [x] 📊 **Containers vs VMs** — Visual comparison with size, speed, isolation tradeoffs
- [x] 🏗️ **Docker Architecture** — Client, Daemon, Images, Containers, Registry explained
- [x] 🔧 **Docker Installed** — Verified with `docker --version` and `hello-world`
- [x] 🌐 **Nginx Container** — Web server running, accessible in browser via port mapping
- [x] 🐧 **Ubuntu Interactive** — Explored container as a mini Linux machine
- [x] 📋 **Container Management** — `ps`, `stop`, `start`, `rm`, `ps -a` mastered
- [x] 🔀 **Detached vs Foreground** — Understand when to use `-d` flag
- [x] 🏷️ **Custom Names** — Using `--name` for easy container management
- [x] 🔌 **Port Mapping** — `host:container` port forwarding understood
- [x] 📜 **Logs** — `docker logs` and `docker logs -f` for monitoring
- [x] 🔧 **Exec** — Running commands inside running containers
- [x] 📄 **`day-29-docker-basics.md`** — Comprehensive notes with diagrams

---

## 🧠 Key Takeaways

1. **Docker solves portability** — A container packages your app + its entire environment, so it runs identically on any machine.

2. **Containers are NOT VMs** — They share the host OS kernel, making them 10-100x lighter and faster to start.

3. **Image vs Container** — An image is a blueprint (read-only); a container is a running instance. One image → many containers.

4. **Essential flags to remember** — `-d` (detached), `-it` (interactive), `-p` (port), `--name` (naming).

5. **`docker exec` is your debugging tool** — When something's wrong inside a container, jump in with `docker exec -it container bash`.

6. **Every modern DevOps tool builds on Docker** — Kubernetes, CI/CD pipelines, microservices, and cloud deployments all use containers as the fundamental building block.

---

## 💡 Hints

- `docker run`, `docker ps`, `docker stop`, `docker rm`
- Interactive mode: `-it` flag
- Detached mode: `-d` flag
- Port mapping: `-p host:container`
- Naming: `--name`
- Logs: `docker logs`
- Exec into container: `docker exec`

---

## 🌍 Why This Matters for DevOps

Docker is the foundation of modern deployment. Every CI/CD pipeline, Kubernetes cluster, and microservice architecture starts with containers. Today you took the first step.

---

## 📤 Submission

1. Add your `day-29-docker-basics.md` to `2026/day-29/`
2. Commit and push to your fork

---

## 🌐 Learn in Public

Share your first Docker container screenshot on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

---

<div align="center">

**Happy Learning! 🎉**  
**TrainWithShubham**

</div>
