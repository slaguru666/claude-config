---
name: infra-tcc-row-keeps-old-csreq
description: macOS Accessibility/TCC row stays ticked but stops working after an app is re-signed with a different identity; toggling never refreshes the stored code requirement
metadata:
  type: project
---

A TCC (Privacy & Security) row is keyed by bundle id and stores the app's code
requirement at grant time. Re-signing the app (ad-hoc → Developer ID, or any
ad-hoc rebuild, since ad-hoc cdhash changes per build) leaves the row ticked and
ineffective: the app reports `AXIsProcessTrusted() == false`. Toggling the switch
does not update the requirement.

**Why:** Hit on 2026-10-13 with [[keycast]] — one ticked "Keycast" row, app untrusted.

**How to apply:** Remove the row with − and re-add (relaunch → prompt → tick), or
`tccutil reset <Service> <bundle-id>`. Sign with a stable identity from the first
build. To read an app's own verdict run it via `open --stdout <file> App.app`;
running the binary from a shell evaluates TCC under the shell's parent app.
