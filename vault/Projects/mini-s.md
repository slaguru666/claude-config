---
type: project
status: active
repo: none
path: timevans-MINI-S (192.168.1.6)
updated: 2026-09-15
---

# MINI-S

**What it is** — `timevans-MINI-S`, a **Zorin OS 18.1 Linux** box (older notes calling
it a Mac Mini are wrong). Runs a self-hosted homelab and a cloud drive, and is one of
the machines Claude Code runs on.

**Toolchain (installed 2026-09-13, all without sudo).** Claude Code had gone missing
and there was no Node at all. Rebuilt user-local:
- **Node v24.21.0** from the official nodejs.org tarball, sha256 verified, unpacked to
  `~/.local/node-v24.21.0` with `~/.local/node` as a stable symlink.
- **npm global prefix is `~/.local/npm-global`**, deliberately *not* inside the
  version-pinned Node directory, so a future Node upgrade does not take the global
  packages with it.
- **Claude Code 2.1.270**, **Codex CLI 0.154.0**, **QuickDesign 0.10.0** via `npm -g`.
- PATH is exported from **`~/.profile`**, not `~/.bashrc` — see Gotchas.

**Where it lives** — Wired `enp1s0` locked to static **192.168.1.6/24** via
NetworkManager; gateway and DNS `192.168.1.1` (Zyxel DX3301-T0, ISP Voneus). Wi-Fi
`wlo1` is a separate interface on `192.168.0.240/24`. External access: Zyxel
port-forward **WAN 2222 → 192.168.1.6:22**, so `ssh -p 2222 timevans@<public-ip>`.

**Current state**
- **SSH hardened, key-only** — password and keyboard-interactive off, no root login,
  `MaxAuthTries 3`, plus fail2ban (4 retries / 10 m → 1 h ban).
- **Docker, two Compose stacks, both LAN-only.** *homelab* at `~/docker/`: portainer
  (9443), gitea (3000 web, 222 ssh), obsidian (**https**://192.168.1.6:3002),
  stirling-pdf (8081), nextcloud (8080) with mariadb and redis. *seafile* at
  `~/docker-seafile/`: seafile on port 80. Secrets in chmod-600 `.env` files in each
  stack directory.
- **Playwright MCP** (headless Chromium) is registered at user scope, letting Claude
  view and control LAN-only web UIs including the Zyxel router.
- **Local DNS: AdGuard Home** (2026-09-15), in the *homelab* stack. Listens on
  **192.168.1.6:53** only — bound to that IP, never `0.0.0.0`, so `systemd-resolved`
  keeps its `127.0.0.53` stub and the host's own resolution is unaffected. Admin UI
  **http://192.168.1.6:3053** (user `admin`, password in `~/docker/.env`). Upstreams are
  DNS-over-TLS to Cloudflare and Quad9. Serves `*.home.timevans.uk` → 192.168.1.6 as a
  wildcard rewrite, so every service answers to a name; the port is still needed.
  MINI-S itself now resolves through it. **The rest of the LAN does not yet** — see
  Next steps.
- **Reads the memory vault** from `~/Git/claude-config/vault/` — it has no Obsidian
  vault of its own, so `sync.sh` and `install.sh` both skip the vault copy here and
  leave the repo copy intact. Pull before trusting it. See [[claude-config-sync]].

**Next steps**
- **Blocked: point both routers' DHCP at the new DNS.** Needs admin logins that are not
  known — the Zyxel wants a username *and* password and rejected `admin`; the Tenda NOVA
  is password-only and rejected the password tried. Both lock out after a few attempts,
  so stop rather than guess. Once in: Zyxel LAN DHCP → DNS `192.168.1.6`; Tenda → the
  same, or `192.168.0.240` if that address is first pinned outside the Tenda's DHCP pool.
  Single DNS entry, no secondary — clients pick a secondary arbitrarily and local names
  then fail intermittently.
- Reverse proxy so names work **without ports**. Blocked on port 80, which Seafile holds.
- Decide whether to retire Seafile or Nextcloud — two cloud drives coexist
- A DHCP reservation for the MAC is recommended to avoid lease conflicts

**Key decisions**
- **`home.timevans.uk` is the internal suffix**, split-horizon: resolved only by AdGuard
  on the LAN, nothing published at Cloudflare. Chosen over `.lan`/`.home.arpa` because a
  domain Tim owns can later carry real Let's Encrypt certs via DNS-01.
- **All names answer 192.168.1.6**, including for Wi-Fi clients, who reach it through the
  Tenda's NAT. `192.168.0.240` cannot be the universal answer — it sits behind that NAT
  and wired clients cannot reach it inbound.
- Nothing on this box is exposed to the internet except the one forwarded SSH port.
  Anything that must be public goes on [[oneoffgames-vps]] instead.

**Gotchas**
- **Correction (2026-09-13): MINI-S *is* reachable from the Mac Mini.** An older note
  said different subnets (192.168.0.x vs 192.168.1.x) made LAN SSH time out. In fact
  `ssh timevans@192.168.1.6` from the Mac at 192.168.0.30 works key-only, no password
  — ping and SSH both verified. The router routes between them.
- **The two subnets are a double-NAT, not one flat LAN** (established 2026-09-15). The
  Wi-Fi gateway `192.168.0.1` is a **Tenda NOVA** mesh whose WAN side appears on the
  Zyxel LAN as `192.168.1.238` — same MAC, one digit apart. So 192.168.0.x reaches
  192.168.1.x outbound through Tenda NAT (which is why SSH from the Mac works), but
  **not the reverse**. MINI-S straddles both, wired and Wi-Fi. Putting the Tenda into
  access-point mode would collapse this to one subnet and is the real fix.
- **`wlo1` is DHCP, and 192.168.0.240 came from the Tenda's own pool**, so it is not a
  safe bind target until it is pinned outside that pool or reserved.
- Use **HTTPS** for the containerised Obsidian on 3002, or KasmVNC's clipboard breaks.
- MCP tools load only at Claude Code startup — restart after adding a server.
- The `~/.ssh/id_ed25519` here is the outbound GitHub key, not a login key.
- Docker setup needs interactive sudo, which Claude cannot do — those steps are Tim's.
- **Ubuntu's `~/.bashrc` returns early for non-interactive shells**, so any PATH line
  added at the bottom of it is invisible to `ssh host "cmd"`, to scripts, and even to
  `bash -lc`. It works only in a real interactive terminal. Put PATH exports in
  `~/.profile` instead. This is why the Node install looked broken until it was moved.
- npm 11 blocks package postinstall scripts by default — Claude Code needs
  `npm install -g --allow-scripts=@anthropic-ai/claude-code` for its postinstall to run.
- **GitHub tokens live in `~/.config/github/tokens.env` (chmod 600), sourced from
  `~/.profile` and `~/.zshrc`** — never in an rc file directly. They were previously
  exported from `.bashrc` and `.zshrc`, both world-readable, and one was also baked
  into a stale `settings.local.json` allow-rule. Cleaned 2026-09-13; every remaining
  on-disk copy is 600. The values themselves still need rotating.
- The registered `github` MCP server still uses the deprecated
  `@modelcontextprotocol/server-github`. It connects, but `install.sh` has moved on to
  the official remote server.

Related: [[oneoffgames-vps]], [[claude-config-sync]]
