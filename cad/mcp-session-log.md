# Marimba MCP Session Log

Current status: no MCP sessions were run or verified in the Round 30 lane or
the Round 2 issue #1 recovery lane.

This log exists so future V5 work can attach provenance before promoting the
packet to a V5 build-packet candidate. Existing workbook, OpenSCAD, SVG, PDF,
and explorer artifacts are useful packet assets, but this file does not claim
that they were produced by a traceable MCP session.

| timestamp_utc | tool | session_id | artifact | parent_artifact | role | authority | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| TBD | OpenSCAD MCP | TBD | `cad/marimba-master.scad` or exported STL | `cad/design-table-inputs.csv` | parametric CAD | prototype authority after review | Future session must confirm no magic numbers and trace dimensions to `family-spec.csv`. |
| TBD | Blender MCP | TBD | `images/hero-render.png` | reviewed OpenSCAD STL | render preview | non-fabrication | Future render only; does not prove dimensions. |
| TBD | Blender MCP | TBD | `images/exploded-diagram.png` | reviewed OpenSCAD STL | exploded diagram | non-fabrication | Future diagram only; callouts must cite design-table cells. |
| TBD | Illustrator MCP | TBD | `drawings/marimba.svg` and `drawings/marimba.dxf` | `family-spec.csv`; `cad/design-table-inputs.csv` | vector plate | fabrication after review | Full 37-bar vector export remains pending. |
| TBD | image-gen-2 / Adobe MCP | TBD | `images/family-group.png`; `images/macro/*.png` | design notes | concept imagery | non-fabrication | Concept-only; no cut-ready dimensions or toolpaths. |
| TBD | Photoshop MCP | TBD | `print-packet/assembly-plate.pdf` | `drawings/marimba-pilot-plate.dxf`; `cad/design-table-inputs.csv`; `docs/issue-1-annotated-print-plate-brief.md` | annotated print plate | pending_measurement | Issue #1 future row only. Callouts must cite registered artifacts; no Photoshop session was available in this lane. |
| 2026-07-01 | claude-code (Fable 5) | fable-v5-refresh-2026-07-01 | `README.md` | design.md, README's own prior "Readiness: L1" prose | packet_refresh | concept_only | V5 refresh pass: added a validator-parseable `Status: L1 concept packet` line to README.md (repo had no line matching the V5 Status regex before — only a "**Readiness: L1**" heading). No dimension or readiness-level change; kept existing L1/"not a V5 build-packet candidate" language as-is. Verified existing `cad/marimba-master.scad` still renders: `openscad -o /tmp/marimba-check.stl cad/marimba-master.scad`, exit 0. Did NOT rewrite the master (repo already has a real, non-placeholder master per the percussion addendum's EXISTING MASTERS rule). |
| 2026-07-01 | claude-code (Fable 5) | fable-v5-refresh-2026-07-01 | none — deferred | visual-output-register.csv | provenance_gap_note | n/a | `visual-output-register.csv` has no row for `marimba-starter.wl` / `wolfram/marimba-wolfram-model.wl` / `wolfram/instrument-model.wl` (duplicate of the latter). A register row should be added, but `visual-output-register.csv` had an uncommitted, not-mine change (one added row for `images/family-group.png`) at the start of this session — per the V5 refresh dirty-repo rule, this pass did not stage or modify that file to avoid committing someone else's uncommitted work. Follow-up: commit or triage the pending `images/family-group.png` row first, then add WL-* rows for the three Wolfram files. |
