---
name: infra-foundry-shutdown-kills-server
description: game.shutDown() on Foundry 14.361 can take the whole server down, not just the world — recover with `open -a "Foundry Virtual Tabletop"`, then the launchWorld POST.
metadata:
  type: reference
---

`game.shutDown()` from a joined Foundry page is the way to free the LevelDB pack locks so
`bun run check` can read `packs/`. On **Foundry 14.361** it sometimes shuts down the
**entire server**, not just the world:

```
Shutting down Foundry Virtual Tabletop server
Shut-down success. Goodbye!
```

It shut only the world on five consecutive calls one evening and then killed the server on
the sixth, so the safe-looking pattern is not actually safe
([[feedback-check-the-instrument]]).

**Why:** the signal looks identical from the outside. A world shutdown leaves
`/api/status` answering `{"active":false}`; a server shutdown leaves `curl` exiting **7**,
connection refused. Polling only for `active:false` cannot tell them apart — it reads the
server-down case as "still shutting down" and then as a hang.

**How to apply:** after `game.shutDown()`, poll `curl -s http://127.0.0.1:30000/api/status`
and treat an **empty response or exit 7** as "the server is gone", not "wait longer". To
recover on the Mac, the install is the desktop app at
`/Applications/Foundry Virtual Tabletop.app`:

```bash
open -a "Foundry Virtual Tabletop"
```

then wait for `/api/status` to answer and relaunch the world with
`POST /setup {"action":"launchWorld","world":"<id>"}` (the key is `world`). The log that
tells you which of the two happened is `~/FoundryVTT/Logs/debug.YYYY-MM-DD.log`.

Related: [[ringbrp-project]]
