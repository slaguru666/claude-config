---
type: project
status: active
repo: slaguru666/corkboard
path: ~/Git/corkboard
updated: 2026-09-15
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

**Phase 5 slices 1, 2 AND 3 are LIVE** (2026-09-14) at
**https://corkboard.oneoffgames.com** — accounts, sessions, an admin page, and
**boards**. A board is a page at `/boards/<id>` drawn by the same `BoardScreen`
the standalone app uses; there is no `src/web/host.mjs` after all — the seam
that mattered was the **session**, six members, so `src/web/client/session.mjs`
answers it over HTTP and `BoardScreen` needed one new parameter (`makeLock`).
Modules are served from a **map built at start-up** — no filename ever comes
from a request, so there is no traversal to guard against. Somebody else's
board answers **404, not 403**. A stale write is 409. Slice 2 is also the first
time `src/data/sanitize.mjs` stands at a real trust boundary, because here the
author of a note is somebody else — it runs on the SERVER. Verified live:
`docs/verification/2026-09-14-shared-slice-2.md`. **An account `tim` now
exists; its password is in `/root/.corkboard-admin` on the box** (600).

**Slice 3 is the SSE fan-out.** `GET /api/boards/:id/events`; a commit pushes
the WHOLE board to every watcher, built once per recipient (`hub.publish` takes
a function, not a message — that is spec §7 made structural so slice 4's filter
changes one place). The event id IS the revision, so `Last-Event-ID` makes a
reconnect free and there is no replay buffer. Live: opening event in 70ms,
commit→listener in 60ms, heartbeat on its 25s interval, `gone` on delete.
nginx needs `proxy_buffering off` on that path — the installer will NOT rewrite
an existing site file (certbot has been through it), so it now *warns* when the
block is missing, because a buffered stream still "works", just minutes late.
Slice 3 also did NOT need a `defer-redraw-while-dragging` mechanism:
`GestureArbiter.reacquire()` has carried that since phase 3.
`docs/verification/2026-09-14-shared-slice-3.md`.

**Slice 4 is grants and the server-side filter** — the thing the whole design
was built for. `board_grants` gives a (board, user) a role; **ownership is NOT
in that table** and stays in `boards.owner_id`, deliberately against spec §5,
because a role stored twice can disagree with itself (flagged in the plan and
the verification doc). `openBoard` runs `visibleBoard(state, "player")` for a
viewer before anything is written to the socket, so **a hidden card is absent
from a viewer's bytes** rather than present and undrawn — proved live against
the raw response and the SSE stream, not against a parsed board. It works for
a live update as much as a page load only because slice 3's `hub.publish`
already built one message per recipient. An editor sees the board as a GM does.
Every write is re-checked against the grant: a viewer's commit is **403 denied**
(not `gone` — she can see the board, so pretending otherwise is a lie she can
disprove by reloading). Revoking closes that person's streams with a `gone`.
`docs/verification/2026-09-14-shared-slice-4.md`.

**Slice 5 is pictures on a shared board** (2026-09-15), live. A card can hold a
photograph again, and the same question slice 4 asked of a hidden card is asked
of its picture: a viewer gets **404** for the bytes behind a card they cannot
see, and 404 for the ones they could the moment a grant is revoked.
`mayFetchAsset` goes through `assetsFor`, which goes through `boardStateFor` —
the SAME filter — so the picture door and the board door cannot drift apart.
The id is the **SHA-256 of the bytes the server received**; there is no field a
caller can name it with, and the media type is read out of the bytes too. Bytes
live on disk under `/var/lib/corkboard-web/assets/ab/cd/<digest>`, NOT in
Postgres (§5) — written to a `.part` name and `rename`d, because a file at a
content-addressed path is a promise nothing will re-hash. SVG is refused here
though the app accepts it: `/assets/<id>` is a URL and navigating to it renders
a same-origin document. The browser gets a **same-origin URL, never a blob** —
the CSP is `img-src 'self' data:`, so a blob would simply not draw; that is why
`AssetResolver` now takes a `url` record and tracks whether the URL is `ours`.
Two things the deploy needed: `StateDirectory=corkboard-web` on the unit
(`ProtectSystem=strict` would have failed the first upload with EROFS at the
rename) and nginx `client_max_body_size` **9m**, a megabyte above the service's
own 8 MiB cap so the SERVICE refuses and says why instead of nginx's HTML page.
The installer warns about the second on a box it will not rewrite.
**No orphan collector**: an upload that never reaches a card, or a picture on a
deleted board, stays on disk — observed, not assumed.
`docs/verification/2026-09-15-shared-slice-5.md`.

**§6's stale-base relaxation is LIVE** (2026-09-15, deployed at `5e42c1c`). A
commit whose base is behind is now a **question, not a refusal**: if it touches
nothing the window touched, it is accepted. Built in another session; what
mattered here was that it needed **no schema change** — the merged commit is
recorded at the **CURRENT revision**, not the base the client claimed, so
`changes` keeps one row per revision and the `(board_id, base)` PK is untouched.
Recording it at the claimed base would make two commits at base 7 a unique
violation, which is an ALTER this repo still has no mechanism for. The unit is
**entry-level, not the coupled group** — any two writes to the same shape
conflict, so no kind gate, no board read, nothing for value-inference to get
wrong. Proved live 14/14: a different card at a stale base lands at revision 2,
the same card is 409 with the value AND the revision unmoved, a delete is never
merged on either side, and a base ahead of the board is nonsense not staleness.
`docs/verification/2026-09-15-shared-slice-6-deploy.md`. **What live testing did
NOT cover:** every stale-base check was sequential `curl` from one account. Since
closed in-process (`982210e`, `test/web-concurrency.test.mjs`) — overlapping
commits through real sockets and two real `WebSession` instances, sweep 5/5.
**What that test found is the feature's honest limit: §6 does not help when
commits genuinely overlap.** Eight non-conflicting commits against a store with
latency give one winner and seven refusals — `applyChange`'s optimistic check is
made against a revision read a moment earlier, and there is no retry, so those
seven are told to reload exactly as before §6. Nothing corrupts; an opportunity
is lost, and the window is one database round trip. **That gap is now closed and
LIVE** (deployed 2026-09-15 12:22 CEST at `5b5852b`; **production is now `6caf4d5`, the tip, deployed 12:5x on Tim's instruction so the box is the tip on purpose rather than by nobody noticing**): `COMMIT_ATTEMPTS = 4`, and a
loser re-reads the board and tries again instead of being told to reload. Bounded
on purpose — an unbounded version **starves the event loop**, because every await
in the path resolves as a microtask, so timers never get CPU and even vitest's own
`testTimeout` cannot fire; the process simply stops answering. The role is re-read
**per attempt** (`src/web/boards.mjs:307`), so a grant revoked mid-retry is not
honoured against a role read before it was taken away — worth more than the retry
itself. **Proved live in production** (2026-09-15 12:28 CEST, by the slice-5
session): eight non-conflicting commits fired at once at one base gave **7 landed
/ 1 refused**, where the same shape before the retry gave 1 / 7 — and the two
consistency checks are the part that matters (cards on the board == commits told
they landed; revision == base + landed). **The floor holds**: eight at once against
the SAME card still gives exactly one winner, revision +1, which is what the bound
must never erode. Corroborated independently from nginx's access log rather than
taken on report — 20 commit POSTs in one second, 11×200 / 9×409, the 409s
matching the reported exercises exactly. Still unproved: two browsers on two
machines, load, and SSE reconnect under `Last-Event-ID`.

Slice 1, for the record:
`./install-web-server.sh` then `certbot --nginx -d corkboard.oneoffgames.com`;
both idempotent, and the installer never overwrites the database password or
touches an account. Service `corkboard-web` on 127.0.0.1:8790 behind nginx,
Postgres database+role `corkboard`, credentials in `/etc/corkboard-web.env`
(600 root:root). argon2id passwords at 19 MiB; the sessions table stores
SHA-256 of the token, never the token. **The database has zero users — the
first admin is Tim's to create**, password on stdin (the command is in the
README). No registration, no email, no reset-by-mail. Boards are slice 2, so
the shelf is honestly empty. Verified live:
`docs/verification/2026-09-14-shared-slice-1.md` — 79 mutations, 78 caught,
seven defects found. The Foundry module, the standalone app and the published
board are all untouched; 1670 tests green.

**The CSP line, worth keeping** — under `style-src 'self'` with no
`unsafe-inline`: `el.style.x =` and `el.style.cssText =` apply and are allowed;
`setAttribute("style", …)` and a markup `style="…"` are **blocked and silently
do not apply**, with no exception to catch. The renderer's CSSOM discipline is
therefore load-bearing, and breaking it looks like cards that stop moving.
Was: `tools/app-shell.mjs` held a literal NUL byte as a hash separator, so git
called it binary and **grep found nothing in it at all**. Fixed in `a667c65`
(`"\0"`, byte-identical). Note `$(...)` **strips NUL bytes** — counting them
through a command substitution lies.

**Phase 5 designed** (2026-09-14). A web-based shared Corkboard with
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

**The bounded retry is live** (2026-09-15, `5b5852b`). §6 merged a stale base but
did NOT rescue genuinely overlapping commits — the merge decision is made against
a revision read a moment earlier, so a writer landing in between invalidated it.
Four attempts, each a read and a write, close that. **Measured in production:
eight non-conflicting commits at once give 7 of 8, where the same shape gave
1 of 8 before.** Eight against the SAME card still gives exactly one winner, so
the bound rescues contention without eroding the floor. The role is re-read per
attempt, because a retry around an authorisation check widens the gap between
deciding who may write and writing. **A live proof needs no person:** mint a
session with `beginSession`, use it as a cookie, `endSession` after — no password
is typed into any form, which is what had kept live proofs parked for four slices.

**Next steps**
- **Verify the geometry race fix on a live board** — drag a line's box in one
  tab while undoing a resize in another, both orderings. Codex's harness ran
  Foundry 14.361; live is 14.363
- **Open the same board in two signed-in tabs and drag a card in one.** Closes
  BOTH open gaps in seconds: the server and the client have each been proven,
  but never in one session (the *real* reason is two machines and real pointer
  gestures — NOT that signing in needs a password typed into a form, which was
  wrong: `beginSession` in `src/web/accounts.mjs:100` mints a session server-side
  and `endSession` revokes it, so a live authenticated proof needs no credential
  and no person),
  and a drag completing across a push is unverified because synthetic pointer
  events never made the gesture claim
- **An orphan picture is never reclaimed** — an upload that never reaches a card,
  or one on a board somebody deletes, stays in the `assets` index and on disk.
  Each upload is capped at 8 MiB; nothing bounds how many. Deciding what a
  deleted board's pictures mean is entangled with slice 6's import/export, so it
  is owed as part of that
- **Phase 5 slice 6** — import and export against the shared service
- **Before any slice that changes an EXISTING table**: `schema.sql` is
  `create table if not exists`, so a changed column definition never reaches a
  database that already has the table, and the db suite truncates rows without
  dropping them — it reports green on a constraint that never applied. There is
  no migration mechanism yet; one is owed
- Slice 1+2 gaps worth closing: no reboot test (that box runs Foundry), nothing
  about load, the login throttle forgets on restart (in-memory by design)
- Housekeeping on the box: the `corkboard_test` role and database, and an SSH
  tunnel on port 55432 — **closed 2026-09-15**, reopen per run and close after.
  The `corkboard_test` database is deliberately KEPT: without
  `CORKBOARD_TEST_DATABASE_URL` the Postgres store suite skips silently, which
  is how §6 nearly shipped with `changesSince` never once executed.
  Account `sara` is suspended again
  after slice 4 AND slice 5 used it; both temporary password files were shredded.
  Two `Dock 9, live check` boards from slice 3 are still on the box; slice 5's
  test board and its two pictures were deleted, index rows and disk files
  included
- **The iPad is the only thing phase 4 is waiting on.** Add to Home Screen, standalone
  display, `navigator.storage.persist()`, and whether Files round-trips a
  `.corkboard` bundle. Contracts §5 and §9 are provisional until it answers
- Run `npm run build:app` after changing anything the app loads — **as the last
  step before staging, not when the source change feels finished.** `src/data/*`
  and `src/app/*` feed the shell hash, so one more edit after the build stales it
  again; a session did exactly that twice on 2026-09-15. A test fails if you
  forget. If the hash is stale from somebody ELSE's uncommitted work, leave it:
  a shell hash rebuilt by whoever did not make the source change is a commit
  nobody can attribute afterwards.
  **With more than one session writing, run `npm run build:app:staged`** (added
  2026-09-15, `51968ad`), which hashes the INDEX rather than the working tree, so
  it is correct even while a peer's shell file is dirty. `build:app` still hashes
  the tree, which is what you want while developing. The two stop coinciding the
  moment a peer has a shell file dirty, and that shipped an inconsistent HEAD for
  ~20 min (`8ed194d`). Stage your sources FIRST, then run it: an unstaged source
  of your own correctly does not affect the hash, because it is not in the commit.
  The one case no check can catch is building BEFORE staging your sources.
  Corollary: a red app-shell test in a shared dirty tree is other people's
  uncommitted edits, not a defect; what matters is green in a clean checkout of HEAD
- Explicit v1 migration, and the sanitised share copy, still owed from phase 4
- Phases 5–6: sync proof, opt-in sharing
- iPad storage durability testing (contracts §5). The URL to test is now the real
  app, **https://web.oneoffgames.com/corkboard/app/** — not the old
  `corkboard-spike/`, which is the phase-1 spike and a different thing
- Deferred from review 21: require `shape` whenever `setShapeBox` is given size
  keys (today it silently falls back to a zero floor); `reshape` previews nothing,
  so the clamp is invisible until release

**Key decisions**
- 2026-09-15 — **Deploy from a throwaway worktree at an explicit sha, never from
  `~/Git/corkboard`.** `install-web-server.sh` runs `rsync -az --delete src/`, and
  several sessions share that tree; at deploy time it held three files nobody in
  this session had written, one of them `src/data/board-ops.mjs`, which is on the
  write path. `git worktree add <dir> <sha>` costs one command and makes the shipped
  bytes exactly what the commit says. Confirm it afterwards by comparing the sha256
  of the whole `src/` tree on the box against the artifact — it matched on `5b5852b`.
- 2026-09-15 — **"Keep the commit" is not "deploy it".** The retry was settled as
  KEEP through a peer relay; the peer then refused to deploy on that, and was right
  to. Two decisions, and only a person makes the second one.
- 2026-09-15 — **No pre-commit hook for the shell hash, deliberately.** A peer
  proposed one: rebuild from the index at commit time and refuse if it differs
  from the staged `app/sw.js`. It would catch build-then-stage, which is real but
  is one session's own ordering and is documented in the script. Its other case —
  a peer staging a shell file between your build and your commit — argues the
  other way: **all sessions share one `.git`, so their staged file is in your
  commit already.** The hook would fire, you would rebuild, and you would ship
  their work under your message with a *correct* hash. A green check where
  something bad happened is worse than no check. The control that covers that
  case is the existing one — stage by explicit path, read `git diff --cached`
  before every commit. Revisit only if build-then-stage actually bites someone.
- 2026-09-15 — **"It comes back ordered" is a plan, not a guarantee.** `changesSince`
  needs `order by base` because `merge.mjs` checks the window's contiguity by
  walking the rows. Dropping it is invisible in every ordinary test: the planner
  picks `Index Scan using changes_pkey` and the key is `(board_id, base)`. Forced
  to a seq scan after an UPDATE moved tuples, the same rows came back
  `[2,3,4,0,1]`. Pinned by a pg-only test on its own pool with index and bitmap
  scans off, which asserts the plan really is a Seq Scan **before** asserting the
  order. The argument that insertion order already IS key order is sound for the
  in-memory fake and does not transfer to a database. → [[2026-09]]
- 2026-09-15 — **A stale base is a question, not a refusal — and the conflict
  unit is the ENTRY, not the field.** `commitToBoard` refused every stale base;
  spec §6 asks for that to be weakened, so the bar is staying provably NARROWER
  than "refuse everything". `src/web/merge.mjs` holds the whole rule and **reads
  no board**: two commits conflict if they touch the same entry, whatever fields
  they name. Deliberately coarse — a field-level rule would have to know a
  line's `w,h` and `a,b` are one value, which means knowing `kind`, which means
  choosing which board's view to trust, and value-inference has been wrong here
  four times. At entry level a line's geometry is indivisible without anything
  knowing what a line is. Cost: a retitle-during-move is refused. → [[2026-09]]
- 2026-09-15 — **The merged commit is recorded at the CURRENT revision, which
  is why no migration is needed.** A peer review said the `changes` PK
  `(board_id, base)` blocks the relaxation and needs an ALTER this repo cannot
  do. That holds only if a merged commit is stored at the base its author
  claimed. Rebasing onto the current revision keeps one row per revision, keeps
  `base` meaning "the revision this applied to", keeps §5's chain contiguous,
  and needs no change to `applyChange` — its guard becomes protection against a
  third writer. Measured before replying, because if the peer had been right the
  task stopped. Given up: nothing records that a commit was rebased; provenance
  is what would need the migration. → [[2026-09]]
- 2026-09-15 — **Deploy the web service from a clean git worktree, never from the
  working tree.** `install-web-server.sh` rsyncs `src/` with `--delete` from
  wherever it is run, so a peer session's uncommitted files ship to production.
  `git worktree add <tmp> <commit>` and run the installer from there.
- 2026-09-15 — **A mutation sweep must run in a throwaway worktree too.** An
  in-place sweep that copies to `<file>.bak` and restores is invisible to a peer
  reading the tree: the restore clobbers their edit, and their edit makes a
  mutant look like it survived. Silent in both directions.
- 2026-09-15 — **A picture's URL is authorised through the board filter, not
  beside it.** One filter, two doors, so they cannot disagree — the alternative
  was a second rule about who may see which digest, and two rules only have to
  differ once.
- 2026-09-15 — **The app host's commit log records a line's geometry whole, and
  the reason is the log, not a live race.** `BoardSession.commit` now calls
  `completeGeometry` before `makeCommit`. Nothing can split a partial op today,
  and measurement said so rather than reading: one tab holds a board
  (`navigator.locks`), and the shared server refuses a stale base OUTRIGHT —
  driving the real `commitToBoard` with two clients at one base gives the loser
  `{ok:false, reason:"stale"}` and discards their commit whole. What the fix
  buys is the log outliving that protection, because `outbox` is declared and
  empty and those ops become wire payloads the day it ships. `completeGeometry`
  alone and NOT `writeThrough`: the `{diff:false}` half answers Foundry's sender
  diffing and review 32 measured its cost. Inert on replay, measured both ways.
  → [[2026-09]]
- 2026-09-15 — **The merge point is where a stale-base policy must carry the
  coupled group, and it does not exist yet.** Spec §6 plans to accept some
  stale-base commits ("two people dragging different cards do not conflict").
  Accepting any of them IS the merge, and that is where a partial `w,h` op lands
  over moved ends and makes a zero-length line. Strict CAS is what closes this
  in slices 1-4; completion belongs inside that future merge rule rather than
  bolted on after. Completing app-side and at the merge compose — a whole group
  leaves the merge deciding about one value instead of four. → [[2026-09]]
- 2026-09-15 — **Ownership lives in one place, against the spec's own table.**
  `board_grants` carries only `editor` and `viewer`, with a check constraint
  naming exactly those two; `boards.owner_id` stays the sole record of who owns
  a board. A second copy could disagree — two owner rows, or an owner row naming
  somebody who is not `owner_id` — and no query needed it. Flagged, not done
  quietly. → [[2026-09]]
- 2026-09-15 — **A test fixture that loses its payload looks exactly like a
  pass.** The NUL proof reported a clean result while exercising nothing: the
  escape in the shell script had become a literal NUL on the way to disk and
  bash dropped it, so curl sent a perfectly clean body. Same family as
  "`$(...)` strips NULs", one step earlier in the pipeline. A fixture carrying
  an awkward byte must COUNT what it is about to send, every run. → [[2026-09]]
- 2026-09-15 — **Assert on element names, not substrings, when checking a
  sanitiser.** `<scr<script>ipt>` comes back as ONE element named `scr<script`;
  a substring check calls it a surviving script and is wrong about what a
  browser reads. Checked in a real parser: zero attributes, not a script
  element. A tag name cannot contain whitespace, so no attribute can be begun
  inside one. → [[2026-09]]
- 2026-09-15 — **A structurally coupled field group travels whole or not at
  all.** A line's `w`, `h`, `a`, `b` are one value under four names, and TWO
  separate things split it: producers naming only what they changed, and
  Foundry's `page.update` diffing against the SENDING client's view and dropping
  whatever matches. Fixing one leaves the other ordering broken — which is how
  the 2026-09-14 fix passed the reported sequence and failed its reverse.
  `writeThrough` is both decisions in one testable function; the trade is
  last-write-wins over the group, which always leaves a shape somebody
  authored. → [[2026-09]]
- 2026-09-15 — **A decision that lives only in `sheet.mjs` is held by nothing.**
  It imports Foundry, so it has no unit tests: a mutation reinstating the undo
  race there passed the entire suite. Policies move into `board-ops.mjs` where
  tests reach them, and the call site gets a source-text guard in
  `build.test.mjs`. → [[2026-09]]
- 2026-09-14 — **Postgres is tested against Postgres, never a fake.** Three of
  the things store-pg.mjs exists to get right — the case-insensitive unique
  index, the on-delete cascade, the lower() lookup — are properties of the
  database. Proved by mutation: a fake agrees with the JavaScript on all three
  while the database disagrees. Dev machine has no Postgres, so the suite
  tunnels to the VPS's. → [[2026-09]]
- 2026-09-14 — **A flag that reports what the code claims is not evidence.**
  `authenticate` returned `hashed: true` so a test could assert the anti-
  enumeration hash had run; it was a hardcoded literal, and deleting the hash
  entirely left every test green. Timing properties need timing tests — as a
  ratio against a comparable path, so they calibrate to the machine. → [[2026-09]]
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
- **Before committing, rebuild the shell with `npm run build:app:staged`, not
  `build:app`** (51968ad). `build:app` hashes the WORKING TREE; the commit records
  the INDEX. One writer, no difference; three sessions writing, never the same
  bytes — and on 2026-09-15 a commit published a shell version computed over
  another session's uncommitted CSS, so HEAD claimed a hash its own sources did
  not produce and everyone who pulled got a red `app-shell` test. The staged
  build uses `git checkout-index`, which is correct *while the pollution is still
  there*, so it needs no timing and no being last to move. `app-shell.test.mjs`
  still reads the tree and so can go red on somebody else's dirty files — that is
  expected noise; what must be true is green in a clean checkout of HEAD.
- **A NUL byte in a source file makes it BINARY to git** — no diff, no blame, no
  merge. `tools/app-shell.mjs` carried a literal `0x00` as the hash separator in
  `shellVersion` and had been undiffable all along; `"\0"` is the same byte at
  runtime (`a667c65`). Worth a scan if a file ever mysteriously shows as
  "Binary files differ".
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
