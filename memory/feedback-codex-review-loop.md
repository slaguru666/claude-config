---
name: feedback-codex-review-loop
description: "Tim's loop: fix, ask Codex to review, fix what it finds, verify live, repeat — and tell a reviewer on a streak not to invent findings"
metadata:
  node_type: memory
  type: feedback
---

Tim runs changes through a loop: **fix → "ask codex to review these fixes" → fix
what it finds → "verify X live" → repeat until a round comes back clean.** He
asked for it six times in one session on 2026-09-13 without ever explaining it,
so treat the next "ask codex to review" as the start of another round, not a
one-off. Run it on `--profile deep`; the balanced default is low reasoning
effort, which is thin for an adversarial pass.

**Why it earns its cost:** across five rounds on the corkboard rebase work it
found six real defects, and **three of them were in things I had written in that
same session** — including a fix whose own test guarded nothing, and two
documents claiming more than they had established. The reviewer is worth most
where I am least able to see: my own fresh work.

**How to apply:**

- Verify every finding against the code before acting on it. Two rounds
  corrected *my* claims rather than the code, and one finding I had to reproduce
  before believing. Reviewers are also wrong.
- Feed the range, not the file — `git diff <last reviewed>..HEAD` — and say what
  the range does and does not change. When a range is documentation-only, say
  so; the question becomes whether the claims are true.
- **Tell a reviewer on a streak that a manufactured finding is worth less than
  nothing.** After four findings in five rounds I said exactly that, and the
  next round came back "no actionable findings" with two honest coverage limits
  instead. Without it the incentive runs the other way.
- Ask it to be adversarial about its *own* previous finding, and about whether a
  fix addressed the right thing.
- Save each round to `docs/reviews/codex-review-N.md` with a short header saying
  what was asked and what the verdict was.
- A finding of "your test doesn't guard this" is usually a design signal, not a
  test bug — twice the right answer was to move state into a testable module
  rather than write more tests around it.

Related: [[feedback-verify-the-neighbours]], [[corkboard-module]],
[[infra-codex-profiles]].
