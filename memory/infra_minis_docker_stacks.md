---
name: infra-minis-docker-stacks
description: "timevans-MINI-S Docker stacks: homelab (Portainer/Gitea/Obsidian/Stirling-PDF/Nextcloud) + seafile cloud drive — ports, data paths, secrets"
metadata: 
  node_type: memory
  type: project
  originSessionId: e24d82e5-1bd0-48dc-99e6-9a4a434f0d2d
---

Docker is installed on [[infra-minis-remote-access]] (`timevans-MINI-S`, Zorin/Ubuntu-noble base) via
Docker's official apt repo; user `timevans` is in the `docker` group. Two Compose stacks, both LAN-only
(nothing exposed to the internet), all containers `restart: unless-stopped`.

## Stack 1 — "homelab"  (`/home/timevans/docker/compose.yaml`)
Data bind-mounted under `/home/timevans/docker/<service>/`. Secrets in `/home/timevans/docker/.env` (chmod 600:
`NC_DB_ROOT_PASSWORD`, `NC_DB_PASSWORD`, `TZ=Europe/London`, `PUID/PGID=1000`).
Services / host ports:
- **portainer** (portainer/portainer-ce) — https `9443`
- **gitea** (gitea/gitea, sqlite) — web `3000`, git-ssh `222`. Separate from the existing `gitea.oneoffgames.net`.
- **obsidian** (lscr.io/linuxserver/obsidian, browser desktop via KasmVNC) — **`https://192.168.1.6:3002`** (host 3002 -> container 3001 = HTTPS, self-signed cert; use HTTPS so KasmVNC clipboard works. Plain HTTP on container 3000 is not mapped.)
- **stirling-pdf** (stirlingtools/stirling-pdf) — `8081`
- **nextcloud** (nextcloud:apache) — `8080`; backed by **nextcloud-db** (mariadb:11) + **nextcloud-redis** (internal only)

## Stack 2 — "seafile"  (`/home/timevans/docker-seafile/compose.yaml`)  — UP & WORKING
Dedicated Seafile cloud drive (Dropbox-style sync). Data under `/home/timevans/docker-seafile/{db,seafile-data}/`.
Secrets in `/home/timevans/docker-seafile/.env` (chmod 600: `SEAFILE_DB_ROOT_PASSWORD`, `SEAFILE_ADMIN_EMAIL`
= timevans666@gmail.com, `SEAFILE_ADMIN_PASSWORD`, `TZ`).
- **seafile** (seafileltd/seafile-mc:11.0-latest) — web `http://192.168.1.6` (host port `80`)
- **seafile-db** (mariadb:10.11) + **seafile-memcached** (memcached:1.6) — internal only
- Admin login is in that `.env`; user should change it after first login.

## Operating notes
- **Bring up / manage:** `cd <stack-dir> && docker compose up -d` (use `sudo docker ...` until a fresh login
  activates docker-group membership). Portainer at `:9443` manages both stacks.
- **Setup scripts** lived in `/tmp` (`setup-homelab.sh`, `setup-seafile.sh`) — transient, may be gone after reboot.
- Two cloud drives now coexist: Seafile (fast file sync) + Nextcloud (documents/groupware). User may later retire one.
- **Why:** user wanted a self-hosted homelab + a cloud drive on this machine. Setup needs interactive sudo, so
  install/up steps are run by the user via `sudo bash`, not by Claude (the `!` prefix can't do interactive sudo).
