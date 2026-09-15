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
- [ ] **Review 32 leftovers** [[corkboard]] — PLAUSIBLE P2: widening changes which fields the witness reads after the await, so an undo can adopt a competitor's write (values reproduced, live timing not). P3: five mutations to sheet.mjs reinstate the defect and still pass the source-text guard — a regex proves text exists, never that the update consumes the policy's output.
- [ ] **`looksResurrected` — needs a decision, not a patch** [[corkboard]] (review 31). Delete cleanup infers from values, so it misses a phantom whose unwritten fields match the schema defaults and deletes a genuine restoration somebody has recoloured. This area has punished value-rules four times.
- [x] **Carry the geometry write policy into the app host** [[corkboard]] (2026-09-15, 2da3f0f). `BoardSession.commit` completes the group before `makeCommit`, so the log stops recording half a shape. **This task's own premise was wrong and measurement corrected it:** slice 4 did not remove the protection, and the app store is not on the multi-writer path at all (`WebSession` has no commit log; `outbox` is empty). There is **no merge point** — `commitToBoard` pre-checks the base and `applyChange` enforces `(board_id, base)` in-transaction, so a racing partial op is refused entirely rather than combined. Verified by driving the real function with two clients at one base: the loser gets `{ok:false, reason:"stale"}`, line still length 20. The fix is justified by the log outliving that protection, not by a live race. `completeGeometry` alone, never `writeThrough` — review 32 measured the cost of the `diff:false` half. Inert on replay, measured. Sweep 5/6, survivor proved inert (completion fills only omitted keys; apply changes only named ones).
- [ ] **Coupled geometry at the merge point, when there is one** [[corkboard]] — spec §6 plans to accept some stale-base commits ("two people dragging different cards do not conflict"). Accepting any of them IS the merge, and that is where a partial `w,h` op lands over ends that have moved. Strict CAS is what closes this in slices 1-4, so nothing is broken today and slice 5 (assets) does not touch it. When that relaxation is designed, completion belongs **inside the merge rule**, not bolted on after — and the app now sends whole groups, so the merge decides about one value instead of four. Do not treat this as a patch to `commitToBoard`; it is a constraint on a design that does not exist yet.
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
- [ ] Tidy up after the acceptance test — delete the **Forge Acceptance Test** world and `~/FoundryVTT/Data/modules/afterimage-forge` [[scenario-forge]]
- [ ] scenario-forge — the four Corkboard boards, plus Corkboard phase 1 (data barrel + exports map, provenance flag, re-sync) [[scenario-forge]]
- [ ] Corkboard phase 1 for scenario-forge: `src/data/index.mjs` barrel + `exports` map, provenance flag, re-sync [[corkboard]]
- [ ] scenario-forge acceptance test — build AFTERIMAGE, import into a scratch world, open the case board (the one thing the spike could not verify) [[scenario-forge]]
- [ ] Normalise the other five scenarios to the house format — real editing, not a script [[scenario-forge]]
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
- [ ] **Open one board in two signed-in tabs and drag a card** [[corkboard]] — closes both remaining slice 2+3 gaps at once
- [ ] Tidy the box after slice 1: drop the `corkboard_test` role and database, close any SSH tunnel on port 55432 [[corkboard]]
- [x] Read-only published board [[corkboard]] — `./publish.sh`, players open `#view/<slug>`; sanitised before it leaves the machine (2026-09-13)
- [ ] Confirm non-official marketplaces auto-fetch on MINI-S [[claude-config-sync]]
- [ ] Decide whether to retire Seafile or Nextcloud [[mini-s]]
- [ ] Generate the iOS project — needs full Xcode + CocoaPods, not on this Mac [[the-director]]

## Someday

- [ ] Enterable hero buildings, more biomes, moving-traffic city look [[mapwright]]
- [ ] Put the five audio apps in git — currently nowhere but disk [[drift]]
