---
name: feedback-shell-chain-hid-the-failure
description: `grep -c` returning 0 exits non-zero and silently skips the rest of an && chain — the edit never ran and the output looked like a clean pass
metadata:
  type: feedback
---

Never put a `grep` in front of an edit with `&&`. `grep -c` prints `0` and **exits 1** when
there are no matches, so everything after the `&&` is skipped — including the write — while
later commands on their own lines still run and print success. The transcript looks like a
clean pass.

**Why:** applying a scenario fix, I ran `grep -c pattern file && python3 - <<'PY' (the edit) PY`
followed by the guard. The grep found nothing, the edit never happened, and the guard printed
OK — so it read as applied. It was caught only because the next command's output was missing a
line. In the same session the opposite error: a `grep` reported a fix absent when it had landed,
because the text was in capitals and the pattern was not. Both from trusting grep's verdict
instead of looking at the file.

**How to apply:** separate verification from mutation — run the edit on its own, then check the
result with a fresh command. Keep the assertion *inside* the edit script (`assert
s.count(old) == 1`), where a failure raises loudly instead of silently skipping. Treat
`grep -c` as data, never as a gate. When a chain's output seems short by a line, assume a step
was skipped rather than that it was quiet. Related:
[[feedback-check-the-instrument]], [[feedback-assert-where-not-just-what]],
[[feedback-can-the-guard-see-it]].
