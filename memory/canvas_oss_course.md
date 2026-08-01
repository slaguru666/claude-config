---
name: canvas-oss-course
description: Canvas LMS test server details + the idempotent course-builder tool for the Omnissa Sovereign Solution training
metadata: 
  node_type: memory
  type: project
  originSessionId: 2eafb1c4-b851-441d-b039-2189d5d33699
---

Canvas LMS test server under evaluation: `https://canvas.timevans.uk` (web admin `admin@timevans.uk`; host SSH `tevans@77.68.99.134`; Canvas runs as a container).

Built a repeatable, idempotent Canvas-REST-API course builder at `~/gema-oss-canvas-course/`:
- `build_course.py` (CLI: `--check`, `--verify`, `--fresh`), `course_content.py` (curriculum as data), `README.md`.
- Config in `config.env` (git-ignored): `CANVAS_BASE_URL`, `CANVAS_API_TOKEN`, `CANVAS_ACCOUNT_ID`.

Course built = id **4**: "Implementing the Omnissa Sovereign Solution - Engineer Onboarding" (OSS-ENG-101). 11 modules / 41 items (21 pages, 9 classic quizzes/37 questions, 7 labs + capstone, 4 discussions).

**Gotchas:** admin is a Site Admin, so `/accounts` lists "Site Admin" (id 2) first — pin `CANVAS_ACCOUNT_ID=1` ("Tim Evans Canvas", the real institution root; sub-account 3 = "Manually-created courses"). Classic quizzes must be created unpublished → add questions → publish. **File upload is broken on this server** — `/files_api` returns 500 — and the HTML sanitizer strips data-URI images, but it KEEPS inline CSS incl. `linear-gradient` (drops `letter-spacing`). So visual styling = CSS gradient hero banners + callout panels rendered inline, not uploaded images (`art_gen.py` PNGs remain for if upload is ever fixed). `--fresh` deletes+recreates so course id increments each rebuild; latest is **course id 6** (default_view=syllabus).

Subject ties to the [[gema-training-ideas]] project: Omnissa Sovereign Solution = Workspace ONE UEM delivered with GEMA as regional hosting/support partner, with BYOK + Desired State Management as sovereignty controls.

**Security:** the access token used was shared in chat — rotate it in Canvas after evaluation.
