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

**Next steps**
- Load `sla-mothership` once and confirm the libWrapper banner is gone. The stored config
  is fixed and verified against its backup, but that world has not been launched since.

**Key decisions**
- 2026-09-13 — **A session can take a world down and not put it back.** Game Settings → Return
  to Setup shuts the world down and lands on the admin-password gate, which a session will not
  type; the server-side route (set `world` in `options.json`, restart `foundryvtt13`) is what a
  permission classifier blocks. Treat Return to Setup as **one-way** — ask Tim before using it,
  or be ready to leave production parked → [[2026-09]]
- 2026-09-13 — **Announce a deploy; never just do one.** `./deploy.sh --force` builds a working
  tree several sessions share and swaps the module under anyone connected. Four sessions
  deployed here in one evening, one under Tim mid-test. A clean `git status` is necessary and
  not sufficient; the other half is whether a human is on the server → [[2026-09]]
- 2026-09-13 — **EZGlide is the module that loses to Zoom/Pan Options.** Both claimed
  `Canvas.prototype._onMouseWheel` as a libWrapper `OVERRIDE` in three worlds
  (`blade-runner`, `vaesen`, `sla-mothership`). Zoom/Pan registers unconditionally and is
  the more featureful of the two, so EZGlide is disabled world-wide rather than kept on a
  client-scoped toggle that would have left every player the banner. Backups of the edited
  `settings` DBs are in `/root/foundry-backups/` → [[2026-09]]
- 2026-09-08 — This box, not [[mini-s]], is the home for anything that must be on the
  internet. MINI-S sits on a different subnet and is unreachable from the Mac Mini.

**Gotchas**
- **Foundry is `foundryvtt13.service`, not `foundry.service`** — the latter exists and is
  inactive. Data `/root/foundrydata`, port 30000 behind nginx, `foundry.oneoffgames.com`.
  `curl -s .../api/status` answers `{active, world, system, users}` without logging in, and
  is the fastest way to know which world is up.
- **Taking a world down is easy and putting one up is not.** *Return to Setup* works from
  the game, but the setup menu behind it needs the **administrator password**, which Claude
  will not type — so the server ends up parked with no world. The server-side path avoids
  the password entirely (`world` in `/root/foundrydata/Config/options.json`, then restart
  the unit), but it is a config write plus a service restart and the auto-mode classifier
  blocks both. **Do not leave a world for Tim to relaunch — get the switch authorised
  first, or ask him to do it.**
- A player seat being occupied does not mean Tim is at the keyboard; another Claude session
  logs in as **TimEvans** too, and the join list only shows that the user is taken. Check
  before concluding a human is watching, and never join as a user already connected — it
  displaces whoever holds it.
- **Module conflicts are world-scoped; a module's own settings usually are not.** Enabling
  or disabling lives in each world's `core.moduleConfiguration`, so it fixes every player at
  once; a module's `scope: "client"` toggle fixes one browser. Read all worlds' configs with
  Foundry's bundled `classic-level` (`/opt/foundryvtt/node_modules/classic-level`) — the
  active world's DB is locked, and scraping the LevelDB files by hand misparses most of them.
  Back the `settings` directory up before writing, open it read-write (an exclusive open
  fails rather than corrupts if the world is live), and preserve the whole record: the value
  is a JSON **string** inside a document with `key`/`value`/`_id`/`user`/`_stats`.
- House style for the site is a green-phosphor CRT terminal: VT323, `#33ff33` on
  `#0a0a0a`, glowing borders, `> ` on hover, blinking cursor. **Match it** rather than
  introducing a second typeface; `index.html` has the canonical menu markup.
- `/conventions` and the Directive 19 companion sit behind `auth_basic`; everything
  else is public.
- DNS for `oneoffgames.com` is at **Porkbun**, and the wildcard points at Porkbun
  parking, not the VPS. A new subdomain needs a real A record added by Tim before
  certbot can issue.

Related: [[loom]], [[mini-s]], [[gitea-timevans]]

**Gotchas**
- **The Foundry debug log records no shutdown line.** A world being parked leaves no trace at
  all — only the next `Launching World | Complete` appears, so the log cannot tell you who took
  a world down or when. Asking the other sessions is the only route.
