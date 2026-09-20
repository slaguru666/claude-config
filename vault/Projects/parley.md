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

**Current state** — Design and slice 1 plan written and committed 2026-09-20.
**No code yet.** Blocked on Tim: two Porkbun A records.

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

**Gotchas**
- `Track.Source` is a **closed enum**. Aux tracks are identified by `name`
  (`parley.ambience`, `parley.npc`), never by source — anything keying off
  source breaks the moment a GM shares a screen.
- `AccessToken.toJwt()` is **async** in `livekit-server-sdk` 2.x.
- Needs A records for `rtc.` and `turn.oneoffgames.com` at Porkbun before
  certbot can issue — the wildcard points at Porkbun parking.
- `ProtectSystem=strict` on the unit is fine *only* while the service writes
  nothing. Adding state means adding `StateDirectory` at the same moment.

Related: [[masque]], [[oneoffgames-vps]], [[corkboard]], [[drift]], [[esper]]
