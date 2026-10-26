---
name: markitdown
description: >-
  Convert documents to Markdown with Microsoft's markitdown CLI — PDF, DOCX,
  PPTX, XLSX/XLS, HTML, CSV, JSON, XML, EPUB, ZIP, images (EXIF) and audio.
  Use whenever the user asks to turn a file into Markdown or ".md", to "make an
  md of" something, to extract the text of a rulebook/PDF/Word/PowerPoint for
  reading or search, or names markitdown.
---

# markitdown

Run it through `uvx` — nothing is installed globally, and the same command works
on every machine that has `uv` (`brew install uv` / `curl -LsSf https://astral.sh/uv/install.sh | sh`).

```bash
uvx --from 'markitdown[all]' markitdown "<input>" -o "<output>.md"
```

Use a narrower extra when only one format is needed (faster first run):
`[pdf]`, `[docx]`, `[pptx]`, `[xlsx]`, `[xls]`, `[outlook]`, `[audio-transcription]`.

## Defaults

- Write the `.md` next to the source with the same basename unless told otherwise.
- Quote paths — downloads often contain spaces.
- Run with `cwd` set to the scratchpad, not the download folder.
- Large PDFs (hundreds of pages) take seconds, not minutes; no need to page through
  them with Read first.

## Check the output before reporting success

```bash
wc -l -w out.md            # non-trivial size?
grep -c '(cid:' out.md     # >0 means a font without a ToUnicode map: garbled text
grep -c '^#' out.md        # headings detected?
```

Read a sample from the start and the middle. Report what the conversion does not
preserve rather than calling it done.

## Known limits

- **PDF → plain text.** No `#` headings, page headers/footers and page numbers
  land inline, multi-column pages and sidebars may interleave, tables flatten,
  images are dropped. If the user needs structure, offer a second pass that adds
  headings from the table of contents.
- **Scanned PDFs** yield nothing — they need OCR (e.g. `ocrmypdf`) first.
- DOCX/PPTX/XLSX convert with real headings and tables; those are the good cases.
