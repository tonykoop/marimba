# Issue #1 Annotated Print Plate Brief

Status: honest V5 packet surface, pending Photoshop MCP and measurement.

Issue #1 asks for a Photoshop-MCP annotated print-plate test. This lane does
not have Photoshop MCP, CAD measurement tools, physical measurements, or a
reviewed plate export. It therefore scaffolds the plate contract and register
rows only. No CAD geometry, DXF coordinates, tuning frequencies, or measured
dimensions were created in this lane.

## Intended Plate

Planned artifact:

- `print-packet/assembly-plate.pdf`

Current state:

- not generated;
- not Photoshop-reviewed;
- not fabrication authority;
- not evidence of measured tuning or CAM readiness.

The plate should eventually be a print-facing assembly callout sheet for the
existing C3/A4/C6 pilot marimba subset. It should cite existing packet assets
instead of inventing new measurements.

## Required Callout Rows

| callout_id | subject | source artifact | authority | required evidence before promotion |
| --- | --- | --- | --- | --- |
| PP-C3-001 | C3 pilot bar outline and node locations | `drawings/marimba-pilot-plate.dxf`; `cad/design-table-inputs.csv` | pending_measurement | Photoshop MCP session log plus print-check/air-cut review. |
| PP-A4-001 | A4 pilot bar outline and node locations | `drawings/marimba-pilot-plate.dxf`; `cad/design-table-inputs.csv` | pending_measurement | Photoshop MCP session log plus print-check/air-cut review. |
| PP-C6-001 | C6 pilot bar outline and node locations | `drawings/marimba-pilot-plate.dxf`; `cad/design-table-inputs.csv` | pending_measurement | Photoshop MCP session log plus print-check/air-cut review. |
| PP-DATUM-001 | Plate datum, scale, and unit note | `docs/cad-dxf-authority-review.md` | pending_measurement | Human review that the exported page preserves inch units and scale. |
| PP-WARN-001 | Authority warning block | this file; `docs/v5-authority-register.csv` | concept_only | Warning remains visible on any exported proof. |

## Plate Text Requirements

Any future annotated print plate must include these statements:

- "Concept/prototype review only; not CAM-ready."
- "Pilot subset only: C3/A4/C6."
- "Dimensions trace to existing register artifacts; no measured tuning data is
  claimed by this plate."
- "Authority remains `pending_measurement` until validation.csv contains real
  pilot measurements and the print proof is reviewed."

## Visual Direction

Use the existing pilot layout as a background only after a real Photoshop MCP
session imports the source. The plate should show:

- one callout cluster per pilot bar;
- datum/scale note near the title block;
- node callouts that cite the design-table source rather than retyping
  unverified coordinates;
- a visible pending-authority warning block;
- a provenance footer with the Photoshop MCP session id and export timestamp.

## Register Links

- `visual-output-register.csv` row `PP-001` records the future plate artifact.
- `docs/v5-authority-register.csv` rows `PP-001` and `PP-BRIEF-001` record
  the issue #1 authority boundary.
- `cad/mcp-session-log.md` records the required future Photoshop MCP row.

## Retrieval And Provenance

- qmd Step 0 search: `qmd search "marimba" -c instrument-builds` returned the
  May 6 marimba v4.2 handoff plus marimba family-aware design references.
- qmd Step 0 query: `qmd query "marimba tuning packet"` crashed in the local
  node-llama-cpp path under timeout, so it was not used as authority.
- Existing repo artifacts were treated as the only packet evidence for this
  lane.
- No Photoshop MCP, Illustrator MCP, CAD MCP, physical measurement, tuner, or
  image inspection session was available.

## Promotion Gates

The print plate can move from `concept_only` / `pending_measurement` only
after all of the following are true:

1. A real Photoshop MCP session creates or reviews the plate and logs a
   session id in `cad/mcp-session-log.md`.
2. The plate source is tied to existing registered artifacts, not hand-entered
   dimensions.
3. A print-check or air-cut review verifies scale, units, and legibility.
4. `validation.csv` contains real pilot measurements if the plate makes any
   tuning or measured-performance claim.
5. The exported plate is registered with its final path and checksum or
   equivalent provenance note.

Until then, this is a V5 packet surface scaffold, not a fabricated plate.
