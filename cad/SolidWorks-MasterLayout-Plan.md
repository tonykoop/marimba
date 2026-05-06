# SolidWorks MasterLayout Plan

## Purpose

This folder is a handoff contract for native SolidWorks work. It does not claim a `.SLDPRT` or `.SLDASM` exists yet. The goal is to make the future SolidWorks model deterministic: master sketch, global equations, and design table all use the same variable names as the CSV files in this repo.

## Recommended File Set

```text
MAR-000_MasterLayout.SLDASM
MAR-001_Bar_Master.SLDPRT
MAR-002_Resonator_Master.SLDPRT
MAR-003_Frame_Master.SLDPRT
```

## Configuration Strategy

Use one bar/resonator configuration per `member_id` from `family-spec.csv`.

Primary input table:

```text
cad/design-table-inputs.csv
```

Global variable registry:

```text
cad/sw-global-variables.csv
```

## Master Sketch Hierarchy

```text
MAR-000_MasterLayout
|-- SK_MASTER_TOP_VIEW
|   |-- player_side_datum
|   |-- bass_bar_left_datum
|   |-- natural_row_centerline
|   |-- accidental_row_centerline
|   |-- bass_rail_curve
|   `-- treble_rail_curve
|-- SK_BAR_ENVELOPE
|   |-- bar_length_in
|   |-- bar_width_in
|   |-- node_1_in
|   `-- node_2_in
|-- SK_ARCH_SECTION
|   |-- edge_thickness_in
|   |-- center_thickness_in
|   |-- arch_depth_in
|   |-- arch_length_ratio
|   `-- ball_end_bit_diameter_in
`-- SK_RESONATOR_LAYOUT
    |-- resonator_length_in
    |-- resonator_bore_in
    |-- resonator_mount_clearance_in
    `-- tube_cap_allowance_in
```

## Required Global Variables

Minimum globals:

- `bar_note`
- `midi`
- `target_frequency_hz`
- `bar_length_in`
- `bar_width_in`
- `edge_thickness_in`
- `center_thickness_in`
- `arch_depth_in`
- `node_1_in`
- `node_2_in`
- `cord_hole_diameter_in`
- `resonator_length_in`
- `resonator_bore_in`
- `resonator_mount_clearance_in`
- `tube_cap_allowance_in`
- `bar_spacing_in`
- `natural_row_offset_in`
- `accidental_row_offset_in`
- `frame_rail_width_in`
- `frame_rail_height_in`
- `ball_end_bit_diameter_in`
- `stepover_in`
- `stock_allowance_length_in`
- `tab_allowance_in`

## Feature Notes

- Bar master should expose the top rectangle, side profile, underside arch section, node holes, and optional tab geometry.
- Resonator master should expose tube OD/ID, length, cap/stopper allowance, and mounting clearance.
- Frame master should remain flexible until bar spacing and resonator bore are confirmed.
- Avoid fixing accidental/natural row geometry too early; first validate bar and resonator physics.

## Verification

After native CAD exists, run Tony's SolidWorks dimension extraction macro and compare its CSV against this repo:

```text
cad/dimensions/<date>-MAR-000-dimensions.csv
```

The useful checks are:

- Every global equation has a matching CSV input.
- No feature dimension bypasses the master sketch.
- Node hole positions agree with `family-spec.csv`.
- Resonator length and bore agree with the selected sourcing revision.
