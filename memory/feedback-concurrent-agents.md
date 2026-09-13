---
name: feedback-concurrent-agents
description: "Running several coding agents at once: never `git add -A`, give each agent disjoint files, and verify every claim yourself"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 81a1afbb-fc23-4ed9-b787-a664647d8b4e
  modified: 2026-09-09T11:47:34.382Z
---

When several background agents are editing one repo at the same time:

- **Never `git add -A` or `git commit -a`.** It sweeps other agents' half-finished work into your commit under a message that describes something else. This happened once and put 279 lines of three agents' pack data inside a commit labelled "docs". Stage the exact paths you changed.
- ⚠ **Staging exact paths is NOT enough, because the hazard is the FILE, not the pathspec.** `git add <file>` takes the whole file, including a peer's edits to it. On 2026-09-13 I staged two named paths and still shipped eight of another session's eleven hunks under my own commit message. **Read the staged diff — `git diff --cached` — before every commit in a shared tree.** If hunks appear that you did not write, either the commit message must cover them or they must be unstaged.
- **Give each agent a disjoint set of files, and say so in the brief** — including which files it must NOT touch and why. Agents that share a file will silently overwrite one another.
- **Warn them that the test count and the failing-test list will move under them**, and name the failures that are already known and not theirs. Otherwise they spend a long time investigating someone else's breakage, or worse, "fix" it.
- **Tell them the scratchpad is shared** — two agents picked the same `check.mjs` filename and one clobbered the other's harness.
- **Verify every claim yourself before acting on it.** Agents miss things and occasionally report fixes that do not reproduce — but they are also sometimes right when you are wrong, so re-measure rather than assuming either way.
- **Hand over a failing test as the spec** where the task is "make X true". It is unambiguous and self-verifying.

Four more that only show up with **separate interactive sessions** (peers, not subagents). The first two were learned 2026-09-12 when two sessions raised a false alarm at each other across `~/Git/corkboard`:

- **Sessions share ONE working tree per repo — they are not separate clones.** So a peer's commit only moves HEAD; the files on disk already held their edits, and anything edited afterwards is necessarily on top of them. A dirty file that a peer also touched is therefore **not** evidence of divergence, and must not be read as one. Check the tree (`git diff HEAD -- <path>`, or grep for the construct you are worried about) before warning anyone to rebase.
- **Git authorship cannot tell you which session made a commit** — every session commits as `slaguru666`, and there is no mapping from a transcript to a `ListAgents` address (`[ref]` values are not session UUIDs, and the desktop session list omits terminal sessions). Asking "is this yours" is the only method, so a broadcast with an ignore-if-not-you opener is a reasonable pattern — expect to receive them and to answer with facts from the tree rather than from memory.
- **Do not repeat a peer's figure back to them.** On 2026-09-13 a peer's fix list gave two numbers side by side; I quoted one back as the figure "a GM actually meets", with more confidence than it had been written with. It was a counterfactual that never occurs in play, and my repeating it is what made it look checked. Recompute from the source before restating, and when you do, compute at **full precision** — I nearly reported their 43.6% as wrong because I blended their rounded percentages instead of the raw proportions; the exact value is 43.637.
- **Staging exact paths does NOT protect you — read the staged diff before committing.** On
  2026-09-13 a peer's commit titled "artwork prompt sheet" carried eight hunks of my
  uncommitted work. I assumed `git add -A`; the peer checked and it was not — they staged two
  exact paths, all session, as the rule says. **`git add <file>` takes the whole file**,
  including the edits another session made to it, so a pathspec protects nothing once two
  sessions have touched one file. Their commit took the document citing `step5
  unsettledFactor` but not the module exporting it, and `npm run check` passed for them
  *because my uncommitted file was sitting in their tree* — the commit was broken, the working
  copy was not. Two rules, both needed: **`git diff --cached` before every commit**, and prove
  the commit standalone — clone HEAD into a tempdir and run the suite, or `git checkout-index
  -a --prefix=$TMPDIR/`. A green run in your own tree says nothing about what you pushed,
  because your tree contains the thing the commit is missing.

- **I did it to someone else the same night, having already written the rule above.**
  2026-09-13, ~21:31: I staged `git add styles/corkboard.css` — one named path, my own
  file to edit — and shipped eleven lines of another session's in-flight iOS touch CSS
  (`-webkit-touch-callout`, `-webkit-tap-highlight-color`) inside a commit titled "docs:
  say which Foundry the prose-mirror boxes were measured on". Three sweeps happened in
  that repo that night and this was one of them. The rule does not fail because it is
  unknown; it fails because a one-line docs commit does not *feel* like it needs a
  staged-diff check. **`git diff --cached` before EVERY commit means every commit** —
  most of all the small ones. A second cost worth knowing: the commit is now a
  stylesheet change wearing a docs message, so reverting it would silently delete a
  touch behaviour nobody reading the subject line would expect to lose.

**Why:** parallel agents are a big speed-up on independent content work, and every one of these problems appeared in a single session of doing it. **How to apply:** applies to any repo, not just [[loom-app]], where more than one agent is running at a time.
