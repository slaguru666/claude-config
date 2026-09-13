---
type: project
status: complete
repo: slaguru666/MacMem (private)
path: ~/MacMem
updated: 2026-09-13
---

# clipsync / MacMem

**What it is** — Clipboard history (and imported notes) synced into a remote CouchDB
so it is shared across Tim's Macs. A SwiftUI menu-bar app plus CLI tools plus an MCP
server that lets an LLM read the history.

**Where it lives** — Clean source at `~/MacMem` → private `slaguru666/MacMem`. CLI in
`~/bin`: `clip-watch`, `clipsync`, `clip`, `clipsync-prune`, `clipsync-setup`. Config
in `~/.config/clipsync/`. Remote: `couchdb.timevans.uk`, db `macmem` — password lives
in the login Keychain, never on disk. Per-Mac install: clone, `./install.sh`, then
`clipsync-setup`.

**Current state** — Complete and in use. Text, images and files ≤50 MB; AES-256-GCM
encryption with the key derived from a passphrase and cached in the Keychain; tags,
date ranges and full-text search; auto-paste and ⌘1–9; pin/favourite; per-device
filter and sync indicator; MCP server (read and add only, no delete). 758 Apple Notes
and the Obsidian vault imported as `type:note` docs.

**Next steps** — none.

**Key decisions**
- **Encrypt everything.** The cost is that search must happen client-side —
  ciphertext cannot be server-indexed. Accepted. A lost passphrase is unrecoverable.
- On the Mini the launchd capture agents were retired so the app is the sole
  capturer. Don't run both.
- No PyObjC in any local Python, so pasteboard access is Swift.

**Gotchas**
- **Never bulk-delete by a broad selector.** A test cleanup on `source:obsidian`
  deleted ~20 of Tim's real notes. Re-import restored them only because ids are stable.
- CouchDB Mango `$ne: true` and `$not` do **not** match docs where the field is
  absent — prune and clear silently deleted nothing until rewritten with `$or`/`$exists`.
- Apple Notes: fetch names in bulk, bodies per-note with `try`, plus a watchdog. A
  single locked note fails collection access with **-1741**.

Related: [[mini-s]], [[local-llm-stack]]
