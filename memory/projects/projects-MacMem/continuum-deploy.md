---
name: continuum-deploy
description: "How the Continuum 2026 con-app subdomains are deployed (VPS, Caddy, SSH access)"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 1236b663-476a-428a-8f4e-8d2d0ed308f7
  modified: 2026-07-25T10:17:25.127Z
---

Deploy topology for the Continuum 2026 con apps (repo: github `slaguru666/Continuum2026`, which is a **backup only** — the VPS does not pull from it).

- **Deploy VPS:** `77.68.99.134`, user `tevans`, hostname `ubuntu`. Direct `ssh tevans@77.68.99.134` works from Tim's Mac with the default key (host key already trusted in known_hosts).
- **On-VPS repo:** `/home/tevans/continuum-pwa` — a **local-only git repo** (single "Initial commit", **no `origin` remote**, unrelated history to GitHub). Deploy uses the working tree, not a git pull. To ship new files: `scp` them into this dir, then run the app's deploy script; optionally `git add/commit` locally to keep it tracked.
- **Reverse proxy:** shared Caddy container `graphiti-caddy-1`, config at `/opt/graphiti/Caddyfile` (writable by tevans). Each app is its own static/Caddy container on the external docker network `proxy`. Deploy scripts append a `<sub>.timevans.uk { reverse_proxy <app>:80 }` block (idempotent) and run `docker exec graphiti-caddy-1 caddy reload` (atomic — bad config is rejected, live sites keep serving). TLS is auto via Let's Encrypt **TLS-ALPN-01** (port 443), so a global port-80 HTTP→HTTPS redirect on the box does NOT block issuance.
- **Live subdomains:** `apps.timevans.uk` (main PWA, `continuum-app`), `vanityrpg.timevans.uk` (Vanity table roller, `vanity-app` — deployed 2026-07-25, see [[forgerpg]] neighbours). Pattern folder in repo: `deploy-vanity/` mirrors `deploy/`.

**Caution:** the SSH alias `graphiti-server` in `~/.ssh/config` points at a **different** box (`178.238.235.121`, User tevans) — NOT the deploy VPS — and as of 2026-07-25 its host key had **changed** (known_hosts:9 offending), so connecting via that alias fails strict checking. Verify that box wasn't compromised before using the alias; it's unrelated to the con-app deploys.
