---
type: project
status: active
repo: slaguru666/contingency2027
path: ~/Library/Mobile Documents/com~apple~CloudDocs/RPGS/Conventions/Contingency 2027
updated: 2026-11-03
---

# Contingency 2027

**What it is** — Contingency, **Wed 27 – Sun 31 January 2027**, Searles Leisure
Resort, Hunstanton. Wyrd Sisters Games Club, members-only, Warhorn booking.
**Twelve games across the house 15-slot grid** (morning / afternoon / evening,
three per day). Friday morning, Saturday morning and Sunday evening are clear.

**Where it lives** — `slaguru666/contingency2027`, mirrored under
`RPGS/Conventions/Contingency 2027`.

**Current state — the slate**

| # | Slot | Game | System |
|---|---|---|---|
| 1 | Wed am | The Perpetual Order | CoC **Gaslight** 1895 |
| 2 | Wed pm | [[afterimage]] | Blade Runner |
| 3 | Wed eve | The Six O'Clock Sitting | CoC **Gaslight** 1894 |
| 4 | Thu am | Black Summer: Last Flight Out | TWDU (modified) |
| 5 | Thu pm | Continuous Service | **ALIEN RPG** Cinematic |
| 6 | Thu eve | The London Particular | CoC **Gaslight** 1896 |
| 8 | Fri pm | Viva Voce | CoC 7e **1920s** (Miskatonic) |
| 9 | Fri eve | The Curious Case of Mr Parker's Diary | **Vaesen** |
| 11 | Sat pm | Paper Children | Blade Runner |
| 12 | Sat eve | Closing Weekend | CoC 7e — **modern** (1986) |
| 13 | Sun am | The Favour | Dee Sanction |
| 14 | Sun pm | Provenance | **Outgunned** (1938) |

**The slate was rebuilt on 2026-10-25** and the original spec no longer
describes it. Tim cut **all three DEAD AIR games**, **The New Light** and the
Atlantic City Outgunned heist, moved three survivors to new slots, and added
four new games: an ALIEN hauler, a Miskatonic viva, a revived Vaesen outline
and a 1938 Spain Outgunned game. **Nine systems now, five of them appearing
exactly once.**

The CoC count fell from eight to five: **3 Gaslight · 1 1920s · 1 modern.
No Pulp, no arc.** `archive/` holds eleven cut games; nothing is deleted.

**All twelve are written (2026-11-02).** Eleven went from outline to **v1** in
one pass; AFTERIMAGE was already convention-ready and ports. Every v1 is
self-contained, supersedes its outline, resolves that outline's open questions
in a dated block, and records the new ones that writing it raised. **Desk pass 1 is now complete on all twelve (2026-11-03)** — one document per
game in its `playtest/` dir, cross-game findings in
`docs/playtest-slate-findings.md`. **No fixes applied yet**; the protocol keeps
them to a separate pass with a version bump. Passes 2 (stress re-run) and 3
(player chair) remain. Pregen rosters exist for the nine games needing new
sheets; slots 2, 11 and 13 port theirs.

**The folder shape and the scenario files now exist for all twelve** (2026-11-02),
built by `tools/scaffold_scenarios.py`: seven house subdirs plus two `art/` dirs
per game, a primed `scenarios/<slug>.md` and a `characters/<slug>-pregens.md`.
The primed scenario is not blank — slot, system, setting, player count, tone,
warnings, design intent, plot truth, player experience, cast and open questions
are carried from that game's outline, and each file states that **it supersedes
the outline**: from the first draft on, the outline is a frozen design record,
not a second live copy of the plot. The script never overwrites, so re-run it
when a game is added or renamed.

**Next steps**
- ~~Desk playtest, pass 1~~ and ~~its fix pass~~ — **both done 2026-11-03, all
  twelve. Every game is at v1.1**, one commit each. Next is **pass 2** (stress
  re-run of each game's weakest act) and **pass 3** (player chair, contrarian),
  both against v1.1 — and four things pass 1 could not test at four players:
  slots 3, 6 and 8 **at six**, and slot 4's crowd cards in a real player's hand
- **Regenerate AFTERIMAGE's print artefacts** — the PDF and the three
  `pwa/dist*` trees are build outputs and still carry the old skill name
- **Settle the slot 1 / slot 3 art conflict** — see the decision below; it is
  the only place the repo and the design record disagree
- ~~Finish art generation~~ — **done 2026-11-03: 46 of 46** (`4389d2d`). Every
  game that takes art has its full set; slots 1 and 3 stay art-free by design.
  The last seven were unblocked by **one word each** — see the banned-word
  decision below before adding any new prompt
- ~~Verify Outgunned's success ladder~~ — **closed 2026-11-03**, and since
  re-verified from the printed book; the tag is gone and Jackpot is in the
  crash-course
- ~~Verify The Dee Sanction's step die and Falter~~ — **closed 2026-11-03** from
  the core rulebook, which is on disk
- Replace the placeholder slot times once Warhorn publishes
- Decide whether the Searles rooms seat six (now applies to ten games)
- Decide the 9am Black Summer swap, and whether the convention wants a loud
  Sunday closer

**Key decisions**
- **Desk pass 1, all twelve (2026-11-03): the cases are sound and the
  crash-course blocks are not.** Every case, clue trail and ending survived its
  pass — player-hat ledgers ran 7 to 9 of 10 — while **the system
  crash-course is materially wrong or incomplete in nine of the eleven written
  scenarios.** Correct: TWDU (slot 4) and Outgunned (slot 14). Wrong: the
  CoC critical/fumble band in all five CoC games (one fix, five files);
  Vaesen's Fear die bonus by one die, where **its own pregens are right**;
  ALIEN's missing Panic Roll on a stress symbol; Blade Runner's block, which
  describes a d6 pool for a two-Base-Dice game **while slot 2's ported source
  is entirely correct**; and The Dee Sanction's, which invents a difficulty the
  game does not have and mis-states Falter as failure when it is failing
  forward. **Fix each from the sibling file that is already right** — slot 11
  from slot 2, slot 9 from its own pregens. These are paragraph fixes, not
  rewrites.
- **The fix pass, same day (2026-11-03): all twelve applied, every game v1.1.**
  Recorded in `docs/playtest-slate-findings.md` §9. Three calls worth keeping:
  **(a) shared files were fixed upstream, not sideways** — slot 11's Close
  Combat and slot 2's advantage/disadvantage rule live in `Continuum2026`, so
  they were fixed there as **AFTERIMAGE v3.6**, correcting both games in one
  edit and turning up a frontmatter version three releases stale; **(b) two
  games now stop earlier than the house 2:45** — slot 12 at 2:35 and slot 14 at
  2:40 — because their final acts are forty and thirty-five minutes and cannot
  start at 2:45 and finish by 3:30, which is a stated exception rather than
  drift; **(c) the generated artefacts were flagged, not pretended fixed** —
  the AFTERIMAGE print PDFs and `pwa/dist*` builds still say the old skill name
  and are now a hard requirement in the tracker.
- **Two scaffold rosters became pointer files, not copies (2026-11-03).** Slots
  11 and 13 share their sheets with `Continuum2026`. Each `characters/` file now
  wires those sheets into *this* case — essences as spoken, hooks, the split
  written for these scenes, seat and drop order, what a missing seat costs —
  and says the sheet wins on disagreement. **Copying sheets into a second repo
  is what creates the divergence the shared-sheet rule exists to prevent.**
- **The roster has had the answer four times.** Every scenario claims a
  stand-in GM can run it from that file alone, and four hid a load-bearing
  ruling in the character file: slot 8's **missing Dean**, without whom
  Statute XI's vote counts do not compute and the scenario's own stated design
  point is false; slot 5's agenda collision map; slot 9's telegram fallback
  (four players only) and the correct Fear rule; slot 14's success ladder,
  which the scenario was still flagging as unverified. **Where the two files
  disagree the roster has been right every time.** Check it before filing a
  scenario's arithmetic as wrong — it prevented three incorrect findings.
  See [[feedback-verify-the-neighbours]].
- **Two mechanic-tag vocabularies were invented.** `[BR: Investigation]` is not
  a Blade Runner skill (the book has it twice, both chapter titles) and gated
  three Essential clues; **all six** of THE FAVOUR's `[DEE: …]` tags name
  nothing in The Dee Sanction, which has three Resources and no skill list.
  Slot 14 is the only scenario whose tags are all canonical. The cost is not
  lost clues — it is that when a roll Falters the GM does not know what it
  should cost.
- **A sanity track nobody specified is the slate's quiet pattern.** CLOSING
  WEEKEND charges 2–10 Sanity across an entire slasher and nothing at all for
  the three to six deaths it expects, where the book prices a friend's violent
  death at 0/1D6. THE FAVOUR never mentions Unravelling despite an exhumation
  and a thing in the lead workings. MR PARKER'S DIARY goes the other way:
  four Fear 2 tests expect **3.35 mental Conditions against a budget of 3**,
  and it never names the book's own recovery. **Rule it either way, in one
  line — the gap is the defect, not the number.**
- **Both standing rules questions closed from sources already on disk.** The
  Dee Sanction core rulebook was in `OLD BACKUP/Contingency 2025/`: one
  Resource die, **1 or 2 Falters**, everything else succeeds, difficulty is
  Step-Up/Step-Down and not a target number, and **a Falter is failing
  forward** — so *the system cannot lose an Essential clue*. Outgunned's ladder
  was then verified **from the printed book**: 2/3/4/5 = Basic/Critical/
  Extreme/Impossible, **6+ = Jackpot, "you become the Director for a turn"**,
  pool never below 2 or above 9. **Both were a grep away** — and the Outgunned
  book itself is at **`~/Downloads/Outgunned_Adventure_ENG_1_1.pdf`** (plus a
  `.md` copy), which I missed for a whole pass because the pregen pack says
  *"there is no Outgunned rulebook in this repo or in `~/Library/.../RPGS/`"* —
  true as written, and not an answer to whether the book exists. **Write the
  rulebook's path into each game's sources block.** Re-verifying from the page
  also closed the roster's "one remove from the printed page" item: its two
  requested spot-checks, **Bodyguard** and **Reassure**, match the book clause
  for clause. See [[feedback-scoped-negative]].
- **`tools/playtest_roller.py` now reports VERIFIED for all five systems.**
  Three rules were verified and corrected during the passes: Blade Runner's
  10+ counting as two successes, Dee Sanction's Falter band, Outgunned's
  Jackpot tier and dice bounds. The tool prints VERIFIED or UNVERIFIED per
  roll so a playtest document cannot claim fidelity it lacks.
- **PROVENANCE contradicts its own runtime four lines apart** — Overview says
  "Maximum Runtime: 3 hours 30 minutes play", the timing table ends at **3:35**
  — and all eleven scenarios budget the **whole** 210-minute allowance against
  a house standard asking ~3:15 of content, with four stating a planned figure
  their own timing table disagrees with. The protocol calls a zero-slack run a
  fail. **Take 15 out of Act Two in all eleven** and print each game's existing
  cut list as the default.
- **Slot 2's port notes were a major version behind.** They describe v2.2 with
  three playtests; the source is **3.2.0 with six**, and its own README says
  playtests 01–03 "no longer transfer". The stale figure had propagated into
  `README.md` and the tracker. Its advantage/disadvantage line is also wrong —
  the book adds a third Base Die or removes the lower one, where the scenario
  steps the skill die, so both modifiers deliver ~38% of their force **in the
  chase obstacle table that is the scenario's set-piece**.
- **Slots 11 and 13 have pregen files that are still empty scaffolds**, while
  both scenarios name specific sheets and seams and declare the audit resolved.
  The real sheets exist and are good — AFTERIMAGE's four, and the seven
  *Princes Bride* agents with the **Sanction rhyme** that THE FAVOUR's epilogue
  is built on. Tracker cells corrected from "(shared)"/"(reuse)" to scaffold.
- **Eleven scenarios written to v1 in one pass (2026-11-02).** Each resolves its
  own outline's open questions rather than carrying them forward, which turned up
  three classes of problem worth remembering. **Stale facts from the 2026-10-25
  reshuffle were still live in the outlines**: Slot 1 was written as the
  convention's quiet closer and now opens it Wednesday 9am (design intent and
  Act Three framing rewritten), Slot 6 justified a cold open by being a 9am
  game when it had moved to Thursday evening, and Slot 12 still worried about a
  Thursday between a zombie game and a Berlin 1946 game that was cut.
  **Outlines contradicted themselves**: Slot 5's phase table started Act Three
  at 2:55 while its hard rule said 2:45, and Slot 14's did the same — the hard
  rule wins in both. **And my own arithmetic was wrong in three places** until
  checked: Slot 1 advertised a 7-point Sanity ceiling against a table totalling
  3–12, Slot 3 said "2 at best, 8 at worst" where four entries total 7 and one
  loss was never written at all, and Slot 6's GM Essentials advertised four
  Sanity losses totalling 11 of which exactly one existed anywhere in the
  document. **A figure a document states about itself is a claim, not a
  measurement.** See [[feedback-hold-the-success-line]].
- **Midjourney's filter matches substrings and then never answers — the word was
  `bare`** (2026-11-03). Across 46 jobs every one took **either ~45 s or exactly
  30m01s**, the bridge's own timeout, with nothing in between — so the failure
  is a property of the prompt, not a rate wall. `bare` appears in **6 of the 7
  failing prompts and 0 of the 39 succeeding ones**; the seventh said *"waiting
  four **abreast**"*. Verified by changing **one word** in a twice-failed
  prompt: 42 seconds. **Three expensive lessons.** I rewrote five prompts'
  *subject matter* and kept `bare` in every one — five timeouts, 2.5 hours, no
  information, because **the vocabulary was never diffed against what already
  worked**, which was one free command. Two of my own explanations (prompt
  structure, crowd framing) were falsified by the overnight run. And **a control
  must be a case whose answer you already know**: re-sending another *original*
  could not separate a per-prompt block from an outage; re-sending a **known
  success** settled it in 42 s. Keep original text commented in the queue, never
  overwritten. See [[infra-mj-banned-word-filter]],
  [[feedback-control-needs-known-answer]], [[feedback-check-the-instrument]].
- **Never run two queue runners over one Midjourney queue, and never rewrite the
  queue file under a live one.** Both happened tonight. Two runners cross-match:
  the bridge pairs a result to the job it just sent, so two in flight can save
  the wrong image under the right name. And a shell `while read … done < file`
  loop holds a byte offset — appending rows is safe and is picked up in the same
  run, but truncate-and-rewrite shifts the offset mid-line and nothing errors.
  **To change a live queue: kill, edit, validate row and field counts,
  restart** — which is free because the script skips any asset whose PNG exists.
  See [[infra-dont-edit-a-file-a-process-is-reading]].
- **Slots 1 and 3 stay art-free; the art I generated for them was deleted**
  (Tim, 2026-11-02). They are the slate's ballast — *"no art pipeline"*, *"no art
  budget, no map"*, design intent 5 *"cheap on purpose"*, and `n/a` in the
  tracker's Art column: **four separate records, and I read none of them before
  queueing 10 assets and generating 7.** Every image produced that session was
  for a game that was not supposed to have any. All seven are now removed from
  the worktree and from git, the queue rows stay commented out so a re-run
  cannot regenerate them, and the `n/a` stands as originally written. **The two
  `scenarios/art/` dirs keep their scaffolder README placeholders** — the folder
  shape is uniform across twelve games and empty is the correct state here.
  **The blobs remain in git history: 16.8 MB across 7 objects**, which is why
  `.git` did not shrink. Removing them needs a history rewrite and is not worth
  it on a private repo at this size. The lesson is the cheap one: the design
  record said this in four places and the cost of checking was one grep. See
  [[feedback-read-the-per-game-record]].
- **Research the rules before writing them, and mark what you could not.** Four
  rulebooks were found on disk and read rather than remembered: TWDU core rules
  (I had written that no rulebook existed and called it the slate's one blocking
  item — it was there), the ALIEN core rules, Vaesen, and the Outgunned
  Adventure 1.1 transcription in the Foundry system. Each produced a correction
  that would have shipped otherwise. **ALIEN gives each PC a new Agenda at the
  start of each of the three Acts** — I had written one per session, so
  CONTINUOUS SERVICE now runs an eighteen-agenda per-Act cycle. **TWDU has no
  mechanic called a "Journey"** — it has Challenges and survival mode, and the
  word is now marked house shorthand. **Vaesen's Neck is wrong for THE CURIOUS
  CASE OF MR PARKER'S DIARY for one printed reason** — *"There is only one Neck,
  and he has no other name"*, and that scenario's whole weakness is a name — so
  a custom Ferryman of Hällvattnet was built to the book's own template with the
  rejection cited. **Outgunned Adventure's Run is explicitly "not a chase"**, so
  PROVENANCE's truck chase is built on the Run chassis and says in the text that
  this is a house adaptation. The one rule that could not be cited — Outgunned's
  two-of-a-kind success ladder — carries an `[unverified]` note naming what to
  check. See [[feedback-guarantee-not-argument]].
- **Outgunned Adventure 1.1, not Outgunned core** — settled by the pregens: all
  six PROVENANCE sheets are built to Adventure's Roles and Tropes, so the Run
  replaces core's Chase and every citation is to Adventure.
- **Slot 13's 9am-Sunday risk was fixed structurally, not by moving the game.**
  THE FAVOUR's Act Two is an archive act in the last morning slot of the
  convention, which the outline itself flagged as the wrong shape for a tired,
  half-packed table. It is now six twelve-minute scenes alternating paper and
  dale, built around one handout that fills up in ink on the table — the eleven
  households Anne named from the ladder. **A tired table will do an archive act
  if the archive has a scoreboard.**
- **Player counts, 2026-10-25: Blade Runner 4, everything else 4–6.** The two
  Blade Runner games share one set of four pregens, so four is structural there.
  The range is not free: **ten games must now ship six sheets and still play at
  four**, and the "do the Searles rooms seat six?" question that applied to one
  game now applies to ten. Three games had the old count written into their
  fiction (Black Summer's three boarding chits for five, The Perpetual Order's
  padlock "between the four of you", Closing Weekend's eight counsellors) and
  were rewritten to scale rather than renumbered. Black Summer's chits stay at
  three whatever the table size, so its squeeze varies with who turns up —
  flagged in the outline, not yet playtested.
- **The adverts do not give away the plot** (Tim, 2026-10-25). Six were handing
  over the discovery: the crates' contents, Afterimage's corporate lie, the
  fog-register pattern, Paper Children's whole business, that a Closing Weekend
  PC is the killer, and that someone is alive aboard the *Keelson*. Each now
  states the situation and the question and stops. **The rule is premise yes,
  twist no** — Provenance keeps "they are within their rights" because that is
  the situation; what it withholds is that the 1811 removal was the rescue.
  **One open tension:** cutting Closing Weekend's mask line is right as spoiler
  policy, but if the mask rule is told to the table up front (Decision 4) a
  player arguably needs it before booking. That is consent, not spoiler.
- **DEAD AIR came off the slate on 2026-10-25**, after three outlines and a full
  trilogy bible. It was the slate's only economy of scale — one production with
  three outputs across three consecutive nights. Removing it **made preparation
  harder while leaving the game count at twelve**: nine systems, five appearing
  once. The bible survives in `archive/` and its *Handling the Nazi material*
  constraints were carried into PROVENANCE, which is the only game that still
  needs them.
- **The scaffolder reads the repo rather than restating it** (2026-11-02). Its
  first run reported six missing sections for two games; the cause was that it
  built the outline filename from the slug, and those two files carry a leading
  article (`the-perpetual-order-outline.md`). It had primed both from an empty
  string — a silent, plausible-looking result that only a gap report caught. It
  now globs for `*-outline.md`. The same fault, found by looking: the licence
  footer was a second table inside the script, and had already lost "and Cthulhu
  by Gaslight", "& Alcon Entertainment" and "Paul Baldowski /" — it now reads
  each game's own README. See [[feedback-one-definition-not-two]].
- **The 4–6 decision had not reached the per-game prep lines** (2026-11-02).
  Eight READMEs still asked for 4 or 5 pregens while the slate advertises 4–6;
  corrected to six. CLOSING WEEKEND's "6 + 4 second characters" now has the
  second block in its pregen brief.

- **Shared casts are the load strategy.** Paper Children reuses AFTERIMAGE's four
  pregens, sheets, art and console module untouched. Changing a shared sheet means
  re-auditing both games.
- **The three Gaslight games (1, 3, 6) share a period but deliberately not a
  shape** — Slot 1 is mobile and city-wide, the other two are each a single
  location. Build the handout furniture once.
- **Thursday is no longer three horror games.** The old grind — zombies 9am,
  slasher, Berlin 1946 — was broken by the 2026-10-25 reshuffle: Thursday now
  runs Black Summer, CONTINUOUS SERVICE and The London Particular, and CLOSING
  WEEKEND moved to Saturday night where its comic first ninety minutes no longer
  have to carry a whole day's relief. **This was a side effect of the reshuffle,
  not the reason for it**, but it fixed a known problem.
- **Thirty-six 30-second trailers exist** — twelve games × **16:9, 9:16 and 1:1** —
  built from `tools/trailers/`: a generator, one JSON spec per game, and
  `backdrops.py` holding one procedural plate per game (fog, rain, séance lamp,
  searchlight, VHS, caustics, oscilloscope, microfiche, ruled paper, dust shaft,
  woodcut, tide light — `filament` and `spectrum` are now unused). Seeded noise only, no stock or generated imagery. 50–80s
  to render each. MP4s are **gitignored** (1.1 GB); the specs reproduce them.
  Run `--check` on a spec and `--still <t>` to look at a frame before encoding.
  If a slot time or player count changes, the booking card is baked into each
  spec and all thirty-six need re-rendering. The Warhorn blurbs each link a
  trailer. **All thirty-six were rebuilt on 2026-10-25** for the new slate.
  **There is a real page** at
  `https://web.oneoffgames.com/trailers/contingency-2027/` on the One Off Games
  VPS — that URL is printed on the flyer and answered **403** until 2026-10-25,
  because the folder had the files but no index. Generated by
  `tools/build_trailer_site.py` from the specs + one-pager (`--check` fails if
  stale), published by `tools/deploy_trailer_site.sh`. Videos are
  `preload="none"` behind generated poster frames, so a visit is 13 requests and
  440 KB rather than 252 MB. It uses the convention's look, not the site's
  green-terminal house style — 720p web encodes from `tools/web_encodes.sh`, 243 MB. Deliberately
  **outside `/conventions/`**, which is password protected; see
  [[infra-oneoffgames-vps]].

- **The trailers are scored** (2026-10-26). The original audio was sound design
  — drone, pulse, impact — with no harmony and no motif, which is why it read
  flat. `tools/trailers/score.py` gives each game a mode, a chord progression, a
  voice palette and a motif, pitched from the `root_hz` every spec already
  carried. Twelve distinct beds (organ and music box, CS-80 saws, glass
  harmonica, a Carpenter ostinato for the 1986 slasher, phrygian plucked for
  Spain 1938). **Haunt, Nexus and Esper were the obvious tools and could not do
  it: none of them has any audio export**, and Drift's bounce is a real-time
  capture of the live master. Scoring in numpy keeps the set reproducible from
  text instead of turning twelve WAVs into binary assets.
  Loudness is normalised to **-14 LUFS with loudnorm**, not to peak — twelve
  beds at the same peak measured -10.6 to -12.5 LUFS.
  `--audio out.wav` renders a bed alone in ~3 s; the full 36 is ~45 min.

- **Each game has its own typeface** (2026-10-26). Specs carry
  `fonts: {voice, furniture}` — voice sets title and hook, furniture the
  letter-spaced caps. The three Gaslight games differ on purpose (Big Caslon,
  Didot, Bodoni); the two Blade Runner games match on purpose. Sizes normalise
  on **cap height**, which runs 53–76 across the library, clamped to
  [0.90, 1.15] so normalisation nudges rather than transforms.
  Two faces failed only on inspection, after preflight passed: **Copperplate**
  cannot carry body text (engraved caps — furniture only), and **Trattatello**'s
  calligraphic F meant THE FAVOUR did not read as THE FAVOUR. On an advert,
  legibility beats atmosphere.

- **Two games are deliberately art-free** — The Six O'Clock Sitting and The
  Perpetual Order, both Gaslight, both one location. The slate's ballast; keep
  them cheap.
- AFTERIMAGE is ported, not rewritten.
- Witch Finder **Garratt** (two t's) is canon from *The Princes Bride*
  ([[continuum-2026]]); The Favour runs forward from that game's crossroads
  Tangent scene.

Related: [[continuum-2026]], [[afterimage]], [[rpg-skill]], [[custodians-ringbrp]]
