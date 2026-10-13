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

**Current state** — Works in WoW (Tim, 2026-10-13). Menubar app with a
**Mirrored keys…** window: only listed keys are copied (default action bar
`1`–`0 - =`), press-to-add capture, modifier-state option, live apply, persisted
in UserDefaults `uk.timevans.keycast`. Signed with Tim's Developer ID
(team 58APE87Z2X) so the Accessibility grant survives rebuilds. Window and menu
verified through System Events. Needs one more Accessibility tick after the
identity change.

**Next steps**
- Tim: re-tick Keycast in Privacy & Security > Accessibility (identity changed), confirm the icon fills, then set the key list.
- Maybe: launch at login, choose target app from the menu.

**Key decisions**
- Session-level CGEvent tap + `postToPid`, marker in `eventSourceUserData`
  to ignore own output. Mirrors only while a WoW window is frontmost.
- F12 toggle (swallowed), configurable. Mouse deliberately not mirrored.
- Proper `.app` bundle signed with the Developer ID identity (ad-hoc fallback),
  so Accessibility attaches to Keycast and survives rebuilds — ad-hoc did not,
  every rebuild lost the grant.
- Allow-list, not block-list: empty mirrors nothing, `all` mirrors everything.
  Listed modifier names mirror that modifier even with the state option off.

**Gotchas**
- `print` to a redirected stdout is block-buffered; `setvbuf` line mode added.
- `before` is a reserved word in AppleScript; `set before to …` is a syntax error.
- Test helper's first `NSRunningApplication.activate` did not take; the probe
  key went to whichever app was frontmost (WoW). Check `frontmostApplication`
  before sending a probe.
