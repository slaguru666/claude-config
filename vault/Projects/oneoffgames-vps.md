---
type: project
status: active
repo: none
path: ssh foundry (85.190.246.132)
updated: 2026-09-13
---

# One Off Games VPS

**What it is** — The Contabo box that hosts everything public: FoundryVTT, the game
material library, n8n, code-server and [[loom]]. Ubuntu 24.04, hostname `vmi2869320`,
193 GB disk. **It is production — survey before changing anything.**

**Where it lives** — `ssh foundry` reaches `85.190.246.132`. The `contabo` entry in
`~/.ssh/config` for the same IP uses user `tevans` and **does not work** — only
`root@` authenticates. The other Contabo box, `nodeserver`, rejects every key on
the Mac.

**Current state** — nginx serves five sites: `web.oneoffgames.com`, `foundry`
(FoundryVTT on 127.0.0.1:8443), `n8n.`, `code-server`, and `loom.` (proxy to
127.0.0.1:8771, 64 MB body limit). Certbot holds certs for all of them, renewed by
`certbot.timer`. Vault, Consul and Docker also run here.

`/var/www/web.oneoffgames.com` is the **public game-material library** — ~30 flat
HTML pages plus the SOUND suite ([[drift]], [[esper]], [[haunt]], [[grimoire]],
[[nexus]]). Its `location /` is `try_files $uri $uri/ =404`, so **a new subdirectory
is served with no nginx change at all** — copy files in and it is live.

**Next steps** — none outstanding.

**Key decisions**
- 2026-09-08 — This box, not [[mini-s]], is the home for anything that must be on the
  internet. MINI-S sits on a different subnet and is unreachable from the Mac Mini.

**Gotchas**
- House style for the site is a green-phosphor CRT terminal: VT323, `#33ff33` on
  `#0a0a0a`, glowing borders, `> ` on hover, blinking cursor. **Match it** rather than
  introducing a second typeface; `index.html` has the canonical menu markup.
- `/conventions` and the Directive 19 companion sit behind `auth_basic`; everything
  else is public.
- DNS for `oneoffgames.com` is at **Porkbun**, and the wildcard points at Porkbun
  parking, not the VPS. A new subdomain needs a real A record added by Tim before
  certbot can issue.

Related: [[loom]], [[mini-s]], [[gitea-timevans]]
