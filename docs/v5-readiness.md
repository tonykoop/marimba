# Marimba V5 Readiness Notes

Current readiness: V5 explorer/prototype scaffold, not a V5 build-packet
candidate yet.

The repo has a strong v4 packet base: workbook-derived note schedule,
OpenSCAD starter, SolidWorks-ready CSVs, SVG drawing previews, CNC operation
planning, print packet, and an explorer page. The missing V5 evidence is
mostly provenance, full export coverage, and measured pilot validation.

## Evidence Present

| Area | Current artifact | Readiness posture |
| --- | --- | --- |
| Parametric CAD starter | `cad/marimba-master.scad` | Prototype geometry starter, not native CAD or CAM verified. |
| Design table | `cad/design-table-inputs.csv`, `cad/sw-global-variables.csv`, `family-spec.csv` | Workbook-derived prototype authority until pilot data revises it. |
| Vector previews | `drawings/*.svg` | Derived previews from the note schedule, not DXF/CAM release. |
| Pilot DXF | `drawings/marimba-pilot-plate.dxf` | C3/A4/C6 layout review only; full 37-bar export still pending. |
| Validation plan | `validation.csv`, `validation-loop.csv`, `cnc/operations.csv` | Measurement-required; no bar tuning results logged yet. |
| Explorer | `explorer.html` | Present and updated with authority/provenance files. |
| Capstone manifest | `capstone-manifest.json` | Repo-relative artifact inventory. |

## V5 Deliverable Gate

| V5 deliverable from issue #2 | Status in this lane | Remaining gate |
| --- | --- | --- |
| Parametric CAD master | Partial | Review/update `cad/marimba-master.scad` so every critical dimension is programmatically traced to the tables. |
| Vector design plate plus DXF | Partial | `drawings/marimba-pilot-plate.dxf` covers pilot bars only; full `drawings/marimba.dxf` remains pending. |
| Hero render | Missing | Create from reviewed CAD/STL and register as non-fabrication. |
| Exploded diagram | Missing | Create from reviewed CAD/STL and register as non-fabrication. |
| AI artistic shots | Missing | Create only as concept/story support; no dimensional authority. |
| Annotated print plate | Missing | Create `print-packet/assembly-plate.pdf` with callouts tied to design-table cells. |
| MCP provenance log | Scaffolded | `cad/mcp-session-log.md` has placeholder rows; future MCP sessions must replace TBD values. |

## Honesty Boundary

- Do not label this repo `V5 build-packet candidate` until the missing V5
  deliverables exist and are logged.
- Do not label tuning as measured or validated until `validation.csv` contains
  measured Hz and cents-error results.
- Do not use generated images or renders as fabrication authority.
- Do not release the full 37-bar CNC sequence until the C3/A4/C6 pilot loop is
  measured and reviewed.
