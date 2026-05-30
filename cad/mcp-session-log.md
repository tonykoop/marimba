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
