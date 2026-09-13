---
name: feedback-push-after-commit
description: "Push immediately after every commit — don't commit and then offer to push separately"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 4c6c6592-cb70-4a13-af73-1b5771ce78c2
  modified: 2026-09-12T22:24:24.834Z
---

When Tim asks for a commit, **push it in the same turn.** Do not commit, report, and then
offer the push as a separate step for him to authorise — he said so explicitly on
2026-09-12 after it happened three times in one session.

**Why:** several Claude sessions share one working tree per repo (see
[[feedback-concurrent-agents]]). A commit left unpushed gets swept up by whichever other
session pushes next — twice in that session another session's push carried a commit of
mine to the remote on its schedule rather than on Tim's. Holding the push does not keep
the work local, it just hands the timing to someone else.

**How to apply:**

- `git push` follows `git commit` without waiting to be asked again.
- Still stage exact paths, never `git add -A` — the shared tree usually has another
  session's work dirty in it.
- Before pushing, check `git log origin/<branch>..HEAD` and say what is actually going
  out. In a shared tree that may include another session's commits, which is worth
  naming rather than pushing silently.
- Gitea pushes go over SSH port 2222 — see [[infra-gitea-timevans]].
- This does not extend to anything else outward-facing: opening PRs, merging, or
  enabling auto-merge still wait to be asked.
