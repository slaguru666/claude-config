---
name: clairvoyance-mcp-needs-app
description: "The two clairvoyance MCP servers only connect while the Clairvoyance desktop app is open — \"Failed to connect\" is normal when it's closed, not a broken install"
metadata: 
  node_type: memory
  type: reference
  originSessionId: c4d6262b-e105-4e05-87bf-f2f891e7df82
  modified: 2026-08-04T20:43:45.224Z
---

`clairvoyance_terminal` and `clairvoyance_extensions` in `~/.claude.json` are stdio bridges
into the **Clairvoyance desktop app** (`/Applications/Clairvoyance.app`), not standalone
servers. Running either launcher by hand prints:

    Clairvoyance is not running. Please start the application to use the recruitment bridge.
    Clairvoyance is not running. Please start the application to use extension tools.

So `claude mcp list` showing both as "✘ Failed to connect" is **expected whenever the app is
closed** — the install is fine. Launchers live in `~/.clairvoyance/bin/`, app data in
`~/Library/Application Support/clairvoyance`, passed through as
`CLAIRVOYANCE_BASE_USER_DATA`. Start the app and they connect.

**Why:** it looks identical to a broken MCP registration, and it is tempting to "fix" it by
re-registering or deleting the servers. Nothing is wrong with the config.

**How to apply:** before debugging these two, check `pgrep -i clairvoyance`. Empty means the
app is just closed. Note `ls -d /Applications/*[Cc]lairvoyance*` can *look* like the app is
missing if you glob several paths on one zsh line — a no-match on any one of them aborts the
whole command. Use `mdfind` or check the single path.

Related: [[claude-config-sync-gotchas]].
