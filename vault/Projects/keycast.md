---
type: project
status: active
repo: none — not in git
path: ~/keycast
updated: 2026-10-13
---

# keycast

**What it is** — Menubar app that broadcasts keystrokes between two running
World of Warcraft clients: a key pressed in the front client is mirrored to every
other running client. One Swift file, no deps. Blizzard prohibits input broadcasting;
Tim's risk, flagged at build time.

**Where it lives** — `~/keycast/keycast.swift` + `Info.plist`; `make` builds
and ad-hoc signs `Keycast.app` (bundle `uk.timevans.keycast`, LSUIElement).
`open Keycast.app`, `make stop`. README in the folder.
WoW here is the Classic Beta at `/Volumes/Mac 2TB/WoW/.../_classic_beta_/`,
bundle id `com.blizzard.worldofwarcraft`.

**Current state** — Works in WoW (Tim confirmed 2026-10-13). Converted to a
menubar app the same day: status icon, menu with state + client pids,
Pause/Resume, Accessibility shortcut, Quit. Verified running via System Events.
Waiting on Tim to grant Accessibility to Keycast.app (new identity); the app
polls and starts the tap by itself once granted.

**Next steps**
- Tim: tick Keycast in Privacy & Security > Accessibility, confirm the icon fills.
- Maybe: launch at login, choose target app from the menu.

**Key decisions**
- Session-level CGEvent tap + `postToPid`, marker in `eventSourceUserData`
  to ignore own output. Mirrors only while a WoW window is frontmost.
- F12 toggle (swallowed), configurable. Mouse deliberately not mirrored.
- Proper `.app` bundle, ad-hoc signed with a fixed identifier, so Accessibility
  attaches to Keycast rather than Terminal and survives rebuilds.

**Gotchas**
- `print` to a redirected stdout is block-buffered; `setvbuf` line mode added.
- Test helper's first `NSRunningApplication.activate` did not take; the probe
  key went to whichever app was frontmost (WoW). Check `frontmostApplication`
  before sending a probe.
