---
type: project
status: active
repo: none
path: timevans-MINI-S (192.168.1.6)
updated: 2026-09-13
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
- **Reads the memory vault** from `~/Git/claude-config/vault/` — it has no Obsidian
  vault of its own, so `sync.sh` and `install.sh` both skip the vault copy here and
  leave the repo copy intact. Pull before trusting it. See [[claude-config-sync]].

**Next steps**
- Decide whether to retire Seafile or Nextcloud — two cloud drives coexist
- A DHCP reservation for the MAC is recommended to avoid lease conflicts

**Key decisions**
- Nothing on this box is exposed to the internet except the one forwarded SSH port.
  Anything that must be public goes on [[oneoffgames-vps]] instead.

**Gotchas**
- **Correction (2026-09-13): MINI-S *is* reachable from the Mac Mini.** An older note
  said different subnets (192.168.0.x vs 192.168.1.x) made LAN SSH time out. In fact
  `ssh timevans@192.168.1.6` from the Mac at 192.168.0.30 works key-only, no password
  — ping and SSH both verified. The router routes between them.
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
