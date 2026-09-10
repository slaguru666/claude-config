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

**Why:** parallel agents are a big speed-up on independent content work, and every one of these problems appeared in a single session of doing it. **How to apply:** applies to any repo, not just [[loom-app]], where more than one agent is running at a time.
