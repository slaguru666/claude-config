---
name: keycast
description: Swift menubar app at ~/keycast (Keycast.app) that mirrors keystrokes between two running WoW clients on the Mac; confirmed working in-game 2026-10-13
metadata:
  type: project
---

Keycast (`~/keycast/keycast.swift` + `Info.plist`, `make` builds ad-hoc-signed `Keycast.app`, bundle `uk.timevans.keycast`, menubar-only) broadcasts keystrokes from the frontmost
WoW client to every other running client via a CGEvent session tap + `postToPid`,
with a marker in `eventSourceUserData` to ignore its own output. F12 pauses. Needs
Accessibility granted to Keycast.app itself; it polls and starts the tap once granted. WoW on this Mac is Classic Beta on
`/Volumes/Mac 2TB/WoW/`, bundle id `com.blizzard.worldofwarcraft`. Built 2026-10-13.

**Why:** Tim runs two WoW clients and wants one keypress to hit both. Blizzard bans
input broadcasting; flagged, Tim's call.

**How to apply:** Tim confirmed it works in WoW with the CLI build. `postToPid` is
enough for a backgrounded WoW client. Never send a probe key
without checking `frontmostApplication` first (one went into WoW). See
[[claude-memory-vault]] project note `keycast`.
