---
name: corkboard-module
description: "Corkboard — Tim's Foundry VTT investigation-board module at ~/Git/corkboard; architecture, trust model, and the deploy path that keeps the live world up."
metadata: 
  node_type: memory
  type: project
  originSessionId: 1c117e42-e3c4-45cf-af54-8456a315b23b
  modified: 2026-09-13T17:10:00.000Z
---

Corkboard is a standalone Foundry VTT v14 module at `~/Git/corkboard`
(github slaguru666/corkboard), built 2026-09-11/12. A board is a
**JournalEntryPage of subtype `corkboard.board`** — there is no sidebar tab and
no scene-control button, so nothing is visible until a board page is created.
That surprised Tim on first use; lead with it when explaining the module.

**Architecture worth not rediscovering:** `sheet.mjs` is the only writer, via
`#commit`; `board-ops.mjs` holds pure functions returning flat Foundry update
payloads; `visibility.mjs` is the single gate where a player's board differs
from the GM's. The module deliberately opens **no custom socket** — features
that need to reach other clients (the spotlight) are stored as document state
so Foundry's own broadcast carries them. Keep that property.

**Trust model, decided and documented:** player edit grants real Foundry OWNER
on the page, because Foundry checks ownership server-side. The in-sheet rules
and the delete guard are accident guards, not a boundary — a player at a console
can write anything to that page. Hidden cards and GM notes are client-side
filtering only. Tim accepted this for in-person convention play; do not describe
these as secure.

**Deploy:** `./deploy.sh --force`. Corkboard ships no compendium packs, so
deploying over the running server is safe — unlike the afterimage module, whose
LevelDB packs require returning the world to Setup first. Reload the world to
pick up new code.

**Verifying a gesture against a live server** is a technique this module needed
and the harness has sharp edges, all written up in
`docs/verification/2026-09-13-rebase-live.md`. Read that before driving the
board with synthetic events — the four that cost real time:

- The **content subtree is replaced on every render**, so a viewport reference
  looked up once and reused is detached after the first commit. Events sent to
  it reach nothing, and it reports as *"the gesture declined to claim"* rather
  than as an error. Re-query for every event.
- `setPointerCapture` throws for a fabricated pointer id; stub it and restore it
  after. Nothing depends on capture for recovery.
- Anything using `document.elementFromPoint` (string release, card hit tests)
  needs the point inside the **sheet window**, which keeps the size it opened at
  — enlarging the browser pane does not enlarge it. `app.setPosition` does.
- Player-only behaviour is reachable without a second login: the board's own
  **Player preview** button puts a GM's sheet into player mode.

Toolbar controls (pen, shape tools, player preview) exist only in
`board-edit.hbs` — rendering the *parent journal sheet* embeds the page read-only
through `board-view.hbs`, where no shape gesture is ever claimed. Open the
page's own sheet.

**There is now a second host.** The same repo carries a standalone browser app
(`src/app/`, `app/index.html`, `styles/app.css`) with no Foundry at all, built on
the `BoardHost` seam in `controller.mjs` — same renderer, same stylesheet, same
gestures, same arithmetic. Run it with `npx http-server . -p 8791 -c-1`. It
stores commits in IndexedDB and arbitrates multi-tab writing with
**`navigator.locks`**, not a BroadcastChannel election: a post from `pagehide` is
queued as a task and the document dies before it runs, so a closed tab never
hands over. Anything shared may gain parameters but must keep `sheet.mjs`
working. `build.mjs` excludes the app from the shipped module.

Reviews from both Codex and an internal pass live in `docs/reviews/` with ranked
feature proposals. Related: [[afterimage-scenario]], [[infra-oneoffgames-vps]],
[[feedback-codex-review-loop]].

**Tim tests on the LOCAL Foundry, not only the VPS.** `~/FoundryVTT/Data/modules/corkboard`
(dataPath `~/FoundryVTT`, app on port 30000). `./deploy.sh --force` only reaches the VPS, so
deploy to both: `npm run build && rsync -a --delete dist/ ~/FoundryVTT/Data/modules/corkboard/`
then `diff -rq` to verify. Several hours of fixes never reached him because they went to the
VPS alone.

**Detaching a sheet into its own browser window:** Foundry adopts the element on a semaphore
inside `_insertElement`, so the move happens AFTER `_onRender`. Anything bound during a render
is bound to the window the board is leaving. Rebind in `_onDetach`/`_onAttach` (core's empty
stubs, called with both documents), and take frames/timers from
`element.ownerDocument.defaultView` — a backgrounded main window throttles rAF.

**`styles/corkboard.css` and the app's import graph are service-worker shell files.** Any edit,
comment included, turns `test/app-shell.test.mjs` red until `node tools/build-app-shell.mjs`
is re-run. That is the test working.

**Phone apps (built 2026-09-24, merged to master 2026-09-25 at 44006f0).** `mobile/` is Capacitor 8
around the standalone app — same files, no port. `src/app/platform.mjs` is the only
place native differs from web; keep the web path byte-for-byte the old behaviour.
Gotchas that cost real time and are NOT obvious:
- Android's local server serves the root `index.html` for EVERY navigation, so the
  root page must be the app page (build-mobile rewrites paths); a redirect loops.
- Capacitor's fetch bridge UTF-8-decodes a `Uint8Array` body — send binary as a
  `File` (`requestBody`). Proved with an echo server: raw body doubled in size.
- Android picker greys out `.corkboard` (no MIME) — no accept filter on Android.
- Cold-start "open with" on Android arrives twice (launch URL + appUrlOpen).
- iOS build on this Mac: `DEVELOPER_DIR=/Applications/Xcode-beta.app/...` (Xcode not
  first-launched; `xcode-select` needs sudo) and `-packageAuthorizationProvider netrc`
  or SwiftPM hangs on a keychain prompt. Drive the sim's WKWebView via
  `ios_webkit_debug_proxy` (brew); Android's WebView via adb-forwarded CDP.
- Tim's iPhone Air (UDID 00008150-000915302288401C) is registered on team 58APE87Z2X;
  device build: add `-destination id=<udid> -allowProvisioningUpdates DEVELOPMENT_TEAM=58APE87Z2X`,
  install with `xcrun devicectl device install app`. iwdp can't reach iOS 17+ devices;
  drive the real phone with an XCUITest runner (xcodegen project, `XCUIApplication(bundleIdentifier:)`)
  — real taps; typeText into the WebView fails; `aria-pressed` buttons are toggles (type 40).
- Tablets (branch `tablets`, 2026-09-25): `keep-centre.mjs` keeps the board's middle through
  rotation/keyboard resizes (held while a non-pan gesture is live); toolbar is one scrolling row
  up to 1024px. Android tablet AVD `Medium_Tablet_API_36.1` (hand-made copy of the phone AVD, no
  cmdline-tools installed). This Xcode beta has no Simulator.app, so the iPad sim can't be rotated.
  Over CDP use `adb shell input keyevent KEYCODE_ENTER`, not `Input.dispatchKeyEvent` — the latter
  leaves Android's keyboard open.
Verification note: `docs/verification/2026-09-24-mobile-apps.md`.
