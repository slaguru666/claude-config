---
name: infra-oneoffgames-vps
description: "Contabo VPS 85.190.246.132 (ssh alias `foundry`, root only) — nginx serving web.oneoffgames.com plus foundry/n8n/code-server; this is the user's public game-material site and the place static things get hosted"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 81a1afbb-fc23-4ed9-b787-a664647d8b4e
  modified: 2026-10-14T17:45:27.619Z
---

`ssh foundry` reaches **85.190.246.132** (Contabo, Ubuntu 24.04, hostname `vmi2869320`, 193G disk). The `~/.ssh/config` entry `contabo` for the same IP uses user `tevans` and **does not work** — only `root@` authenticates, via `~/.ssh/id_ed25519` or `contabo_ed25519`. The second Contabo box in that config, `nodeserver` (178.238.235.121), rejects every key on the Mac.

nginx serves five sites from `/etc/nginx/sites-enabled/`: `web.oneoffgames.com`, `foundry` (FoundryVTT on 127.0.0.1:8443), `n8n.oneoffgames.com`, `code-server`, and `loom.oneoffgames.com` (proxy to 127.0.0.1:8771, 64 MB body limit — see [[loom-app]]). Certbot holds certs for `web.`, `foundry.`, `n8n.`, `code.` and `loom.oneoffgames.com`, renewed by `certbot.timer`. Vault (8200), Consul and Docker also run here — it is production, so survey before changing anything.

**`/var/www/web.oneoffgames.com` is the user's public game-material library** — ~30 flat HTML pages (Blade Runner, Call of Cthulhu, Shadowdark, Daggerheart, Mothership, conventions) owned `webftp:www-data`, 644 files / 755 dirs. Its `location /` is `try_files $uri $uri/ =404` with `index index.html`, so **a new subdirectory is served with no nginx change at all** — copy files in and it is live. `/conventions` and the Directive 19 companion sit behind `auth_basic` with `/etc/nginx/.htpasswd`; everything else is public. **Anything the public must reach — an advert, a trailer, a Warhorn link — must not go under `/conventions`**, or it answers 401 to everyone without the password; put it at its own top-level path instead and leave the auth config alone. `/trailers/contingency-2027/` holds the 36 Contingency 2027 trailer web encodes, 243 MB, public — see [[contingency-2027]].

House style for that site is a green-phosphor CRT terminal: VT323 from Google Fonts, `#33ff33` on `#0a0a0a`, glowing borders, `> ` appearing on hover, blinking cursor. Match it rather than introducing a second typeface — see `index.html` for the canonical menu markup.

DNS for `oneoffgames.com` is at **Porkbun**, and the wildcard points at Porkbun parking rather than the VPS — a new subdomain needs a real A record to 85.190.246.132, added by the user, before certbot can issue.

**Foundry here is `foundryvtt13.service`** under systemd (also present but idle: `foundry.service`, `foundryvtt12.service`), data at `/root/foundrydata`, ~40 worlds. Whether a world is live is `world` in `/root/foundrydata/Config/options.json` — `null` means only the setup page is up, which is when it is safe to touch `Data/systems/*`. **The systems there are plain file copies, not git checkouts**, even where the repo's own `DEPLOY.md` documents clone + `git pull`; `ringbrp` was a month and ~103 commits stale while the repo said otherwise, and both copies carried the same version string. So check a *function* the new code introduced, never the version. Foundry builds its package list at world launch, so a deploy needs the world relaunched before it is visible. The VPS reaches `gitea.timevans.uk` over HTTPS with no credential.

MINI-S (`192.168.1.6`) **is** reachable from the Mac Mini — verified by ping 2026-10-14, ~26 ms. (This file previously said it was not, on a different-subnet assumption; that is corrected.) Use this VPS for anything that needs to be on the internet.

**Why:** the user asked to host the audio apps and the working assumption had been MINI-S; this box turned out to be the right home and was not in any memory. **How to apply:** for "host this", "put this online", or anything under `*.oneoffgames.com`, start here. Related: [[ambient-synth]], [[esper-app]], [[haunt-app]], [[grimoire-app]], [[nexus-app]], [[loom-app]], [[infra_minis_remote_access]].
