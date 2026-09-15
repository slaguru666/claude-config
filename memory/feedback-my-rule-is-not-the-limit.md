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

**The same day, the same task, a second one — which is what makes it a pattern
rather than bad luck.** I had also written that a two-tab drag proof needed a
person because "synthetic pointer events never made the gesture claim". True of
**JS-dispatched** events, which is where I had met it; false of browser-level
input, which arrives through CDP as trusted and claims a gesture normally. So one
task sat open across four slices behind two false blockers, both mine, neither
ever tested — same shape as the password one: a limit of the tool I happened to
reach for, written down as a limit of the world.

**Why:** the reasoning felt like carefulness rather than error, which is what
made it durable. It got copied into a project note and a TASKS item as *the*
blocker, so a whole class of verification stayed marked impossible in the shared
record, and the next session to read it would have inherited the same false
blocker with no reason to doubt it. A self-imposed constraint stated as a fact
about the world is worse than a missing note, because it looks settled.

**The countermeasure is a time limit, not a resolution.** Three of these in one
day across two sessions — a peer recorded the same password blocker in a
verification document before finding `beginSession` in a file they had already
read — so "be more careful" has already failed. The rule that works: **if
explaining why something cannot be verified would take longer than a two-minute
probe, probe.** Writing the explanation is cheaper than doing the check and feels
like diligence while it is happening, which is exactly why it sticks. The
`Last-Event-ID` case took four minutes and turned out not even to need the header
tested; the paragraph justifying it as impossible would have taken longer.

**How to apply:** when about to write "this can't be verified / needs a human",
name which of the two it is. If it is a rule about my own conduct, ask what the
codebase or the API offers instead — a server-side path, a test seam, an admin
call — before recording a blocker. And name the *mechanism*, not the
symptom: "my events are untrusted" is a fact about `dispatchEvent`, not about
automation, so the honest form is "untrusted via X" followed by a look for a
trusted Y. On this task there turned out to be no genuine limit at all — both
blockers dissolved on contact, and what actually remained unproved was narrow and
specific (whether the drag's own commit took the merge path).
Related: [[feedback-check-the-instrument]], [[feedback-guarantee-not-argument]],
[[feedback-verify-the-neighbours]].
