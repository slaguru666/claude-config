---
name: feedback-scoped-negative
description: "Not in this repo / not in that directory" is a scoped negative, not a global one — finish the unscoped search before accepting that a source does not exist
metadata:
  type: feedback
---

A file I was relying on stated *"There is no Outgunned rulebook in this repo or
in `~/Library/.../RPGS/`"*. True as written. I read it as settling whether the
book existed and verified a whole playtest pass against a transcription
instead. **The book was in `~/Downloads/`.** A broad `find` that would have
found it had been started, allowed to time out at 120 s, and never narrowed and
re-run.

The same session found The Dee Sanction's core rulebook in
`OLD BACKUP/Contingency 2025/...` — a path nobody would have named either. Two
of four rulebooks a project needed were outside every directory anyone had
thought to check.

**Why:** a negative with a scope attached answers a narrower question than the
one being asked, and it reads like an answer. A timed-out search is not a
negative result at all — it is no result, and moving on converts it into a
false one.

**How to apply:** before accepting that a source does not exist, run the
unscoped search and let it finish — narrow it with `-maxdepth`, prune
`node_modules`/`.git`, or background it and come back, but get an actual
answer. Treat "not in X" as a fact about X only. And when a note in the repo
asserts an absence, check what scope it claims before inheriting its
conclusion. Related: [[feedback-read-the-per-game-record]],
[[feedback-check-the-instrument]], [[feedback-my-rule-is-not-the-limit]].
