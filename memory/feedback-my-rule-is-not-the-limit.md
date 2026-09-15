---
name: feedback-my-rule-is-not-the-limit
description: "A constraint on how I am allowed to act is not a constraint on what is possible — check what the system can do before reporting something blocked"
metadata:
  node_type: memory
  type: feedback
---

When something looks impossible, check whether the limit is in the **system** or
only in **my own rules of conduct**. They are not the same limit, and I have
reported the second as the first.

2026-09-15, corkboard: I wrote, repeatedly and in the durable record, that a
live authenticated proof of the shared service "needs a person, because signing
in means typing a password into a form". The premise about me is true — I do not
type credentials into forms. The conclusion was false. `beginSession` in
`src/web/accounts.mjs` mints a session token server-side and `endSession`
revokes it; only the hash is ever stored. A peer had been proving things live all
morning that way. My rule closed the login form, not the door.

**Why:** the reasoning felt like carefulness rather than error, which is what
made it durable. It got copied into a project note and a TASKS item as *the*
blocker, so a whole class of verification stayed marked impossible in the shared
record, and the next session to read it would have inherited the same false
blocker with no reason to doubt it. A self-imposed constraint stated as a fact
about the world is worse than a missing note, because it looks settled.

**How to apply:** when about to write "this can't be verified / needs a human",
name which of the two it is. If it is a rule about my own conduct, ask what the
codebase or the API offers instead — a server-side path, a test seam, an admin
call — before recording a blocker. Then say precisely what still needs a person
and why: for the same task it turned out to be *two real browsers making a real
pointer gesture*, which is a genuine limit, and nothing to do with passwords.
Related: [[feedback-check-the-instrument]], [[feedback-guarantee-not-argument]],
[[feedback-verify-the-neighbours]].
