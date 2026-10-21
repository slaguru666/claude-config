---
name: feedback-pushed-is-not-deployed
description: "\"Is it on the remote?\" has three answers — git, the files on the machine, and the process serving them; identical version strings across two code bases read as up to date and prove nothing"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 710730ff-4590-4412-82b8-d6ae6765d92b
  modified: 2026-10-21T15:55:00.000Z
---

Asked whether the RingBRP panic rewrite had reached the remote, the git answer was yes and the answer that mattered was no: the server people actually play on held a file copy from a month and ~103 commits earlier, still running the model the user had rejected. **Both copies reported `system.json` version `1.8.1`** — the number had not been bumped through seven content commits — so the one field a person would check to compare them was identical on two different code bases.

Checking git and reporting "pushed" is answering a narrower question than the one asked, and letting it stand as the whole answer is the failure, not the lookup.

**21 Oct 2026 — there is a third answer, and it is the files on disk vs. the process serving them.** The RingBRP pull landed on that VPS, `git status` was clean, the pack data checksummed identical to local — and Foundry went on serving the compendia it had read at startup. Foundry builds its package list when the service starts and the world launches, so a correct checkout is *still* not a deployment. Same shape for anything that loads its content once: a cached template, a preloaded index, a long-lived worker.

**Why:** a deployed copy can be a file copy rather than the checkout the project's own deploy doc assumes, and nothing about the repo reveals that. A matching version string is worse than a missing one, because it reads as confirmation.

**How to apply:** when asked whether something shipped, say which remote. Verify the deployed copy by grepping for a **function or field the new code introduced** (here `panicTargetFor`, and `outOfToken` in `template.json`) and for one the old code had, never by the version. Check whether the deployed copy is even a checkout (`git log` in it). And bump the version in the commit that changes the model, because that is the only signal a server has. Related: [[infra-oneoffgames-vps]], [[feedback-push-after-commit]], [[feedback-check-the-instrument]], [[ringbrp-project]].
