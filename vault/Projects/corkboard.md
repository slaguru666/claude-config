---
type: project
status: active
repo: slaguru666/corkboard
path: ~/Git/corkboard
updated: 2026-09-14
---

# Corkboard

**What it is** — A standalone Foundry VTT v14 investigation-board module. A board
is a JournalEntryPage of subtype `corkboard.board` — there is **no sidebar tab and
no scene-control button**, so nothing is visible until a board page is created.
That surprises people on first use; lead with it.

**Where it lives** — `~/Git/corkboard`, remote `slaguru666/corkboard`. Deploy with
`./deploy.sh --force`, then reload the world. Reviews in `docs/reviews/`.

**Current state** — Phase 3 gesture extraction complete, and **the standalone app
now runs** (2026-09-13). `app/index.html` is a browser page with no Foundry that
creates, names, opens and deletes boards; adds cards and zones; drags, resizes,
ties string, draws and rubs out; and reopens a board with everything still there.
Slice 2 adds a **note body you can write** and slice 3 **pictures**: a card panel
with a title, a `contenteditable` rich-text editor, a picture and a GM note, plus
a Photo button on the toolbar. It is not a second corkboard —
the renderer, stylesheet, gestures and arithmetic are the module's own files,
reached through the `BoardHost` seam.

**Phase 4 transfer is done** (2026-09-13). A board and its pictures travel as one
`.corkboard` file — a dependency-free zip holding `board.json` and
`assets/<sha256>.<ext>`. Reading hashes every picture against the id the manifest
declared, so a tampered bundle cannot slip bytes under an id another board trusts.
Import into the app is always a fork (contracts §4); import into Foundry replaces
the page, because a page *is* the board. Both hosts translate at the seam: a
Foundry path becomes a digest on the way out and a server path on the way back.
**The app works with the wifi off** — a generated service worker precaches a
shell derived from the import graph (never a hand-kept list), a content hash in
`sw.js` is what makes the browser notice a deploy, and an update installs beside
the running one and waits until the person presses Reload. A cached shell meeting
newer boards gets its own screen, not the "cannot store anything" one, because
that message invites clearing site data. Installable: manifest plus icons drawn
by `tools/app-icons.mjs`. **Phase 4 is complete.** 4.5 was mostly verification: two-finger pinch,
pointer-id filtering and `pointercancel` were already built in phase 3 and had
never run under a finger. They do now — pinch scales exactly by the finger ratio,
a second finger returns a dragged card and writes nothing, and handles measure
45–47px under `pointer: coarse`. Added the iOS callout and tap-highlight
suppression and a scroll-shadow on the narrow toolbar. 1292 tests.

**Players can be given a read-only copy** (2026-09-13). `./publish.sh
<board.corkboard> [slug]` sanitises and rsyncs; players open
`#view/<slug>`. NOT the sync engine of phases 5-6 — there are no writes, which
is where all that cost lives. The filter runs on the GM's machine before the
file exists, so a hidden card is **absent** from the published bytes rather than
undrawn (stronger than Foundry, where `visibility.mjs` documents the opposite),
and a picture reachable only from a hidden card is never written into the zip.
Freshness is a conditional GET on nginx's own ETag every 15s; an update keeps
each viewer's pan and zoom. No accounts, no index, no password — the link is the
protection, and the page says so.

**The app publishes on its own** (2026-09-13). Publish button per shelf row;
needs `./install-publish-server.sh` once (systemd unit `corkboard-publish` on
127.0.0.1:8788, nginx proxies `/corkboard/publish/`, token in
`/etc/corkboard-publish.env`, 600 root:root — **value not recorded anywhere but
there**). The filter runs **in the browser** before upload, so the server never
receives a secret; the server refuses a board that plainly was not filtered
(`looksSanitised`), which catches the app being wrong rather than replacing the
filter. No unpublish — still `ssh` + `rm`.

**The app is deployed and live** (2026-09-13) at
**https://web.oneoffgames.com/corkboard/app/** — `./deploy-app.sh` rsyncs `app`,
`src`, `styles`, `assets` to the web root; there is no build output, the browser
loads the repo's own files. First deploy was a **dead page**: nginx has no
`.mjs` MIME entry, so every module came back `application/octet-stream` and was
refused under strict MIME checking. Fixed by `location` rules on the VPS.
Head `c8b3ced`, pushed.

New: `src/data/apply.mjs` (the trust boundary for flat `system.*` payloads),
`src/data/sanitize.mjs` (the one allow-list sanitiser, both hosts),
`src/data/assets.mjs` + `src/app/asset-store.mjs` (content-addressed pictures),
`src/app/{commits,store,idb,writer-lock,host,board-view,shelf,selection,notify,
icons,main,editor,card-editor,bundle-io}.mjs`, `styles/app.css`.
`src/data/{zip,bundle}.mjs` are the container and the format; `src/app/bundle-io.mjs`
and `src/board/bundle-io.mjs` are the same format against each host's storage.
`src/board/gesture-order.mjs` holds the one copy of the arbitration order, and
`view-gestures.mjs` the pan — both hosts go through them. `build.mjs` keeps
`src/app` out of the module's dist.

Run it: `npx http-server . -p 8791 -c-1`, open `/app/index.html`.

Codex rounds 18–23, all on the shape minimum. The same defect kept reappearing
because each guard measured its own convenient proxy: the box diagonal, then the
rounded box, then fractions that can exceed 1. `lineLength()` is now the single
definition, and creation holds a line's ends inside its box. Round 23 also fixed
a pre-existing undo that could restore half an old line against half a new one
and leave it with no length. Reviews in `docs/reviews/` (18–23).

**Phase 5 designed, not built** (2026-09-14). A web-based shared Corkboard with
logins, at **corkboard.oneoffgames.com** (DNS live, 85.190.246.132 — the same box
as web/foundry.oneoffgames.com; `corkboard.timevans.uk` is a *different* machine).
Server-primary: Postgres holds the boards, the browser is a view, a third
`BoardHost` in `src/web/host.mjs` sits beside `sheet.mjs` and `src/app/host.mjs`
so the renderer, gestures and board schema are unchanged. Accounts are ones you
create (argon2id, table-backed session cookies, no email); per-board
owner/editor/viewer. Live updates by **SSE, not WebSockets** — no dependency, and
the whole filtered board is pushed per recipient rather than the ops. Seven
slices; **slice 1 gets logged into before 2–7 are committed to.** Design:
`docs/superpowers/specs/2026-09-14-shared-corkboard-design.md` (commit 0215bab).
Neither the Foundry module, the standalone app nor the published board changes.

**Next steps**
- **Phase 5 slice 1** — service, Postgres, accounts, sessions, admin page; certbot
  for corkboard.oneoffgames.com. Awaiting Tim's review of the design, then a plan
- **The iPad is the only thing phase 4 is waiting on.** Add to Home Screen, standalone
  display, `navigator.storage.persist()`, and whether Files round-trips a
  `.corkboard` bundle. Contracts §5 and §9 are provisional until it answers
- Run `npm run build:app` after changing anything the app loads; a test fails if
  you forget
- Explicit v1 migration, and the sanitised share copy, still owed from phase 4
- Phases 5–6: sync proof, opt-in sharing
- iPad storage durability testing (contracts §5). The URL to test is now the real
  app, **https://web.oneoffgames.com/corkboard/app/** — not the old
  `corkboard-spike/`, which is the phase-1 spike and a different thing
- Deferred from review 21: require `shape` whenever `setShapeBox` is given size
  keys (today it silently falls back to a zero floor); `reshape` previews nothing,
  so the clamp is invisible until release

**Key decisions**
- 2026-09-14 — **The shared system gets its own subdomain.** A session cookie is
  scoped to a host, and `web.oneoffgames.com` already carries the public game
  site, the standalone app and the published folder. One certbot run buys the
  cookie an origin that is only Corkboard's. → [[2026-09]]
- 2026-09-14 — **The server pushes the whole filtered board, per recipient, not
  the ops.** Filtering ops looks cheaper until a card's `hidden` flips: a viewer
  who could not see it needs a *create* and one who could needs a *delete*, and
  every leak this design prevents would live in that translation. Kilobytes are
  the right price. → [[2026-09]]
- 2026-09-14 — **SSE, not WebSockets.** Server→client is the only direction that
  needs a push; writes go by POST. `EventSource` reconnects itself and nginx
  needs one line. A WebSocket library would be this project's first runtime
  dependency, to do less. → [[2026-09]]
- 2026-09-13 — **Sanitise on the client, verify on the server.** A server that
  sanitises is a server that first receives the secrets, so the filter runs in
  the browser and the endpoint only ever sees a filtered board. The server's
  own check cannot know what was removed but can refuse one that plainly was
  not filtered — hidden entries, or a `gmNote` key still present. Defence in
  depth that costs five lines and converts a client bug from a leak into a
  failed publish. → [[2026-09]]
- 2026-09-13 — **Never be safe only because of the reverse proxy.** The publish
  server took the last path segment as the slug, so `/anything/at/all/myslug`
  published — and `/corkboard/publish/..` normalises to `/corkboard/`, whose
  last segment is a valid slug. nginx proxies one location, but the service has
  to be safe run directly.
- 2026-09-13 — **Verify a secret-bearing path without holding the secret.** Read
  a token into a shell variable, never into the transcript; where a literal is
  unavoidable (a browser), set a throwaway, verify, then rotate to a fresh
  server-generated one. The live token has never been in a session.
- 2026-09-13 — **A fake cannot test a `this` binding.** The published board's
  poller defaulted to `{ set: setInterval }` — bare references — so
  `timers.set(...)` passed `this === timers` and the browser threw *Illegal
  invocation*. The board drew once and never updated again, which is the one
  thing the feature is for. Every unit test injected fakes, and a fake is a plain
  function that does not care what `this` is; only a deployed page found it.
  Third time this repo has been bitten by a fake answering whatever it was
  taught. Wrap globals, never reference them into an object. → [[2026-09]]
- 2026-09-13 — **A security boundary belongs in one pure function over bytes.**
  The published copy is sanitised by a script, not by a publish action in each
  host — two implementations of one boundary in the two places hardest to test
  (one needs Foundry, one needs IndexedDB). Neither host changed to gain the
  feature.
- 2026-09-13 — **Assert absence against the raw file, never the render.** The
  publish tests read every bundle twice: as the viewer will, and as raw zip
  entries plus raw `board.json` bytes. A filter can drop a card from the board
  object and leave its photograph in the archive, and only the second reading
  sees it. `unused` reporting a stray entry is not the same as removing it.
- 2026-09-13 — **Hold L to point; it is a Foundry keybinding, not a key listener.**
  `game.keybindings.register` makes it findable in Configure Controls, rebindable,
  and lets Foundry decide when somebody is typing. A feature reachable only by a
  key nobody is told about is not shipped. → [[2026-09]]
- 2026-09-13 — **A sheet detached into its own window is a second document, and
  the move happens late.** Foundry adopts the element on a semaphore, after
  `_onRender`, so anything bound during a render names the window being left.
  Rebind in `_onDetach`/`_onAttach`; take frames and timers from the element's own
  view, because a backgrounded main window throttles rAF. → [[2026-09]]
- 2026-09-13 — **A laser pointer is not board state, so it gets the only socket.**
  Ephemeral, no undo, never written to the document; board state still travels as
  document updates. → [[2026-09]]
- 2026-09-13 — **A static host is not a static host.** nginx knows neither `.mjs`
  nor `.webmanifest`, and a module served as `application/octet-stream` is
  refused outright — a blank page, one console error, nothing else wrong. This
  is the entire difference between `npx http-server` and the real host, and only
  a deploy finds it. `default_type` in a `location`, never a `types { }` block:
  a `types` block *replaces* the inherited MIME map and would take the CSS and
  images down with it. → [[2026-09]]
- 2026-09-13 — **A browser caches a wrong Content-Type.** After the MIME fix the
  page still failed twice with the old error; nginx sends no `Cache-Control`, so
  heuristic freshness served the stale response. Suspect this before suspecting
  the server when a deploy "did not take". `fetch(url, {cache: "reload"})` then
  navigate.
- 2026-09-13 — **A backup beside a config is a second config.**
  `sites-enabled` is a wildcard include, so `web.oneoffgames.com.pre-corkboard.*`
  parsed as another server block and `nginx -t` reported conflicting server
  names. Backups go in `/root/nginx-backups/`.
- 2026-09-13 — **`git add -A` has now swept this session's uncommitted work into
  three unrelated commits** (bd2517e, 1e73377). A revert of any of them would
  silently take a change its message never mentions. Named paths only.
- 2026-09-13 — **Never chain a commit off a piped test run.** `vitest | grep &&
  git commit` reads grep's exit status, so a red suite commits anyway.
- 2026-09-13 — **The Undo double-fire was not real, and the symptom said so before any
  measurement was taken.** One click gives one handler run and one toast, and every
  `[data-action]` element carries exactly one listener across every render path. Per-render
  binding is safe *by construction* here and worth knowing rather than re-deriving: every
  `addEventListener` in `sheet.mjs` targets a node inside the part subtree, Foundry replaces a
  `root: true` part's children on every render (`replaceChildren`), and
  `_configureRenderParts` ignores `options.parts`, so no partial render can skip the
  replacement. The report also contradicted itself: both refusal branches null `#undo` before
  notifying, so two listeners could only ever have produced *one* warning and then "There is
  nothing to undo". **Do not re-chase this** → [[2026-09]]
- 2026-09-13 — **A precache list is derived, never written.** A stale one is
  invisible until the network is gone, on the device that cannot then be fixed.
  The walk follows the real import graph and refuses a dynamic import it cannot
  follow; a test regenerates `app/sw.js` and compares.
- 2026-09-13 — **The shell version lives inside `sw.js`.** The browser decides
  an update exists by diffing that file's bytes, so a version anywhere else
  leaves a module-only deploy byte-identical and permanently unnoticed.
- 2026-09-13 — **A new version waits; it never reloads by itself.** A note being
  typed is not in IndexedDB yet. `skipWaiting` runs only on a button press — the
  sole exception being the out-of-date screen, which has nothing to lose.
- 2026-09-13 — **A stale shell meeting newer data gets its own message.**
  Telling somebody their boards are unreadable invites clearing site data, which
  is exactly what loses them.
- 2026-09-13 — **A rule that cannot be tested where it lives should move, not gain a
  comment.** The acknowledge guard — do not clear the new-card marks while a gesture
  holds an element, because a redraw replaces the cards and empties the SVG layers
  under an in-flight stroke — arrived as a closure inside a private method of
  `sheet.mjs`, which imports Foundry and has no coverage. It is now
  `shouldAcknowledge({fresh, active})` in `controller.mjs`: pure, Foundry-free, and
  the reasoning travels with the rule instead of being copied beside it. The seven
  cases include the half that is easy to miss — deferring must not lose the marks, so
  the next look after the gesture ends still clears them. The rule names it asserts
  are the ones `#gestureRules()` returns, deliberately, so a rename there fails here.
  `9869072` → [[2026-09]]
- 2026-09-13 — **A bundle's pictures are checked against their own names.** An
  asset id is the SHA-256 of the bytes, so reading one is arithmetic, not trust.
  Without the check a file somebody sent could put bytes of its choosing under an
  id an unrelated board already uses, and that board would quietly show the new
  picture. Applies to both hosts.
- 2026-09-13 — **Blobs are written durably before the board that names them.**
  Interrupted that way round, the worst case is bytes nothing points at, which a
  sweep collects. The other way round the card is permanently broken and nothing
  can tell that from a picture the sender never had. Not a preference.
- 2026-09-13 — **"Missing" is asked of the device, never of the file.** Content
  addressing makes them different questions: a picture a bundle left out may
  already be here under the same id. Reporting the file's gap told people to
  expect a placeholder next to a card that drew perfectly.
- 2026-09-13 — **Import into Foundry replaces; import into the app forks.** There
  is no shelf in Foundry to fork onto — the page is the board — and contracts §4
  only asks for a fork where a board has an identity of its own.
- 2026-09-13 — **Foundry's uuid-scoped upload rewrites the filename**, so a
  content-addressed name does not stop a second import writing the picture again.
  Kept anyway: uploading to a path of our own leaves files the world never
  manages. The duplicate costs disk; an orphan costs forever.
- 2026-09-13 — **Coupled fields must be *watched* together, not judged by a rule.**
  Three successive undo guards each refused something safe, because `undoConflict`
  cannot tell a genuine restore from a recombination. The guard is gone; the witness
  is wide (`w`, `h`, `a`, `b` move as one) and is now read on **both sides** of the
  update, closing the commit-window race Codex found in review 27. → [[2026-09]]
- 2026-09-13 — **Review 26: no production defect, one regression I wrote blind.**
  Codex cleared `isStroke`, confirmed no creation path was missed, and confirmed
  the branch I deleted was unreachable. It also caught that every renderer
  fixture used exactly two points, so two mutants lived through my own twelve.
  The one that matters: I recorded that a ghost stroke was clearable only by
  *Wipe ink*, and that is **false in Foundry** — `sheet.mjs` gives `.cb-stroke`
  `tabindex="0"` with the pen in hand and Delete erases the focused stroke, and
  a 0x0 box does **not** leave an element out of the tab order (measured in a
  browser, not assumed). So the renderer skip closed the only selective removal
  a legacy ghost had. **Resolved: the skip is dropped** — the renderer draws
  every stroke again and `isStroke` guards creation only, which was the whole
  decision. Locked in by test, not comment: re-adding the skip fails loudly.
  → [[2026-09]]
- 2026-09-13 — **A picture is content-addressed and resolved at draw time.** The
  board stores `asset:<sha256>`; the loadable URL is made by a resolver the
  renderer is handed and revoked when the screen goes, because a `blob:` URL is
  valid only for the document that made it. Reclaiming is by scan over snapshots
  AND commits — an id only an old commit names is bytes a replay will ask for.
- 2026-09-13 — **A tap with the pen leaves no mark.** A press with no travel
  stored a one-point stroke; a `<polyline>` with one point has no subpath, so it
  painted nothing, measured 0x0 and took its hit thread with it — unseeable,
  unselectable, clearable only by *Wipe ink*. Refusing beat drawing it: a tap is
  how you reach a mark with the pen still in hand, so a tap that painted would
  stamp ink on the thing you were reaching for, and the highlighter's `butt`
  linecap paints nothing for a zero-length subpath anyway. One predicate,
  `isStroke`, answers for both the write path and the renderer. The comment that
  argued for the dot sat on an **unreachable** branch → [[2026-09]]
- 2026-09-13 — **Widen the witness, do not guess a rule.** Three attempts to have
  `undoConflict` judge whether an undo would ruin a line each refused safe undos,
  because from there you cannot tell restoring a real past state from combining
  halves that never coexisted. Coupled fields must be *watched* together
  (`readPlaces`), and then no rule is needed → [[2026-09]]
- 2026-09-13 — **A note body is decided in one place, in two tiers.** `ingest`
  says what may be STORED, `display` says what is DRAWN, and they are different
  sets on purpose: a table written in Foundry is legal but undrawn, so it
  survives a trip through the app instead of being quietly deleted by it.
- 2026-09-13 — **The sanitiser tokenises and rebuilds; it never strips.** Output
  is written fresh from the parse with everything escaped, so markup it did not
  understand comes out as text. Stripping hands the browser bytes nobody parsed.
- 2026-09-13 — **The multi-tab lock is `navigator.locks`, not BroadcastChannel**,
  amending contracts §5 in place. A BroadcastChannel post from `pagehide` is
  queued as a task and the document dies before it runs, so closing the tab
  holding a board left the other read-only for good. Every decision in §5 stands;
  only the mechanism moved → [[2026-09]]
- 2026-09-13 — **The app shows a change only after it is stored.** A commit
  computes the next board, writes it, and then draws it. Showing first is faster
  by one IndexedDB round trip and lies whenever the write fails → [[2026-09]]
- 2026-09-13 — **Writes are declared as operation lists, never handed-out
  transactions.** Makes "the board and its commit land together" structural, and
  sidesteps a transaction held across an `await` being closed by the browser
- 2026-09-13 — **The arbitration order lives in one place** (`gesture-order.mjs`).
  Two array literals in two hosts agree only while somebody remembers they must
- 2026-09-13 — **A broken module has no data model, so nothing is cleaned.** I
  concluded Foundry does not enforce a TypedObjectField member's min/max after
  probing a module whose imports were 404ing from a partial deploy: the subtype
  was never registered. Missing schema defaults are the tell. Foundry and
  `validateBoard` agree; deploy the build, never the files you touched → [[2026-09]]
- 2026-09-13 — **One definition of a line's length**, asked by creation and
  resizing alike (`lineLength` in `board-ops.mjs`). Two rounds of review found
  the same defect twice because the two guards each measured their own
  convenient proxy → [[2026-09]]
- 2026-09-13 — **A line's minimum is measured between its ends, not across its
  box.** The box is only the line's bounding box at creation; after a nudge it can
  gain a side the line never had, and a guard reading the diagonal will spend it
  → [[2026-09]]
- 2026-09-13 — **Per-tool ink settings are read once, together, at gesture start.**
  `inkColor`/`inkWidth` live per tool, so capturing the tool at press and the
  colour at release marries one tool's identity to another's settings
- 2026-09-13 — **All drags rebase on concurrent edits**, cards and zones included
  (Tim's call). A clamped drag must rebase from the *pointer*, never from the
  clamped preview — that distinction was a real defect → [[2026-09]]
- 2026-09-13 — Gesture recovery is driven by `draw()` → `reacquire()`, **not** by
  `lostpointercapture`, which fires for touch and pen whatever the gesture is
- 2026-09-12 — Dual schema definitions with conformance testing → [[2026-09]]
- 2026-09-12 — **Never stricter than Foundry.** Foundry's NumberField is nullable,
  so `pin.x = null` is valid; entity keys are unconstrained, so hand-authored keys
  like `base1` must be accepted. The only real key constraint is DOM safety.
- Player edit grants **real Foundry OWNER** on the page, because Foundry checks
  ownership server-side. The in-sheet rules and delete guard are accident guards,
  not a boundary. Accepted for in-person convention play — never describe as secure.
- No custom socket. Features that must reach other clients are stored as document
  state so Foundry's own broadcast carries them. Keep that property.

**Gotchas**
- **On foundry.oneoffgames.com every session is the same `TimEvans` GM**, so a pin's
  `author` and the log's client IP cannot tell two sessions apart. Worse: only
  *authentication* records carry `ip`/`session` — launches, parks, vends and
  client-session lines carry neither, so **a world park is unattributable by
  construction**. One admin auth (13 Sep 00:45:49) granted ~23h of credential-free
  parking to session `ad9e225e`, which then authenticated from *two different* IPs.
  Transcripts and screenshots are the only real attribution. See [[2026-09]]
- **Nothing in `sheet.mjs` binds to `this.element`, `document` or `window` on a per-render
  path** — all 48 listeners target a node inside the replaced part subtree, which is the only
  reason re-binding on every `_onRender` cannot accumulate. Add one to a surviving node and it
  **will** accumulate silently, one per render, with no error and no duplicate in the DOM.
- `sheet.mjs` is the only writer, via `#commit`. `board-ops.mjs` is pure functions
  returning flat update payloads. `visibility.mjs` is the single gate between a
  player's board and the GM's.
- Foundry merges field class defaults onto instances — comparing `field.options`
  alone produces phantom differences.
- Safe to deploy over a running server (no compendium packs), unlike [[afterimage]].
- **A clean console after a reload is not evidence — the tool's buffer spans reloads.**
  A stale error line outlives the fix that removed it, and ordering is the only tell
  (the pre-reload sequence appears *after* the line it preceded). Pin the page first:
  `performance.timeOrigin` against the deploy time, or a sentinel on `window` that a
  real reload destroys. In a world with many modules the buffer also overflows and
  drops the setup-time lines entirely, so prefer a mechanism check — a disabled module
  fetches no scripts (`performance.getEntriesByType("resource")`) and registers no
  settings, which cannot be faked by a quiet log → [[2026-09]]
- `build.mjs` copies only `COPY = ["src","styles","templates","assets","lang"]`
  (`build.mjs:7`). Untracked files under `app/` or `tools/` therefore **cannot** reach a
  build; the `bundle.mjs`/`zip.mjs` hazard was real only because those sat under `src/`.
  Do not warn a peer off a deploy without checking that the copy is scoped.
- **Driving the board with synthetic events has sharp edges** — all four written
  up in `docs/verification/2026-09-13-rebase-live.md`. The worst: the content
  subtree is replaced on every render, so a reused viewport reference is detached
  after the first commit, and events sent to it report as *"the gesture declined
  to claim"* rather than as an error.
- Toolbar controls (pen, shape tools, Player preview) exist only in
  `board-edit.hbs`. Rendering the **parent journal sheet** embeds the page
  read-only — open the page's own sheet.
- **Player preview** puts a GM's sheet into player mode; no second login needed
  to test player-only behaviour.
- **A pinned background needs a pinned colour.** Two editor fields set a light
  background and let the colour inherit; under the dark theme that is near-white,
  so note bodies were invisible. ProseMirror styles its own `.editor-content`, so
  the host's colour does not reach it.
- The card editor opens from the card's **right-click menu**, or automatically
  after *Add note* — double-click only opens *link* cards.

Related: [[custodians-ringbrp]], [[oneoffgames-vps]]
