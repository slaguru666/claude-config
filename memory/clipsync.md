---
name: clipsync
description: "CouchDB-backed clipboard history for the user's Macs — daemon, picker, setup."
metadata: 
  node_type: memory
  type: project
  originSessionId: 3c4e91f6-6e5f-4674-b5e0-413eb9e499ff
---

`clipsync` syncs macOS clipboard history into a remote CouchDB so it's shared across Macs.

- **Mac app** (`app/` in repo): self-contained SwiftUI window app `MacMem.app` (installed in /Applications) that captures the clipboard itself AND shows searchable/clickable history. Built via SwiftPM + `app/build-app.sh` (ad-hoc signed, no Xcode; macOS 14+). Reuses `~/.config/clipsync/config.json` + Keychain; in-app Settings (⌘,) for connection + launch-at-login. On the Mini the launchd capture+prune agents were RETIRED (moved to `~/.config/clipsync/retired-agents/`) so the app is the sole capturer — don't run both. CLI `clip` picker still works as an alternate reader.
- GitHub: **private** repo `slaguru666/MacMem` (https://github.com/slaguru666/MacMem). Clean source-of-truth at `~/MacMem` (git, origin set). Per-Mac install: `git clone … && ./install.sh` then `clipsync-setup`. No secrets committed (example config uses couchdb.example.com; `.gitignore` excludes config.json/offline-queue/logs/binary).

- Remote: `couchdb.timevans.uk`, db `macmem`, user `macmem`. Password in login Keychain (service `clipsync-couchdb`), never on disk.
- Code in `~/bin`: `clip-watch` (compiled Swift `NSPasteboard` watcher, source `clip-watch.swift`), `clipsync` (stdlib-Python daemon, offline queue), `clip` (fzf picker → `pbcopy`), `clipsync-prune` (retention), `clipsync-setup` (Keychain + DB + ts index + launchd bootstrap).
- Config/lib/README in `~/.config/clipsync/`. launchd: `uk.timevans.clipsync` (KeepAlive), `uk.timevans.clipsync-prune` (daily 04:30). Logs `~/Library/Logs/clipsync.log`.
- Doc shape: `{_id:<host>-<ms>, type:clip, text, host, ts}`. Skips concealed/transient pasteboard types, length bounds, `deny_patterns` regex.
- No PyObjC in any local Python (system 3.9 / brew 3.14 / venv) → Swift used for pasteboard access.
- Per-Mac install: copy `~/bin/clip*`, `~/bin/clipsync*`, `~/.config/clipsync/`, then run `clipsync-setup`.
