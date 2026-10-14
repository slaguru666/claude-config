---
name: feedback-pushed-is-not-deployed
description: "\"Is it on the remote?\" has two answers — git and the machine it runs on; identical version strings across two code bases read as up to date and prove nothing"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-10-14T17:45:39.035Z
---

Asked whether the RingBRP panic rewrite had reached the remote, the git answer was yes and the answer that mattered was no: the server people actually play on held a file copy from a month and ~103 commits earlier, still running the model the user had rejected. **Both copies reported `system.json` version `1.8.1`** — the number had not been bumped through seven content commits — so the one field a person would check to compare them was identical on two different code bases.

Checking git and reporting "pushed" is answering a narrower question than the one asked, and letting it stand as the whole answer is the failure, not the lookup.

**Why:** a deployed copy can be a file copy rather than the checkout the project's own deploy doc assumes, and nothing about the repo reveals that. A matching version string is worse than a missing one, because it reads as confirmation.

**How to apply:** when asked whether something shipped, say which remote. Verify the deployed copy by grepping for a **function or field the new code introduced** (here `panicTargetFor`, and `outOfToken` in `template.json`) and for one the old code had, never by the version. Check whether the deployed copy is even a checkout (`git log` in it). And bump the version in the commit that changes the model, because that is the only signal a server has. Related: [[infra-oneoffgames-vps]], [[feedback-push-after-commit]], [[feedback-check-the-instrument]], [[ringbrp-project]].
