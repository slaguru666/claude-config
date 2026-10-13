---
name: keycast
description: Swift CLI at ~/keycast that mirrors keystrokes between two running WoW clients on the Mac; verified with TextEdit, not yet in-game
metadata:
  type: project
---

keycast (`~/keycast/keycast.swift`, `make`) broadcasts keystrokes from the frontmost
WoW client to every other running client via a CGEvent session tap + `postToPid`,
with a marker in `eventSourceUserData` to ignore its own output. F12 pauses. Needs
Accessibility for the launching app. WoW on this Mac is Classic Beta on
`/Volumes/Mac 2TB/WoW/`, bundle id `com.blizzard.worldofwarcraft`. Built 2026-10-13.

**Why:** Tim runs two WoW clients and wants one keypress to hit both. Blizzard bans
input broadcasting; flagged, Tim's call.

**How to apply:** Open question is whether a backgrounded WoW client acts on a
posted key; TextEdit does. If not, try a window-level post. Never send a probe key
without checking `frontmostApplication` first (one went into WoW). See
[[claude-memory-vault]] project note `keycast`.
