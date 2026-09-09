---
name: infra-oneoffgames-vps
description: "Contabo VPS 85.190.246.132 (ssh alias `foundry`, root only) — nginx serving web.oneoffgames.com plus foundry/n8n/code-server; this is the user's public game-material site and the place static things get hosted"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 81a1afbb-fc23-4ed9-b787-a664647d8b4e
  modified: 2026-09-08T20:33:55.371Z
---

`ssh foundry` reaches **85.190.246.132** (Contabo, Ubuntu 24.04, hostname `vmi2869320`, 193G disk). The `~/.ssh/config` entry `contabo` for the same IP uses user `tevans` and **does not work** — only `root@` authenticates, via `~/.ssh/id_ed25519` or `contabo_ed25519`. The second Contabo box in that config, `nodeserver` (178.238.235.121), rejects every key on the Mac.

nginx serves five sites from `/etc/nginx/sites-enabled/`: `web.oneoffgames.com`, `foundry` (FoundryVTT on 127.0.0.1:8443), `n8n.oneoffgames.com`, `code-server`, and `loom.oneoffgames.com` (proxy to 127.0.0.1:8771, 64 MB body limit — see [[loom-app]]). Certbot holds certs for `web.`, `foundry.`, `n8n.`, `code.` and `loom.oneoffgames.com`, renewed by `certbot.timer`. Vault (8200), Consul and Docker also run here — it is production, so survey before changing anything.

**`/var/www/web.oneoffgames.com` is the user's public game-material library** — ~30 flat HTML pages (Blade Runner, Call of Cthulhu, Shadowdark, Daggerheart, Mothership, conventions) owned `webftp:www-data`, 644 files / 755 dirs. Its `location /` is `try_files $uri $uri/ =404` with `index index.html`, so **a new subdirectory is served with no nginx change at all** — copy files in and it is live. `/conventions` and the Directive 19 companion sit behind `auth_basic` with `/etc/nginx/.htpasswd`; everything else is public.

House style for that site is a green-phosphor CRT terminal: VT323 from Google Fonts, `#33ff33` on `#0a0a0a`, glowing borders, `> ` appearing on hover, blinking cursor. Match it rather than introducing a second typeface — see `index.html` for the canonical menu markup.

DNS for `oneoffgames.com` is at **Porkbun**, and the wildcard points at Porkbun parking rather than the VPS — a new subdomain needs a real A record to 85.190.246.132, added by the user, before certbot can issue.

MINI-S (`192.168.1.6`) is **not reachable from the Mac Mini**, which sits on `192.168.0.x` — different subnet, so LAN SSH times out. Use this VPS for anything that needs to be on the internet.

**Why:** the user asked to host the audio apps and the working assumption had been MINI-S; this box turned out to be the right home and was not in any memory. **How to apply:** for "host this", "put this online", or anything under `*.oneoffgames.com`, start here. Related: [[ambient-synth]], [[esper-app]], [[haunt-app]], [[grimoire-app]], [[nexus-app]], [[loom-app]], [[infra_minis_remote_access]].
