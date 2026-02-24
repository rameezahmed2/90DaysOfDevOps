# 🐳 Day 30 – Docker Images & Container Lifecycle

<div align="center">

![Day](https://img.shields.io/badge/Day-30-blue?style=for-the-badge)
![Topic](https://img.shields.io/badge/Topic-Docker_Images_&_Lifecycle-green?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=for-the-badge)
![Challenge](https://img.shields.io/badge/90DaysOfDevOps-2026-orange?style=for-the-badge)

*"Understanding layers is the difference between 50MB images and 2GB images."*

</div>

---

## 🎯 Task Overview

Today's goal is to **understand how images and containers actually work** under the hood. You will learn the relationship between images and containers, understand image layers and caching, and master the full container lifecycle.

---

## 📚 Learning Objectives

| # | Objective | Covered |
|:-:|-----------|:-------:|
| 1 | Pull, list, and compare Docker images | ✅ |
| 2 | Understand why Alpine is 14MB and Ubuntu is 117MB | ✅ |
| 3 | Inspect images to find ports, env vars, entrypoints | ✅ |
| 4 | Understand image layers and why Docker uses them | ✅ |
| 5 | Master every container state (create, run, pause, stop, kill, rm) | ✅ |
| 6 | Work with running containers (logs, exec, inspect) | ✅ |
| 7 | Clean up containers, images, and disk space efficiently | ✅ |

---

## 📦 Expected Output

| # | Deliverable | Description |
|:-:|-------------|-------------|
| 1 | 📄 [`day-30-images.md`](day-30-images.md) | Comprehensive notes with all 15 screenshots and command explanations |
| 2 | 📸 [`src/`](src/) | 15 screenshots documenting every task |

---

## 📸 Screenshot Index

All screenshots are in the `src/` directory:

|  #  | Screenshot                                                                                                                           | Task | What It Shows                                                     |
| :-: | ------------------------------------------------------------------------------------------------------------------------------------ | :--: | ----------------------------------------------------------------- |
|  1  | [`task-01:pull-nginx.png`](src/task-01:pull-nginx.png)                                                                               |  1   | Pulling Nginx image — 7+ layers downloading                       |
|  2  | [`task-01:pull-ubuntu.png`](src/task-01:pull-ubuntu.png)                                                                             |  1   | Pulling Ubuntu image — single layer                               |
|  3  | [`task-01:pull-alpine.png`](src/task-01:pull-alpine.png)                                                                             |  1   | Pulling Alpine — the tiniest Linux                                |
|  4  | [`task-01:show-images.png`](src/task-01:show-images.png)                                                                             |  1   | `docker images`, `docker images -a`, `docker image ls` comparison |
|  5  | [`task-01:inspect-image+size.png`](src/task-01:inspect-image+size.png)                                                               |  1   | `docker inspect nginx` — JSON metadata                            |
|  6  | [`task-01:remove-image.png`](src/task-01:remove-image.png)                                                                           |  1   | Removing Alpine and Nginx images                                  |
|  7  | [`task-02:image-history.png`](src/task-02:image-history.png)                                                                         |  2   | `docker image history` for Nginx and Ubuntu — all layers          |
|  8  | [`task-03:create-start-restart-pause-container.png`](src/task-03:create-start-restart-pause-container.png)                           |  3   | Create → Start → Restart → Pause lifecycle                        |
|  9  | [`task-03:pause-unpause-kill-rename-container.png`](src/task-03:pause-unpause-kill-rename-container.png)                             |  3   | Unpause → Kill → Rename + exit codes                              |
| 10  | [`task-04:detachedmode-logs-real-time-logs.png`](src/task-04:detachedmode-logs-real-time-logs.png)                                   |  4   | Detached mode, `docker logs -f` real-time output                  |
| 11  | [`task-04:exec-into-container.png`](src/task-04:exec-into-container.png)                                                             |  4   | `docker exec -it bash` — exploring /etc, /etc/hosts               |
| 12  | [`task-04:running-command-without-entering-inside-container.png`](src/task-04:running-command-without-entering-inside-container.png) |  4   | `docker exec -d` — create files without entering                  |
| 13  | [`task-04:inspect-container.png`](src/task-04:inspect-container.png)                                                                 |  4   | `docker inspect --format` — network settings, IP address          |
| 14  | [`task-05:stop-all-container-command.png`](src/task-05:stop-all-container-command.png)                                               |  5   | `docker stop $(docker ps -q)` + `docker container prune`          |
| 15  | [`task-05:remove-all-images.png`](src/task-05:remove-all-images.png)                                                                 |  5   | `docker image rm $(docker images -q)` — full cleanup              |

---

## 🔧 Challenge Tasks

### Task 1: Docker Images

Pull, list, compare, inspect, and remove images.

#### Image Size Comparison (from my screenshots)

| Image | Disk Usage | Content Size | Why This Size? |
|-------|:----------:|:------------:|----------------|
| **alpine** | 14 MB | 3.95 MB | musl libc + busybox = minimal |
| **ubuntu** | 117 MB | 31.7 MB | glibc + apt + coreutils |
| **nginx** | 239 MB | 65.8 MB | Debian base + Nginx + config scripts |

```bash
docker pull nginx          # 7+ layers — web server on Debian
docker pull ubuntu         # 1 layer — base OS
docker pull alpine         # 1 layer — the tiniest Linux (14MB!)
docker images              # Compare sizes
docker inspect nginx       # See ports, env vars, entrypoint
docker image rm alpine     # Remove an image
docker rmi nginx           # Alternative shorter syntax
```

> 📄 See [`day-30-images.md`](day-30-images.md) for full screenshots and why Alpine is 8x smaller than Ubuntu!

---

### Task 2: Image Layers

Every image is a **stack of layers**. Each Dockerfile instruction creates one layer.

```
Nginx Image — Layer Breakdown (from docker image history):

  ┌────────────────────────────────────────────┐
  │ CMD ["nginx", "-g", "daemon off;"]         │  0 B    ← metadata
  │ EXPOSE 80                                  │  0 B    ← metadata
  │ COPY config files (5 files)                │  ~25 kB ← tiny
  │ RUN apt install nginx                      │  87 MB  ← 🔴 big!
  │ ENV NGINX_VERSION=1.29.5                   │  0 B    ← metadata
  │ Debian base (trixie)                       │  86 MB  ← 🔴 big!
  └────────────────────────────────────────────┘
  
  Only 2 layers account for 173MB of the total 239MB image!
```

```bash
docker image history nginx     # See all layers
docker image history ubuntu    # Compare — much simpler
```

> 📄 See [`day-30-images.md`](day-30-images.md) for layer-by-layer analysis with screenshot!

---

### Task 3: Container Lifecycle

Practice every state a container can be in:

```
  docker create     docker start     docker pause     docker unpause
  ┌─────────┐      ┌─────────┐      ┌─────────┐      ┌─────────┐
  │ CREATED │─────▶│ RUNNING │─────▶│ PAUSED  │─────▶│ RUNNING │
  └─────────┘      └────┬────┘      └─────────┘      └────┬────┘
                        │                                   │
                  docker stop / kill                  docker stop / kill
                        │                                   │
                        ▼                                   ▼
                   ┌─────────┐                         ┌─────────┐
                   │ STOPPED │───── docker rm ────────▶│ REMOVED │
                   └─────────┘                         └─────────┘
```

```bash
docker create --name nginx-container nginx    # Created (not running)
docker start nginx-container                  # Running
docker pause nginx-container                  # Paused (frozen)
docker unpause nginx-container                # Running again
docker stop nginx-container                   # Stopped (graceful)
docker start nginx-container                  # Running again
docker kill nginx-container                   # Stopped (forced, exit 137)
docker rename nginx-container nginx-webserver # Rename
docker rm nginx-webserver                     # Removed (gone forever)
```

#### `docker stop` vs `docker kill`

| | `docker stop` | `docker kill` |
|--|:------------:|:------------:|
| **Signal** | SIGTERM → wait 10s → SIGKILL | SIGKILL (immediate) |
| **Graceful?** | ✅ Yes | ❌ No |
| **Exit code** | `0` (clean) | `137` (killed) |
| **When?** | Normal shutdown | Emergency / stuck process |

> 📄 See [`day-30-images.md`](day-30-images.md) for screenshots showing every state transition with `docker ps` output!

---

### Task 4: Working with Running Containers

```bash
# Run in detached mode
docker run -d --name webserver nginx

# View logs (real-time)
docker logs -f webserver

# Exec into the container
docker exec -it webserver bash

# Run a command without entering
docker exec -d webserver touch /home/hello
docker exec -d webserver bash -c 'echo "Hello!" >> /home/hello'

# Inspect container (find IP address)
docker inspect --format '{{.NetworkSettings.IPAddress}}' webserver
# → 172.17.0.2
```

> 📄 See [`day-30-images.md`](day-30-images.md) for screenshots showing exec, logs, inspect with flag explanations!

---

### Task 5: Cleanup

```bash
# Stop ALL running containers at once
docker stop $(docker ps -q)

# Remove all stopped containers
docker container prune

# Remove all images
docker image rm $(docker images -q)

# Check disk usage
docker system df

# Nuclear cleanup — remove EVERYTHING unused
docker system prune -a
```

> 📄 See [`day-30-images.md`](day-30-images.md) for cleanup screenshots and disk space reclaimed!

---

## ✅ Task Completion Checklist

- [x] 📥 **Pull Images** — Downloaded Nginx (239MB), Ubuntu (117MB), Alpine (14MB)
- [x] 📋 **List Images** — Used `docker images`, `docker images -a`, `docker image ls`
- [x] 🔍 **Compare Sizes** — Understood why Alpine is 8x smaller (musl + busybox)
- [x] 🔎 **Inspect Image** — Found ports (80/tcp), env vars, entrypoint, Nginx version
- [x] 🗑️ **Remove Images** — Used both `docker image rm` and `docker rmi`
- [x] 📊 **Image Layers** — Analyzed Nginx (7+ layers) vs Ubuntu (1 layer) with `docker image history`
- [x] 🔄 **Container Lifecycle** — Practiced all states: Created → Running → Paused → Stopped → Removed
- [x] ⚡ **stop vs kill** — Understood SIGTERM (graceful) vs SIGKILL (forced), exit codes 0 vs 137
- [x] 📝 **Rename** — Used `docker rename` to change container name
- [x] 🏃 **Detached Mode** — Ran containers with `-d`, verified with `docker ps`
- [x] 📜 **Logs** — Used `docker logs` and `docker logs -f` for real-time monitoring
- [x] 🐚 **Exec** — Entered containers with `-it bash`, ran commands with `-d`
- [x] 🌐 **Inspect Container** — Found IP address (172.17.0.2), gateway, MAC, port mappings
- [x] 🧹 **Cleanup** — Stopped all, pruned containers, removed all images
- [x] 📸 **15 Screenshots** — Documented every step in `src/` directory

---

## 🧠 Key Takeaways

1. **Images are layered** — Only `RUN`, `COPY`, and `ADD` create layers with real size. `ENV`, `EXPOSE`, and `CMD` are just metadata (0 bytes).

2. **Alpine is 8x smaller than Ubuntu** — Uses `musl libc` instead of `glibc`, `busybox` instead of `coreutils`. Use Alpine in production for smaller, faster, more secure images.

3. **Layers are shared and cached** — If two images use the same Debian base, Docker stores it only once. This saves GBs of disk space.

4. **`docker stop` ≠ `docker kill`** — Stop sends SIGTERM (graceful, 10s timeout). Kill sends SIGKILL (instant death). Exit code 0 = clean, 137 = killed.

5. **`docker exec` is your debugging superpower** — Jump into any running container to inspect logs, check config files, test connectivity, or run diagnostics.

6. **Always clean up** — `docker system prune -a` removes everything unused. Without regular cleanup, Docker can consume 50+ GB of disk space.

---

## 💡 Hints

- Image history: `docker image history`
- Create without starting: `docker create`
- Follow logs: `docker logs -f`
- Inspect: `docker inspect`
- Cleanup: `docker system df`, `docker system prune`

---

## 📤 Submission

1. Add your `day-30-images.md` to `2026/day-30/`
2. Commit and push to your fork

---

## 🌐 Learn in Public

Share what surprised you about image layers or container states on LinkedIn.

`#90DaysOfDevOps` `#DevOpsKaJosh` `#TrainWithShubham`

---

<div align="center">

**Happy Learning! 🎉**  
**TrainWithShubham**

</div>