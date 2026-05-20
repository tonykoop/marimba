# Marimba CAD/DXF Authority Review

Status: pilot traceability check only. This does not promote the packet to
build-ready, L3, CAM-ready, or full-family DXF authority.

Issue #5 asks for reviewed design-table traceability and one pilot DXF check
while keeping the work distinct from the print-plate-specific issue. The
current review scope is the existing `drawings/marimba-pilot-plate.dxf`, which
covers C3, A4, and C6 only.

## Authority Chain

| Artifact | Role | Current boundary |
| --- | --- | --- |
| `cad/design-table-inputs.csv` | Design-table authority for C3-C6 workbook-derived dimensions | Prototype authority until measured tuning revises the schedule. |
| `family-spec.csv` | Family note schedule and resonator estimates | Prediction-level; no measured pitch data is logged yet. |
| `drawings/marimba-pilot-plate.dxf` | Pilot DXF for C3/A4/C6 bar outlines and node locations | Reviewable pilot geometry only; not a full 37-bar export and not CAM-ready. |
| `scripts/validate_marimba_pilot_dxf.py` | Repo-local DXF traceability check | Confirms DXF outline length, width, and node X positions match the design table. |

## Pilot DXF Check

Run from the repo root:

```bash
python3 scripts/validate_marimba_pilot_dxf.py
```

The check verifies:

- DXF units are inches via `$INSUNITS=1`.
- C3, A4, and C6 bar outline bounding boxes match
  `cad/design-table-inputs.csv`.
- C3, A4, and C6 support-node X positions match the same design-table rows.
- DXF labels include the member ID, note, frequency, length, and width.

The check does not verify:

- CAM toolpaths, feeds, speeds, tabs, fixturing, or cutter compensation.
- Underside arch surfaces, resonator fabrication, or frame geometry.
- Measured tuning, cents error, sustain, or resonator coupling.
- The full 37-bar DXF export.

## Issue Boundary

This lane is intentionally separate from the print-plate issue. It validates a
pilot DXF against CAD/design-table inputs and records that boundary in the
authority register. Annotated print plates, rendered assembly pages, and PDF
layout work remain separate downstream deliverables.

## Promotion Gates

Before this packet can claim broader fabrication authority:

- Run and review the C3/A4/C6 pilot loop in `validation.csv`.
- Record measured flat-blank, post-arch, post-sand, resonator-coupled, and
  final-frame pitch results for the pilot bars.
- Review or regenerate the full 37-bar DXF from the same table source.
- Add CAM review evidence before treating any DXF as shop-ready toolpath input.
