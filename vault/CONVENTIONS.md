---
type: conventions
updated: 2026-09-13
---

# Conventions

How Tim wants Claude to work. These are corrections he has actually given.
Index: [[INDEX]]

## Git

- **Push in the same turn as the commit.** Do not commit, report, and offer
  the push as a separate step — said explicitly after it happened three times
  in one session. Sessions share one working tree, so an unpushed commit gets
  swept up by whoever pushes next.
- **Never `git add -A` or `git commit -a`** when other agents or sessions are
  running. Stage exact paths. One incident put 279 lines of three agents' work
  inside a commit labelled "docs".
- Before pushing, check `git log origin/<branch>..HEAD` and say what is going
  out — in a shared tree it may include someone else's commits.
- This does **not** extend to PRs, merges or auto-merge. Those still wait.
- **In zsh, `"$ref:src/..."` silently drops everything after the colon.** zsh reads
  `:s` as a history-style substitution modifier on the parameter, so
  `"$ref:src/board/sheet.mjs"` expands to bare `a5e772e` — no error, no warning.
  `git show "$ref:path"` then prints the whole commit (99 KB of message and diff)
  and `git cat-file -p "$ref:path"` returns the commit object (2.6 KB); both hash
  cleanly and look like a plausible file. On 2026-09-13 two sessions produced
  byte-identical wrong md5s this way and spent an evening unable to reproduce each
  other. **Brace it — `"${ref}:path"`** — and verify with
  `git ls-tree -r <ref> -- <path>` then `git cat-file blob <sha>`, checking the byte
  count against `cat-file -s`. bash is unaffected; the shell here is zsh, so this
  applies to any `"$var:suffix"`, not only git.
- Gitea pushes go over **SSH port 2222**. See [[gitea-timevans]].

## Working method

- **Verify before asserting.** Run the command, read the file. An absence of
  errors is not evidence of success.
- Agents and Codex are useful but wrong often enough that every claim gets
  re-measured — including when they contradict you, because twice they were
  right and Claude was wrong.
- Sessions share one working tree per repo. A dirty file a peer touched is not
  evidence of divergence — check the tree before warning anyone.
- Git authorship cannot identify which session made a commit. Asking is the
  only method.
- **No artefact names a session.** Four misattributions in one evening
  (2026-09-13) all came from inferring an actor from a thing: every commit is
  authored `slaguru666`; a deployed file's mtime names only the **last** deploy,
  because `rsync` overwrites; and sessions driving Tim's Chrome share one egress
  IP while their ssh uses another, so one address covers several actors doing
  opposite things minutes apart. Verify a deploy by **content against commits**.
  Ask a peer rather than infer — and when a check you *can* run contradicts a
  peer's account, the fix is a measurement, not a louder account.
- **Never chain a commit off a filtered test run.** `vitest | grep … && git commit`
  commits on *grep's* exit status, which is green whenever the pattern matches
  anything at all — and a `FAIL` pattern matches a failing run more readily than a
  passing one. Read the runner's own status.

## Verifying

- **Brace the variable: `"${ref}:path"`, never `"$ref:path"`.** The shell here is zsh,
  which reads `:s` as a history-style substitution modifier on the parameter and
  silently eats the rest — no error, no warning. `"$ref:src/board/sheet.mjs"` expands to
  just `a5e772e`, so `git show` and `git cat-file -p` each receive a bare commit and
  return the commit's own bytes, which hash to a plausible-looking md5 of the wrong
  thing. Verified 2026-09-13:

      zsh  -c 'ref=a5e772e; printf "%s\n" "$ref:src/board/sheet.mjs"'   -> a5e772e
      bash -c 'ref=a5e772e; printf "%s\n" "$ref:src/board/sheet.mjs"'   -> a5e772e:src/board/sheet.mjs
      zsh, braced "${ref}:src/board/sheet.mjs"                          -> a5e772e:src/board/sheet.mjs

  It generalises past git to any `"$var:suffix"` on zsh — `"$host:$path"` in an scp,
  `"$dir:$port"`, anything of that shape. A literal invocation with no variable always
  worked, which is why this only ever bit inside a loop.
- When a hash still looks wrong, confirm the object: `git ls-tree -r <ref> -- <path>`
  for the blob sha, `git cat-file -s <sha>` for its size, `git cat-file blob <sha>` to
  read it.
- **A guard tested outside the shell options of its host is not tested.** A check whose
  `grep` exits 1 on no-match aborts its host script under `set -e`, and a harness that
  runs it under a plain `bash -c` cannot see that — every case passes while the real
  thing is broken. End such greps with `|| true`, and exercise the guard inside the
  script it will live in, under that script's own options. Applies to anything run from
  a hook, a CI step, or a `set -e` wrapper, which is most things that guard something.
- **Never date a deploy from a deployed file's mtime.** A build that copies a tree
  stamps every file with the latest deploy and erases earlier ones. Compare content.
- **A host's egress is not its browser's egress.** The Claude-in-Chrome extension exits
  from its own address, so `isLocal`, the default route and an ssh source IP say nothing
  about where the driven browser appears to come from. Measure it — fetch an IP echo
  service through the same tool.

## Writing to the vault

Several sessions write these notes at once, and the vault has the **same shared-tree
hazard as the repo** — with none of git's noise, because a whole-file read-modify-write
never conflicts, it just silently wins.

- **`git pull --ff-only` in `claude-config` before editing a note, and again before
  `sync.sh`.** `sync.sh` pushes canonical → repo with `--delete`; a peer's merge sitting
  only in the repo is destroyed by your next sync.
- **Anchor-replace exactly once.** `s.replace(old, new)` with no count replaces *every*
  occurrence, so editing an already-doubled file doubles it again. Use `count=1` and
  assert the anchor appears exactly once first.
- **Re-read the file before appending to it**, rather than trusting the copy you read
  earlier in the session.
- **Check for doubling after an edit.** A repeated `**Section**` heading, or the same
  long line twice, means two writers collided:
  `grep -oE '^\*\*[A-Z][a-z ]+\*\*' <file> | sort | uniq -d`
- **`sync.sh` now refuses a doubled note**, checking canonical before the rsync. It
  names the file and heading, skips only the vault stage, and exits non-zero. If you
  see that refusal, fold the sections — do not reach for
  `--allow-duplicate-headings`, which exists for a note that legitimately repeats a
  heading, not for getting past the guard.
- **`Log/YYYY-MM.md` is the safe target.** Append-only, dated, newest at the bottom:
  three sessions wrote to it concurrently all that evening with no collision. Put the
  narrative there and only the distilled rule in a structured note, because a dated
  append cannot collide with anything.
- **Never `>>` onto a project note.** It lands past the `Related:` footer and outside
  whatever structure the note has. Insert after a named anchor instead.
- **Never create a heading that might already exist.** A section you cannot find may
  mean a peer is adding it right now — put the bullet under the existing heading. This
  rule was written by a session that had just stacked a second vault section beside
  this one while composing it.
- **Fold, do not stack.** If a peer's bullet already covers yours, sharpen theirs or
  drop yours. Two bullets saying one thing is how a note doubles in the first place.
- This happened on 2026-09-13: `Projects/oneoffgames-vps.md` carried two `**Gotchas**`
  sections across five commits, ~2.2 KB duplicated, bullets stranded after the
  `Related:` footer, and nothing complained. Found and merged by another session.

## Infrastructure

- Semaphore → Gitea repository URLs use `http://gitea:3000/tevans/<repo>.git`,
  not the external Cloudflare URL. Same Docker host; avoids DNS/SSL overhead.
- Never hardcode secrets, tokens or tenant identifiers. Name the location of a
  secret, never its value.

## Response shape

- Concise and direct, answer first. No emojis unless asked.
- Reference code as `file:line`.
- Smallest correct change. No opportunistic refactoring, no speculative
  features, no bundled cleanup.
