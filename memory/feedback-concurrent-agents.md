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
- **Give each agent a disjoint set of files, and say so in the brief** — including which files it must NOT touch and why. Agents that share a file will silently overwrite one another.
- **Warn them that the test count and the failing-test list will move under them**, and name the failures that are already known and not theirs. Otherwise they spend a long time investigating someone else's breakage, or worse, "fix" it.
- **Tell them the scratchpad is shared** — two agents picked the same `check.mjs` filename and one clobbered the other's harness.
- **Verify every claim yourself before acting on it.** Agents miss things and occasionally report fixes that do not reproduce — but they are also sometimes right when you are wrong, so re-measure rather than assuming either way.
- **Hand over a failing test as the spec** where the task is "make X true". It is unambiguous and self-verifying.

Three more that only show up with **separate interactive sessions** (peers, not subagents). The first two were learned 2026-09-12 when two sessions raised a false alarm at each other across `~/Git/corkboard`:

- **Sessions share ONE working tree per repo — they are not separate clones.** So a peer's commit only moves HEAD; the files on disk already held their edits, and anything edited afterwards is necessarily on top of them. A dirty file that a peer also touched is therefore **not** evidence of divergence, and must not be read as one. Check the tree (`git diff HEAD -- <path>`, or grep for the construct you are worried about) before warning anyone to rebase.
- **Git authorship cannot tell you which session made a commit** — every session commits as `slaguru666`, and there is no mapping from a transcript to a `ListAgents` address (`[ref]` values are not session UUIDs, and the desktop session list omits terminal sessions). Asking "is this yours" is the only method, so a broadcast with an ignore-if-not-you opener is a reasonable pattern — expect to receive them and to answer with facts from the tree rather than from memory.
- **Do not repeat a peer's figure back to them.** On 2026-09-13 a peer's fix list gave two numbers side by side; I quoted one back as the figure "a GM actually meets", with more confidence than it had been written with. It was a counterfactual that never occurs in play, and my repeating it is what made it look checked. Recompute from the source before restating, and when you do, compute at **full precision** — I nearly reported their 43.6% as wrong because I blended their rounded percentages instead of the raw proportions; the exact value is 43.637.

**Why:** parallel agents are a big speed-up on independent content work, and every one of these problems appeared in a single session of doing it. **How to apply:** applies to any repo, not just [[loom-app]], where more than one agent is running at a time.
