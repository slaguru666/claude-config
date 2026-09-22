---
type: project
status: active
repo: github.com/slaguru666/parley (private)
path: ~/Git/parley
updated: 2026-09-22
---

# Parley

**What it is** — Our own audio/video layer *inside* Foundry. Foundry stays the
table; Parley owns only **who hears and sees what**. A Foundry module that
replaces `CONFIG.WebRTC.clientClass`, plus a small token/staging service on the
VPS, with self-hosted **LiveKit** as the media engine.

**Where it lives** — `~/Git/parley`, pushed to `github.com/slaguru666/parley`
(private). Spec `docs/superpowers/specs/2026-09-20-parley-av-layer-design.md`;
plans in `docs/superpowers/plans/`; SDD ledgers in `.superpowers/sdd/` (gitignored).

**Current state** — Slice 1 verified live 2026-09-21 (audio + video both ways,
two browsers). **Slice 2 (audio bus) code complete** on branch
`slice-2-audio-bus`, head `4a17917`, pushed, **317 tests** (from 139). Masque's
DSP is synced into `module/lib/masque/` with a drift test; voice via LiveKit's
`TrackProcessor` seam; ambience = a tap on Foundry's own `music` gainNode
published as `parley.ambience`; dock has a GM voice picker + per-listener score
volume. Every task reviewed; whole-branch review READY_WITH_FIXES, fix wave
re-reviewed ALL_ADDRESSED. Checkpoint A (agent half) passed on the live box at
`2aaa74f`: files served as JS, no CSP, graph builds in 277 ms, demon shifts
220→152 Hz. **Not merged. Not heard by a human.**

**Next steps (all Tim)** — (1) redeploy `slice-2-audio-bus` HEAD (live box runs
`2aaa74f`); (2) Task 5 steps 4–6 and Task 10 listening checklist, incl. 8a forced
re-dial and 8b unplug; (3) decide whether "Mute all peers" silences ambience;
(4) sign off the ~10-line fix for voice activation's clone going stale after
LiveKit restarts the mic itself (fails silent, not hot); (5) merge after Task 10.

**Four things it must do that nothing off the shelf can**
1. Masque processing the GM's outgoing voice, per NPC, switchable mid-sentence.
2. Ambience (Drift/Esper/Haunt/Nexus) as a *separate track* in players' ears.
3. Staging — NPC portrait instead of a webcam, private whisper, split party.
4. Guests by link with no Foundry account, plus a GM-pushed handout panel.

**Slices** — 1 spine (LiveKit + service + AVClient + dock) · 2 audio bus ·
3 staging · 4 guest links. Only slice 1 is order-forced.

**Key decisions**
- 2026-09-20 — **Own module + own service, LiveKit as the engine.** Rejected
  forking bekit's LiveKit AVClient (all four features cut across its internals
  and its React dock is not ours) and rejected writing an SFU (whisper and
  breakout *are* selective forwarding — buy that, don't build it).
- 2026-09-20 — **Masque stops needing BlackHole.** BlackHole exists only because
  Discord is a different process. Parley is a browser page, so Masque's graph
  splices straight into the published mic track. Retires a blocker parked since
  August, and makes ambience the same mechanism pointed elsewhere.
- 2026-09-20 — **Trust chain leans on Foundry, not on a secret in every browser.**
  Foundry keeps sessions in memory (`dist/server/sockets.mjs`), so no companion
  service can read a session store. Instead: Foundry has already authenticated
  everyone → the GM's browser holds the service secret in a **client-scoped**
  setting (`SETTING_SCOPES.CLIENT` → `localStorage`, never broadcast) → the
  service mints identity-bound tokens → the GM hands each player theirs over
  Foundry's own socket. The LiveKit secret never leaves the VPS.

- 2026-09-20 — **Slice 1 is not called done.** The code is deployed and the
  server half is proved live, but no human has heard audio through Parley, no
  video has been seen, and the client class override has never once been observed
  to take. The verification document says so at the top rather than burying it.
  The brief's own standard — "done when two real browsers carry real media" — is
  not met.

- 2026-09-22 — **Masque is synced, not vendored or submoduled.** Only the DSP
  import closure (19 files) is copied, with a MANIFEST of sha256s and a test that
  fails on drift. Zero-build ESM rules out a package; a submodule drags Masque's
  UI and Python sidecar into every deploy.
- 2026-09-22 — **The voice uses LiveKit's `TrackProcessor` seam, not
  `publishTrack`.** Keeps the mic publication and both gates intact. Both install
  and removal hand the publication an *enabled* track, so the gates are
  re-asserted in a `finally`; and `restartTrack` re-opens PTT, so a
  `TrackEvent.Restarted` listener re-gates (this bug predated slice 2).
- 2026-09-22 — **Ambience comes from Foundry's own audio bus**, not from
  Drift/Esper/etc. One edge off `ctx.gainNode`; `publishAux` swaps by track
  identity and binds each call to the room it was made against.

**Runs on two boxes** — the module deploys to [[oneoffgames-vps]] (the game box);
LiveKit and `parley-service` deploy to the [[media-box]]. They never talk to each
other, so this costs nothing and keeps media load off live worlds.

**Gotchas**
- `Track.Source` is a **closed enum**. Aux tracks are identified by `name`
  (`parley.ambience`, `parley.npc`), never by source — anything keying off
  source breaks the moment a GM shares a screen.
- `AccessToken.toJwt()` is **async** in `livekit-server-sdk` 2.x.
- **No certbot on the media box** — TLS is a Caddy *container*. Edit
  `/opt/nextcloud-stack/Caddyfile`, validate, reload. Back it up first.
- **TURN is UDP-only** (443 is taken), so a player on a UDP-blocked network has
  no fallback. Test for it; do not discover it mid-game.
- `ProtectSystem=strict` on the unit is fine *only* while the service writes
  nothing. Adding state means adding `StateDirectory` at the same moment.
- **Foundry has TWO A/V permission families and they are not interchangeable.**
  `canUserBroadcast*` is permission alone; `canUserShare*` is permission AND
  not-muted. Core *acquires* tracks with Broadcast and gates *transmission*
  with Share. Gate acquisition on Share and you get a self-referential latch —
  `AVSettings` derives `muted ||= !isAudioEnabled()` on every read, so no track
  is ever acquired and the camera can never start. This cost three fix rounds.
- **The game box has THREE Foundry installs** — `/opt/foundryvtt`,
  `…12`, `…13`. `find` returns the **13** tree first and it is **not** the one
  running. The live one is `/opt/foundryvtt` (14.363.0); client source is at
  `/opt/foundryvtt/client/`. Verifying against the wrong tree is silent.
- **`parley-service` lives behind a `/parley` prefix** (Caddy `handle_path`
  strips it). Health is `https://rtc.oneoffgames.com/parley/api/health`;
  the same path without the prefix returns 404 and means nothing.
- **A module's enablement and a world's A/V mode cannot be read from the shell**
  while that world is running — the active world holds an exclusive LevelDB
  lock. Read them in-browser: `game.modules.get("parley")?.active` and
  `game.webrtc.settings.world.mode`.

- **Foundry builds its package list at WORLD LAUNCH, not per page load.** Drop a
  module into `Data/modules` while a world is running and it stays invisible:
  `game.modules.has(id)` is `false`, and a full page reload does not help. Needs a
  world relaunch or a Foundry restart. Check the world's launch time against the
  module directory's mtime (`"Launching World | Loading Package Data"` in
  `Logs/debug.<date>.log`) before assuming a deploy failed.
- **The systemd unit is `foundryvtt13` but it runs `/opt/foundryvtt`** (v14.363).
  The `13` is historical. `systemctl show foundryvtt13 -p ExecStart` settles it.
- **The GM user `TimEvans` has no password**, so an agent can reach the live world
  from the join form without any credential. Worth knowing in both directions.
- **`game.logOut()` returns to the join screen; `game.shutDown()` is Return to
  Setup.** They are one letter apart in intent and worlds apart in consequence.

Related: [[masque]], [[oneoffgames-vps]], [[corkboard]], [[drift]], [[esper]]
