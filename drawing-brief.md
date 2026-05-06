# Drawing Brief

## Drawing Set

The current packet requires four build-critical drawing classes:

1. Per-bar SVGs generated from `family-spec.csv`.
2. `arch-undercut-section.svg` showing underside relief, edge thickness, center thickness, and tool assumptions.
3. `resonator-layout.svg` showing first-pass tube lengths and note mapping.
4. `frame-overview.svg` showing the frame datum plan, rail concept, bar order, and resonator clearance assumptions.

## Drawing Standards

- Units: inches.
- Primary datum for each bar: left end and centerline.
- Support holes: show `0.224 * L` and `0.776 * L`.
- Bar dimensions: length, width, edge thickness, center thickness, arch depth.
- Resonator dimensions: tube bore, acoustic length, trim allowance, cap style.
- Tolerances:
  - Bar length rough cut: +0.125 in / -0.000 in before tuning.
  - Final length: tune-to-pitch, not dimension-only.
  - Thickness before arch: +/- 0.005 in.
  - Node hole placement: +/- 0.020 in first-pass, improve after pilot data.
- CNC notes: bit diameter, stepover, Z-zero surface, tabs, workholding, and release checks.

## Open Drawing Questions

- Final resonator tube bore and cap style.
- Final frame rail curve and cross-member spacing.
- Bar spacing and accidental/natural row layout.
- Whether the first build uses a temporary validation frame or final furniture frame.

## Source Files

- `family-spec.csv`
- `design.md`
- `marimba-design-table.xlsx`
- `cad/SolidWorks-MasterLayout-Plan.md`
- `cnc/setup-sheet.md`
