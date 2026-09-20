---
type: project
status: active
repo: none yet — ~/Git/parley, local only
path: ~/Git/parley
updated: 2026-09-20
---

# Parley

**What it is** — Our own audio/video layer *inside* Foundry. Foundry stays the
table; Parley owns only **who hears and sees what**. A Foundry module that
replaces `CONFIG.WebRTC.clientClass`, plus a small token/staging service on the
VPS, with self-hosted **LiveKit** as the media engine.

**Where it lives** — `~/Git/parley`, local git only, **no remote yet**. Spec at
`docs/superpowers/specs/2026-09-20-parley-av-layer-design.md`, slice 1 plan at
`docs/superpowers/plans/2026-09-20-parley-slice-1-spine.md`.

**Current state** — Slice 1's code is **complete and deployed**, branch
`slice-1-spine`, 47 unit tests green, and the whole `module/` tree now matches the
box byte-for-byte (md5 parity on all 9 files; the service matches too). The
infrastructure is healthy and the repo's `deploy/` has **no drift** from either
box. Task 10 ran, and it found a wall: **Parley has never executed in a browser,
because the running Foundry server has never seen the module.** `blade-runner` was
launched 2026-09-18 19:31, the module directory first existed 2026-09-20 22:23,
and Foundry builds its package list at world launch — so `game.modules.has(
"parley")` is `false` and `CONFIG.WebRTC.clientClass.name` is still
`SimplePeerAVClient`. Verification doc:
`docs/verification/2026-09-20-slice-1-spine.md`.

**Next steps** — (1) **Tim, first and blocking:** relaunch the world (or
`systemctl restart foundryvtt13`) so Foundry rescans packages, then enable Parley,
set `serviceUrl` to `https://rtc.oneoffgames.com/parley` and paste the secret on
the GM machine only, set A/V mode to 3, **reload**. (2) Then Half B of the
verification doc — two browser profiles, real mic and camera: both seats, audio
both ways, video both ways, mute observed across, the player-side secret check,
the LiveKit participant log, and the service-down toast count. (3) Only then the
whole-branch review and `superpowers:finishing-a-development-branch`. (4) Before
slice 2: close the AVClient test gap, or accept that no client logic has ever been
executed.

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
