---
type: project
status: active
repo: none — not in git
path: ~/keycast
updated: 2026-10-13
---

# keycast

**What it is** — Keystroke broadcaster for running two World of Warcraft clients
at once: a key pressed in the front client is mirrored to every other running
client. One Swift file, CLI, no deps. Blizzard prohibits input broadcasting;
Tim's risk, flagged at build time.

**Where it lives** — `~/keycast/keycast.swift`, `make` builds `./keycast`.
README in the folder. Needs Accessibility for the launching app (Terminal).
WoW here is the Classic Beta at `/Volumes/Mac 2TB/WoW/.../_classic_beta_/`,
bundle id `com.blizzard.worldofwarcraft`.

**Current state** — Built 2026-10-13 and verified end to end against two
TextEdit instances (`--app com.apple.TextEdit`): one key into the front instance
landed in both. **Not yet tried in WoW itself** — whether a backgrounded WoW
client acts on a `CGEventPostToPid` key is the open question.

**Next steps**
- Tim: run `./keycast` in Terminal with both clients open, press a bound key in
  one, confirm the other acts. F12 pauses/resumes.
- If the background client ignores posted keys, next thing to try is posting to
  the client's window via AX focus or a window-level post rather than the pid.

**Key decisions**
- Session-level CGEvent tap + `postToPid`, marker in `eventSourceUserData`
  to ignore own output. Mirrors only while a WoW window is frontmost.
- F12 toggle (swallowed), configurable. Mouse deliberately not mirrored.

**Gotchas**
- `print` to a redirected stdout is block-buffered; `setvbuf` line mode added.
- Test helper's first `NSRunningApplication.activate` did not take; the probe
  key went to whichever app was frontmost (WoW). Check `frontmostApplication`
  before sending a probe.
