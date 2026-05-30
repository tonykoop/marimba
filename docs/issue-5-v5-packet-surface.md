# Issue #5 V5 Packet Surface

Status: reviewed scaffold, with CAD/DXF authority pending measurement.

This note records the Round 2 recovery surface for issue #5. It does not
invent CAD geometry, DXF coordinates, tuning frequencies, resonator lengths,
MCP provenance, or measured validation results. It organizes the existing V5
assets so the next reviewer can see which files are traceable and which gates
remain open.

## Authority Chain

1. Workbook-derived packet inputs live in `marimba-design-table.xlsx`,
   `cad/design-table-inputs.csv`, and `family-spec.csv`.
2. `cad/marimba-master.scad` is the current CAD surface. Its authority state is
   `pending_measurement`, not build-ready CAD.
3. `drawings/marimba-pilot-plate.dxf` is the current DXF surface. It covers the
   existing pilot subset only and remains `pending_measurement`.
4. `scripts/validate_marimba_pilot_dxf.py` is a traceability check from the
   pilot DXF back to the design-table rows. It is not CAM review.
5. `validation.csv` is the measurement ledger. The measured fields are empty,
   so no tuning or cents-error authority is claimed.
6. `docs/v5-authority-register.csv` is the issue #5 register for the current
   authority state of each asset.

## Current Permission Boundary

Allowed:

- Use the design tables and pilot DXF for traceability review.
- Use the OpenSCAD file as a concept/prototype CAD surface.
- Run the repo-local DXF traceability script.
- Plan pilot measurements and record them in `validation.csv`.

Not allowed yet:

- Treat the CAD file as native CAD authority.
- Treat the pilot DXF as a full 37-bar export.
- Treat any DXF as CAM-ready toolpath input.
- Claim measured tuning, measured frequencies, cents error, sustain, or
  resonator coupling.
- Generate or backfill dimensions from memory, AI reasoning, screenshots, or
  non-measurement tools.

## Promotion Gates

The packet can move beyond `pending_measurement` only after a future lane
provides real evidence:

- C3/A4/C6 pilot bars measured through the stages already listed in
  `validation.csv`.
- Pilot DXF verified physically by air-cut, print-check, or shop setup review.
- Native CAD or reviewed export produced from the same table source.
- Full-family DXF generated from the reviewed source and registered separately.
- CAM feeds, speeds, tabs, cutter compensation, and workholding reviewed by a
  human or shop-qualified process.

Until then, V5 assets are organized and reviewable, but not fabrication
authority.
