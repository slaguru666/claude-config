---
type: tasks
updated: 2026-09-15
---

# Tasks

Live list across everything. Completed items roll to `Archive/` monthly.
Index: [[INDEX]]

## Active

- [x] Undo double-fire report — **not reproducible; no defect** [[corkboard]] (2026-09-13). One click gives one handler run and one toast; the binding is single on every render path. Do not re-chase.
- [x] **Undo race — both review 32 P2s fixed** [[corkboard]] (2026-09-15, 19b9ace). Both were BOUNDARY errors, not errors in the coupling. The rule was keyed on `shapes.<id>.<field>` and so excluded `shapes.<id>` — the one producer naming a line's geometry all at once (`restorePayload`, used by baseline restore and import). Classification now lives in one function, `coupledTarget`: an existing entry is forced, a creation is not (nothing to diff against), a removal is excluded explicitly (`placeOf` strips the `-=`), and an entry BECOMING a line counts. Second: `diff:false` is per-update not per-field, so protecting four fields stopped protecting everything sent beside them — `setShapeEnd` names `x,y` too. `thinUncoupled` now drops what diffing would have dropped outside the group, in one update (one payload is one transaction). Mutation sweep 14/14.
- [x] **Coupling boundary — rebuilt so there is nothing left to infer** [[corkboard]] (2026-09-15, 1488f9a). Three fixes had each added a rule for a SECOND key shape; the fix is to remove the second shape. A whole-entry write is rewritten as writes of the fields it sets (Foundry merges objects into existing entries, so it is the same write). One key shape afterwards, and completion and thinning both work at the granularity Foundry's own diff uses. Both review 33 findings fall out rather than being handled. Flattening is the price of turning diffing off, so it is paid only there: uncoupled writes are handed back untouched, creations stay whole. 2044 pass, sweep 17/17.
    - Writing tests for two guards no producer can trigger found a third defect: `thinUncoupled` folded the `-=` away and compared a removal against the entry it removes. Real removals carry null so nothing was broken — the rule was.
- [x] **Cleanup hole — every write that can leave defaults is now watched** [[corkboard]] (2026-09-15, 8ed194d). `fieldTargets` named only field writes, and the sheet installs its delete-watch only `if (targets.length)`, so a whole-entry write had NO listener. Measured on 14.361: a COMPLETE whole-entry write recreates the author's entry (no ghost, the old reasoning was right), a PARTIAL one recreates the named fields plus schema defaults (x:0,y:0,w:320,h:220) — a real ghost, unwatched. `readImport` accepts partial entries, so it is reachable. Fix: every entry written an OBJECT into is a candidate; `fieldsWrittenInto` now reports the names a whole-entry write supplied, so `looksResurrected` decides completeness itself — nothing to compare means nothing to delete. Sweep 6/6, 2107 pass.
    - My first statement of this was WRONG in the other direction (I said a card-only restore left a phantom; it does not — restorePayload writes complete entries). Measuring against the real model is what separated the two cases.
    - Testing the removal guard found a second defect: a `ForcedDeletion`-valued write became a target and reported `__$OPERATOR$__` as a written field. Now excluded through the existing `isRemoval`, which covers both spellings.
- [ ] **Review 32 leftovers, still open** [[corkboard]] — PLAUSIBLE P2 on the post-await witness; P3 that five sheet.mjs mutations pass the source-text guard.
- [ ] **`looksResurrected` — needs a decision, not a patch** [[corkboard]] (review 31). Delete cleanup infers from values, so it misses a phantom whose unwritten fields match the schema defaults and deletes a genuine restoration somebody has recoloured. This area has punished value-rules four times.
- [x] **Carry the geometry write policy into the app host** [[corkboard]] (2026-09-15, 2da3f0f). `BoardSession.commit` completes the group before `makeCommit`, so the log stops recording half a shape. **This task's own premise was wrong and measurement corrected it:** slice 4 did not remove the protection, and the app store is not on the multi-writer path at all (`WebSession` has no commit log; `outbox` is empty). There is **no merge point** — `commitToBoard` pre-checks the base and `applyChange` enforces `(board_id, base)` in-transaction, so a racing partial op is refused entirely rather than combined. Verified by driving the real function with two clients at one base: the loser gets `{ok:false, reason:"stale"}`, line still length 20. The fix is justified by the log outliving that protection, not by a live race. `completeGeometry` alone, never `writeThrough` — review 32 measured the cost of the `diff:false` half. Inert on replay, measured. Sweep 5/6, survivor proved inert (completion fills only omitted keys; apply changes only named ones).
- [x] **§6's stale-base relaxation, with coupled geometry safe at the merge** [[corkboard]] (2026-09-15, 9909bd9). `src/web/merge.mjs` decides whether a stale-base commit may land; the unit is the ENTRY, not the field, so a line's geometry is indivisible **without the rule reading a board or knowing what a `line` is**. Merged commits are rebased onto the current revision, which is why the `changes` PK needs no ALTER and the migration task is NOT a prerequisite — a peer review claimed it was, and measuring settled it. Deletes refuse on both sides (a delete's effects reach entries it does not name); a gap in the window refuses; `STALE_LIMIT` 25. Proof of narrowness is one route-level test: a request that answered 409 before and 200 after. Sweep 12/14 in an isolated worktree, one equivalent recorded, one dead line deleted.
- [x] **`npm run test:db` for the merge work — run, and it found a defect** [[corkboard]] (2026-09-15, 2cdf7b3). `changesSince` has now executed against real PostgreSQL 16: 35/35 on `corkboard_test` through the SSH tunnel. It did not stop at green — mutating the real SQL caught `base >` for `>=` and "any board", which proves the assertions reach Postgres, and found a genuine survivor: **`order by base` is load-bearing and was held by nothing.** My note calling it equivalent reasoned about a JS array and does not transfer — heap order is not a contract, and the clause looks free only because the planner picks an index scan on a PK that happens to be in that order. Forced to a seq scan after an UPDATE moved tuples: `[2,3,4,0,1]`. Now pinned by a pg-only test that proves its own plan first. `Number(r.base)` IS equivalent today and is kept with its `bigint` reason stated.
- [x] **Race §6 in process** [[corkboard]] (2026-09-15, 982210e). `test/web-concurrency.test.mjs`: overlapping commits through real sockets, two real `WebSession` clients, SSE fan-out around a merge, and the change log's contiguity. Sweep 5/5. Found that a test named "whichever order the two arrive in" was a single `Promise.all` that resolved identically every run — review 31's sampling error, in a test rather than in production code; now two deterministic tests.
- [x] **A bounded retry for a lost CAS — BUILT** [[corkboard]] (2026-09-15, 5b5852b). Records a conflict of instruction worth keeping: this entry was written as DEFERRED on a peer session's relay of Tim's decision, and Tim then told this session directly to build it. A relayed decision is not an instruction — asked him to settle it rather than acting on either, and he confirmed build. **Settled 2026-09-15: Tim's word is KEEP the retry** — asked a third time once the conflict was visible to him, so this is decided and not to be re-raised or reverted. Verified at 5b5852b in a clean worktree: 2110 tests green, the slice-4 source guard still holds (`applyPayload` on the STORED board, "not to a filtered copy"), and the role is genuinely re-read per attempt so a grant revoked inside the loop is not written through. **DEPLOYED 2026-09-15 12:22 CEST** — Tim made the second decision directly ("deploy it"); "keep" had correctly not been treated as "ship". Production moved 5e42c1c → 5b5852b, which shipped NINE commits, five of them other sessions' (1488f9a, 35abe6e, 8ed194d, 440af78, 51968ad). Proof the box runs exactly that commit: the sha256 of the whole `src/` tree matches the artifact byte-for-byte. No schema change, so the installer's migrate step was an idempotent re-apply ("schema at version 4"). **Proved live in production 12:28 CEST: 7 landed / 1 refused of eight non-conflicting commits at one base, where the same shape gave 1 / 7 before the retry; the same-card floor still gives exactly one winner.** Corroborated from nginx's access log (20 POSTs in one second, 11×200 / 9×409) rather than taken on a peer's report. **Production moved again to `6caf4d5` (the tip) on Tim's instruction, so the box is the tip deliberately.** That shipped 20418eb (null is a delete at the entry, not a field) and 6caf4d5 (Foundry sheet header) — neither reaches the service: the web imports exactly one name from board-ops, `placeOf`, byte-identical at both shas, and no schema change. Re-proved after that deploy: 6 landed / 2 refused of eight (ordinary variance in a bounded retry; 7/1 the run before, 1/7 before the retry existed), floor still exactly one winner, §6 through the route 200/200/409. Box `src/` digest verified equal to a clean worktree at the sha. The deferral reasoning is kept because two thirds of it still stands and it explains what the bound is for: the SSE-lag case is the common one, the overlap failure is an honest "reload" with nothing lost, and retrying adds work under the contention that triggers it.
  What it does: a loser re-reads and re-asks `mergeable` against the revision that actually landed — not a re-send, because the commit that won may be the one this payload conflicts with. `applyPayload` runs per attempt against the state just read. Only a lost race is retried. The role is re-read per attempt, because the retry lengthens the window between deciding who may write and writing, and a grant revoked inside it must not be written through. `COMMIT_ATTEMPTS` 4, a judgement not a measurement.
  The measurement that prompted it, kept so nobody re-derives it: eight non-conflicting overlapping commits gave **one winner and seven refusals** before this. Independently verified by a second session, instrument included — replacing the slow store's `setTimeout` with `Promise.resolve()` makes all eight land and the test fails `expected 8 to be less than 8`.
  **Proved in PRODUCTION after the deploy** (third session, 2026-09-15): eight non-conflicting commits fired at once at the same base gave **7 landed, 1 refused** — the same shape that gave 1 and 7 before. Board == the commits told they landed; revision == base + landed. **Floor intact:** eight at once against the SAME card still gives exactly one winner, revision +1. §6 through the route post-deploy: fresh 200, stale/different-card 200, stale/same-card 409. **No person was needed** — `beginSession` mints a cookie, `endSession` revokes it, and no password is typed into any form. That technique retires the "needs someone to sign in" blocker that had parked live proofs for four slices.
  **The unbounded variant is worse than slow**, and this is the argument for the bound: against a store resolving in microtasks it starves the event loop — every await is a microtask, timers never run, vitest's own test timeout cannot fire, and the process stops answering anything. With a real database it becomes an endless retry holding a connection. Sweep caught no-retry, retry-anything, no re-read, mergeable-only-once, and no role re-read; the unbounded mutant is caught by a hang rather than a clean failure, which is stated rather than counted.
- [ ] **Provenance for rebased commits, if ever wanted** [[corkboard]] — nothing records that a merged commit was rebased from an older base; afterwards it looks exactly like an up-to-date commit. Deliberate: recording it means a surrogate key or an extra column on `changes`, which is the ALTER that needs the migration mechanism. Only worth doing if somebody actually wants the audit trail.
- [ ] **Serialise the app's commits** [[corkboard]] — neither `AppHost.commit` nor `BoardSession.commit` serialises, and the `commits` keyPath is `["boardId","base"]`. Two overlapping commits in one tab would share a base and the second `put` would replace the first's record. Gestures await, so it may be unreachable — structural rather than observed, and not geometry-specific. Found while porting the geometry policy. **The web host is immune and this must not be "fixed" there too:** `changes` has primary key `(board_id, base)`, so a second commit at the same base is a unique violation *inside* the transaction and `applyChange` returns `{ok:false, reason:"stale"}` — it cannot silently replace the first record the way an IndexedDB `put` at the same keyPath would. Confirmed by the slice-5 session against its own file. Genuinely app-side only; nothing in `src/web/` needs a change.
- [x] **Phase 5 slice 4 — grants and the server-side filter** [[corkboard]] (2026-09-15, cc04a90). editor/viewer per (board, user); `visibleBoard(state,"player")` runs on the SERVER per recipient, so a hidden card is absent from a viewer's bytes. Verified live against raw responses and the SSE stream. 40/40 mutations. Ownership deliberately NOT duplicated into `board_grants` (spec §5 deviation, flagged). One real finding from attacking the sanitiser: a NUL in a note body used to be a 500.
- [ ] **A migration mechanism** [[corkboard]] — `schema.sql` is `create table if not exists`, so a changed column definition never reaches an existing database, and the db suite truncates rows without dropping tables, so it reports green on a constraint that never applied. Fine so far (every table has been new); the next slice that alters an existing column needs this first.

- [ ] Phase 3 — extract the controller incrementally, subsystem by subsystem [[corkboard]]
    - [x] gestures: cards/strings, shapes/ink, zones (2026-09-13)
    - [x] IndexedDB commits, board create/list/name/delete (2026-09-13)
    - [x] shared sanitiser — one allow-list, both hosts (2026-09-13)
    - [ ] dialogs and IO
- [ ] Build the standalone Corkboard app shell [[corkboard]]
      - [x] viewport and gesture arbitration — all eight `reacquire` verified live (2026-09-13)
      - [x] slice 1: open a board, draw on it, reopen it with the work still there (2026-09-13)
      - [x] slice 2: the shared sanitiser and a rich-text editor for card bodies (2026-09-13)
      - [x] slice 3: asset ids, blob store, the display-time image resolver (2026-09-13)
- [ ] **Run CLEAN GROUND with human beings** — now literally the only thing left; eleven desk
      passes, every desk-reachable branch played, artwork placed (v0.25). Before convention-ready;
      no number of desk passes can settle Act Four's 45 minutes with no mechanical threat, or
      whether THE OFFER plays as a decision [[custodians-ringbrp]]
- [ ] Load `sla-mothership` once and confirm the libWrapper banner is gone — stored config
      fixed and verified against its backup, but that world has not been launched since
      [[oneoffgames-vps]]
- [x] **scenario-forge** — remote created, private `slaguru666/scenario-forge`, spec pushed (2026-09-13) [[scenario-forge]]
- [x] scenario-forge — parser + validator, run against all six (2026-09-13). 37 findings → 18 [[scenario-forge]]
- [x] **Clue Trails written for Vain Crown, Silvery Moon and Chopper** (2026-09-15, 2fdc76e).
      All six scenarios now validate clean. Vain Crown's existed as "Trail of Vesper" in the
      wrong shape; the other two were new writing off the acts' own material [[scenario-forge]]
- [x] Day One act 2 Clue Trail (2026-09-15) — the clues existed in a three-column table the
      parser could not read; completed in house format, plus the Guy's Hospital view [[scenario-forge]]
- [ ] **forge: clue tables in a set-piece are invisible** — `readClues` iterates numbered acts
      only, so Chopper's chapel reveal (clues 10-13, its most important) never reaches the case
      board; it reports 9 clues, not 13. Widen to set-piece sections, or decide not to [[scenario-forge]]
- [ ] Front-matter `version:` on all six scenarios disagrees with the prose — Silvery Moon's
      text says v3, its front matter says 1.0.0. Added wholesale in c81e8e5 and never bumped;
      decide whether it tracks anything [[scenario-forge]]
- [x] Handout indexes cleared (2026-09-13) — 5 of the 9 were a parser bug (per-act tables); 4 real gaps indexed from the print packs; AFTERIMAGE's props row given F2-H02-E [[scenario-forge]]
- [x] Day One's two unknown headings — renamed to lead with new canonical stems `running-this` and `rules-reference` (2026-09-13) [[scenario-forge]]
- [x] Section order fixed in three scenarios (2026-09-13). Silvery Moon and Chopper now validate clean [[scenario-forge]]
- [x] Three read-aloud blocks trimmed (2026-09-13) — overflow became GM-voiced bullets, no content cut. AFTERIMAGE and Princes Bride validate clean [[scenario-forge]]
- [x] scenario-forge — journal builder; AFTERIMAGE's nine scenario entries reproduce byte-identically (2026-09-13) [[scenario-forge]]
- [x] scenario-forge — **content port done** (2026-09-14): handouts, actors, scenes, tables + the blade-runner adapter. AFTERIMAGE rebuilds with all 30 journals / 13 actors / 6 scenes / 1 table; 222 tests, `6845182` [[scenario-forge]]
- [x] scenario-forge — module.json, adventure assembly, LevelDB packer; `forge build` works end to end (2026-09-13) [[scenario-forge]]
- [x] **scenario-forge live acceptance test PASSED** (2026-09-13) — built, installed, imported into a scratch world, pages open and read correctly [[scenario-forge]]
- [~] **scenario-forge — the four Corkboard boards** (2026-09-15, 7aa1814). Case/Player/Cast/
      Timeline build for all six scenarios: 24 boards, 0 errors, 0 coercions. Corkboard phase 1
      Corkboard phase 1 COMPLETE: barrel + exports map (3cf70af), re-sync (35abe6e), sheet header
      (440af78 + forge 65684d8) [[scenario-forge]]
- [x] **Wire the boards into the adventure build** (2026-09-15, e730a44). They ship as a
      JournalEntry of `corkboard.board` pages inside the Adventure, so importing the adventure
      brings them. Opt-in: without `boards: true` the build is what it was — no folder, no
      dependency. With it, `module.json` declares `relationships.requires: corkboard`, so Foundry
      refuses to enable a module whose board pages would have nowhere to render. AFTERIMAGE end
      to end: 9 journals / 21 handouts / 13 actors / **4 boards** / 175 keys, one CB-04 warning.
      **Two defects the tests found, both invisible to the build:** the player board always
      emitted its zones, so the "nothing to ship" guard the opt-in depends on could never fire;
      and cast link cards looked up portraits under a config key that does not exist, so all four
      shipped faceless. 274 tests [[scenario-forge]]
- [ ] **Day One clue 4 (Danny's arm) is Essential, behind a Spot Hidden roll, with no written
      fallback** — found by CB-04. The house standard says essential clues never live behind a
      search roll; the 13:00 hard trigger is the de-facto fallback but is not written as one [[afterimage]]
- [x] **Corkboard phase 1 for scenario-forge — done** [[corkboard]] (2026-09-15). Barrel +
      `exports` map (3cf70af), re-sync (35abe6e), sheet header (440af78, with forge 65684d8
      putting the scenario's TITLE in the flag — the id alone read "afterimage" where the GM
      expects the name). The framework's Corkboard-side dependencies are all in.
- [x] **Sheet header — a GM can see a board was generated** [[corkboard]] (2026-09-15, 440af78).
      `AFTERIMAGE v3.2.0 — Case board` above the tools, build date + forge + a Re-sync note on
      the hover; nothing on a hand-made board, nothing for a player. `src/board/provenance.mjs`
      is its own module so it can be TESTED — sheet.mjs imports Foundry and cannot be, which is
      how a reference to a class that does not exist survived `node --check` an hour earlier.
      13 tests, 10/11 mutations; the survivor was an unreachable `typeof` guard, removed.
- [x] **Re-sync — a rebuilt scenario reaches a used board without clobbering it** [[corkboard]]
      (2026-09-15, 35abe6e). `resyncPayload` in board-ops, exported through `corkboard/data`; the
      import dialog offers Re-sync or Replace, but only when BOTH boards are generated. One
      checkable invariant does all of it — `sf-` keys are the generator's, every other key is the
      GM's — so a dropped generated card is deleted and a hand-added one is not, with nothing
      inferred. A non-`sf-` key in the INCOMING board is refused, not written: it would land on
      top of whatever the GM keeps there. **Preserved per-entity: geometry, and `hidden`.**
      `hidden` is beyond what the design said and was added deliberately — the case board ships
      every clue hidden and a typo fix between sessions that re-hid eight revealed clues would
      destroy an evening's play, which is the harm re-sync exists to prevent. Surface grows, never
      shrinks. Dangling strings reported via the validator's own `danglingStrings` read off the
      RESULTING board, never pruned. 31 tests, 16/16 mutations killed.
- [x] **scenario-forge acceptance test — PASSED with the boards** (2026-09-15). Built under
      `afterimage-forge`, installed, imported into **Forge Acceptance Test** (Foundry 14.361,
      blade-runner). All four boards import into an `AFTERIMAGE — Boards` folder and
      `page.system.constructor.name` is **`BoardData`** — the data model really constructs, which
      the spike could only infer from reading Foundry's source. Case board renders 19 clues in ACT
      ONE/ACT TWO zones; **Player preview says "Nothing on the board yet."**, so the case board is
      genuinely dark to the table. Ownership chain verified from the documents: pages are
      INHERIT(-1), parent entry is NONE(0) + GM OWNER. All 4 cast link cards resolve to real
      Actors, portraits serve 200. `playerEdit` only on the player board. **Found three things —
      see the log** [[scenario-forge]]
- [x] **Sheet header was missing from the GM's default view** (2026-09-15, corkboard 6caf4d5) —
      found by the acceptance test and by nothing else [[corkboard]]
- [ ] **Cast board: an NPC with no portrait renders as a BLANK polaroid** — `type: "photo"` with
      `img: null` paints no image element, so five of AFTERIMAGE's nine cast cards are empty white
      frames with small text. Legible, looks unfinished. Probably should be a note card, but that
      changes the cast board's look — **your call** [[scenario-forge]]
- [ ] Tidy up after the acceptance test — delete the **Forge Acceptance Test** world,
      `~/FoundryVTT/Data/modules/afterimage-forge`, and `/tmp/afterimage-forge-dist`
      [[scenario-forge]]
- [x] **Five scenarios normalised to the house format** (2026-09-15, 0ad76fd) — all six now 15/15
      canonical sections, and every one registers clues, NPCs, handouts and art [[scenario-forge]]
- [ ] Decide `SM-ART-06-silverstrike` — it was in neither the "still valid" nor the "orphaned"
      list of Silvery Moon's v3 art pass; listed complete for now [[scenario-forge]]
- [ ] Tim's read-through — the handout pack is printed (2026-09-13): 23 sheets, four
      print-only spill pages fixed, `print/AFTERIMAGE-handouts.pdf` [[afterimage]]
- [x] Con print pack rebuilt (2026-09-13) — 117pp, 91MB; AFTERIMAGE plates re-encoded
      to JPEG to clear GitHub's 100MB file limit [[continuum-2026]]
- [ ] Decide the **F2-H02-E** collision — the pack uses it for the night-market plan
      (2026-09-11), the scenario table gave it to the props sheet (2026-09-13) [[afterimage]]
- [ ] Push Masque to Gitea and GitHub — still local only [[masque]]
- [ ] Install BlackHole via `./setup.sh` — required before real Discord use [[masque]]
- [ ] Discord smoke test with a real mic [[masque]]
- [ ] Load-test Blueprint News in a running Foundry world (both modules) [[blueprint-news]]
- [ ] Resolve the Continuum slate count — five games recorded, six slots claimed [[continuum-2026]]
- [ ] Check whether Witchfinder Garrett actually appeared in earlier material [[contingency-2027]]
- [ ] Replace placeholder slot times once Warhorn publishes [[contingency-2027]]
- [x] Install Node + Claude Code on MINI-S — done user-local, no sudo needed [[mini-s]]
- [x] ~~Confirm the outside Foundry admin IPs~~ — resolved: `178.239.163.114` is the Claude-in-Chrome egress, measured [[oneoffgames-vps]]
- [ ] **Rotate both GitHub PATs** — exposed in a session transcript; update `~/.config/github/tokens.env` on MINI-S afterwards [[mini-s]]
- [ ] Once rotated, delete the pre-cleanup backups on MINI-S (`~/.bashrc.bak-*`, `~/.zshrc.bak-*`, `~/.claude/settings.local.json.bak-*`) and let `~/.claude/backups/` age out [[mini-s]]
- [ ] Re-run `install.sh` on MINI-S from an interactive shell after rotating, to register the official GitHub MCP server [[claude-config-sync]]
- [ ] Rotate the Canvas API token — it was shared in chat [[canvas-oss-course]]
- [x] Decide how MINI-S reaches this vault — solved via `claude-config` [[mini-s]]

## Blocked / awaiting a decision

- [ ] iPad storage durability testing [[corkboard]] — the app is now live at https://web.oneoffgames.com/corkboard/app/ (not `corkboard-spike/`), so this is unblocked
- [x] File-exchange validation [[corkboard]] — `.corkboard` bundles both ways, verified in Foundry v14 and the app (2026-09-13)
- [ ] Local-network sync for offline iPads — out of scope for Phase 2 [[corkboard]]
- [x] Publish from the app [[corkboard]] — Publish button + `corkboard-publish` service; filter runs client-side, server refuses unfiltered boards (2026-09-13)
- [ ] Unpublish from the app [[corkboard]] — taking a board down is still `ssh` + `rm`; a DELETE on the same service and auth
- [x] Shared Corkboard slice 1 — accounts, sessions, admin page, live at https://corkboard.oneoffgames.com [[corkboard]] (2026-09-14)
- [x] Shared Corkboard slice 2 — boards, the commit endpoint and the module server; a board renders under a CSP with no `unsafe-inline` [[corkboard]] (2026-09-14)
- [ ] **Sign in once at corkboard.oneoffgames.com and open a board** [[corkboard]] — the one thing slice 2 could not verify; account `tim`, password in `/root/.corkboard-admin` on the box
- [x] Shared Corkboard slice 3 — SSE fan-out; live updates over public HTTPS in 60ms [[corkboard]] (2026-09-14)
- [ ] **Open one board in two signed-in tabs and drag a card** [[corkboard]] — closes both remaining slice 2+3 gaps at once. **Needs a person for the BROWSERS, not for the login**: `beginSession` (`src/web/accounts.mjs:100`) mints a session server-side and `endSession` (:127) revokes it, so authenticating a live proof needs no credential typed and no human. What still needs hands is two real browsers making a real pointer gesture — synthetic pointer events never made the gesture claim. Every earlier note citing "signing in means typing a password into a form" as the blocker was wrong.
- [x] **Phase 5 slice 5 — pictures on a shared board** [[corkboard]] (2026-09-15, 880353a). Upload, content-addressed storage on disk, and `/assets/<digest>` authorised through the SAME filter the board is — `mayFetchAsset` → `assetsFor` → `boardStateFor` — so the picture door and the board door cannot drift apart. The id is the SHA-256 of the bytes the server received; the media type is read from the bytes too. Proved live: viewer 404 / owner 200 on a hidden card's picture, 404 after revocation, 33 of 34 checks (the 34th is nginx answering 400 for `%2F` before the service sees it — recorded with its reason, both layers refuse it). 40 mutations, 32 caught first pass, 6 real gaps closed and re-verified 6/6.
- [x] **§6 stale-base relaxation deployed and proved live** [[corkboard]] (2026-09-15, 6d35c45). Live at `5e42c1c`; 14/14 checks. Deployable without the migration mechanism only because the merged commit is recorded at the CURRENT revision rather than the claimed base, leaving the `(board_id, base)` PK alone. Verified before deploying: 2037 tests, 35/35 against real Postgres, and `git diff` showing no schema change. **`changesSince` had never executed anywhere until that run** — the store suite skips silently without `CORKBOARD_TEST_DATABASE_URL`.
- [ ] **An orphan picture is never reclaimed** [[corkboard]] — an upload that never reaches a card, or a picture on a board somebody deletes, stays in the `assets` index and on disk. **Observed, not assumed:** deleting the slice-5 test board took its grants with it and left both pictures behind. Each upload is capped at 8 MiB; nothing bounds how many. The app answers this with an explicit sweep; the server cannot, because deciding what a *deleted board's* pictures mean is entangled with slice 6's import and export — so it is owed as part of that slice, not as a patch.
- [ ] **Sweep and deploy from a throwaway worktree, not the working tree** [[corkboard]] — `install-web-server.sh` rsyncs `src/` with `--delete` from wherever it runs, and an in-place mutation sweep that copies to `<file>.bak` and restores is invisible to a peer reading the tree. Both failure modes are silent: the restore clobbers their edit, and their edit makes a mutant look like it survived. `git worktree add <tmp> <commit>` costs nothing and needs no lock. Slice 5 deployed this way after the hazard was real.
- [x] **SSH tunnel on port 55432 closed** [[corkboard]] (2026-09-15). It had been open since slice 4 — a localhost-bound route into the production box's Postgres, alive for a day longer than the work that needed it. Reopen only for a run, and close it after: `ssh -f -N -L 55432:127.0.0.1:5432 foundry`.
- [ ] **KEEP the `corkboard_test` role and database** [[corkboard]] — originally listed for tidying away with the tunnel, and that was wrong. It is the only way to run `npm run test:db`, and the Postgres store is **skipped entirely** without it: on 2026-09-15 it was what proved §6's `changesSince` had ever executed, and mutating the real SQL there found that `order by base` is load-bearing and untested. A store suite that silently skips the real store is the instrument problem in a place nobody looks. URL in `/root/.corkboard-test-url` (600) on the box.
- [x] Read-only published board [[corkboard]] — `./publish.sh`, players open `#view/<slug>`; sanitised before it leaves the machine (2026-09-13)
- [ ] Confirm non-official marketplaces auto-fetch on MINI-S [[claude-config-sync]]
- [ ] Decide whether to retire Seafile or Nextcloud [[mini-s]]
- [ ] Generate the iOS project — needs full Xcode + CocoaPods, not on this Mac [[the-director]]

## Someday

- [ ] Enterable hero buildings, more biomes, moving-traffic city look [[mapwright]]
- [ ] Put the five audio apps in git — currently nowhere but disk [[drift]]
