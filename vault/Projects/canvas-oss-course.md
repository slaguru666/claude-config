---
type: project
status: complete
repo: none
path: ~/gema-oss-canvas-course
updated: 2026-09-13
---

# Canvas OSS course

**What it is** — A repeatable, idempotent Canvas-REST-API course builder for an
engineer-onboarding course on a Canvas LMS test server under evaluation.

**Where it lives** — `~/gema-oss-canvas-course/`: `build_course.py`
(`--check`, `--verify`, `--fresh`), `course_content.py` (the curriculum as data),
`README.md`. Config in git-ignored `config.env`. Server `https://canvas.timevans.uk`.

**Current state** — Built. "Implementing the Omnissa Sovereign Solution — Engineer
Onboarding" (OSS-ENG-101): 11 modules, 41 items — 21 pages, 9 classic quizzes with 37
questions, 7 labs plus a capstone, 4 discussions. `--fresh` deletes and recreates, so
the course id increments each rebuild; the latest is id 6.

**Next steps**
- **Rotate the Canvas API token** — it was shared in chat during setup

**Key decisions**
- **Pin `CANVAS_ACCOUNT_ID=1`.** The admin is a Site Admin, so `/accounts` lists
  "Site Admin" (id 2) first; id 1 is the real institution root.
- Visual styling is **inline CSS**, not uploaded images: file upload is broken on
  this server (`/files_api` returns 500) and the sanitiser strips data-URI images —
  but it keeps inline `linear-gradient`. Generated PNGs remain for if upload is fixed.

**Gotchas**
- Classic quizzes must be created unpublished, then have questions added, then be
  published.
- The sanitiser drops `letter-spacing`.
