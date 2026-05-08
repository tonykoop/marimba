# Marimba CNC Bar And Resonator Build Packet Print Packet

Generated: 2026-05-06
Packet folder: `/mnt/c/Users/Tony/Documents/GitHub/marimba`

## File Map

| File | Purpose |
| --- | --- |
| `design.md` | Project intent, catalog metadata, assumptions, and validation plan. |
| `bom.csv` | Starter bill of materials with part categories, quantities, drawing refs, and notes. |
| `sourcing.csv` | Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks. |
| `cut-list.csv` | Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts. |
| `drawing-brief.md` | Manufacturing drawing and technical product sketch brief. |
| `assembly-manual.md` | Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes. |
| `validation.csv` | Target/measured values, tolerance, environment, result, and tuning/build action log. |
| `supplier-rfq.md` | Supplier email/request-for-quote starter. |
| `visual-bom-brief.md` | Art direction for an image-forward visual BOM. |
| `jig-decision.md` | Fixture decision record and pilot jig release gates. |
| `README.md` | Project artifact. |
| `family-spec.csv` | Project artifact. |
| `photo-shotlist.md` | Project artifact. |
| `risks.md` | Project artifact. |

<div class="page-break"></div>

## design.md

Project intent, catalog metadata, assumptions, and validation plan.

# Marimba Design Packet

## Project Intent

Build a 37-bar C3-C6 marimba packet from the existing workbook design table. The first build target is a CNC-friendly instrument with African Padauk bars, parabolic underside arch undercuts, drilled node supports, quarter-wave resonators, and a frame layout that can become a SolidWorks master sketch.

The useful boundary for this packet is "build-ready documentation, not finished CAD." Native SolidWorks files do not exist yet. The CAD folder defines the global-variable and design-table contract Tony can use to build the real model.

## Design Intake

| Field | Value |
| --- | --- |
| Instrument | Marimba |
| Instrument family | Free-free beam idiophone with tuned quarter-wave resonators |
| Active build range | C3-C6 chromatic, 37 bars |
| Source workbook | `marimba-design-table.xlsx`, sheet `Marimba`, range `A1:X106` |
| Primary material | African Padauk bars, workbook K constant `155502` |
| Bar thickness | `0.875 in` nominal edge thickness |
| Minimum center thickness | `0.250 in` after arch undercut |
| Construction pipeline | CNC surfaced blanks, 3D arch undercut, profile/tabs, node drilling, resonator cutting, frame assembly |
| Done-bar reference | `tongue-drum` README and wooden idiophone validation discipline |

The guided v4.2 intake artifacts are in `data/design-intake.json` and `data/design-input-row.csv`.

## Governing Model

### Bar Pitch

The marimba bars are treated as free-free beams. The first flexural mode uses:

```text
lambda_1 = 4.730
f_1 = (lambda_1^2 / (2*pi*L^2)) * sqrt(E*I/(rho*A))
```

The workbook uses the practical shop form:

```text
f ~= K * t / L^2
L ~= sqrt(K * t / f)
```

where:

- `f` is target frequency in Hz.
- `K` is the material-specific free-free bar constant.
- `t` is nominal bar thickness at the edge.
- `L` is bar length.

For the active packet:

```text
K = 155502
t = 0.875 in
```

The workbook material library derives this free-free K from the beam material properties and the `lambda_1 = 4.730` mode shape. Do not apply flute-bore K2 corrections here; those belong to Native American style flute bore correction work, not beam idiophones.

### Nodes And Supports

The suspension node locations are:

```text
node_1 = 0.224 * L
node_2 = 0.776 * L
```

Cord holes and rail pins reference these two locations. Holes must be drilled at the nodal line so the support does not damp the main mode.

### Arch Undercut

The workbook defines a linear MIDI-scaled arch-depth schedule:

```text
arch_depth = (edge_thickness - min_center_thickness) * min(1, (96 - midi)/48)
center_thickness = edge_thickness - arch_depth
```

This makes the low bars carry the deepest undercut and the high bars approach a shallow arch. The current minimum center thickness is `0.250 in`, so C3 reaches the minimum while C6 remains about `0.719 in` at center.

The arch should be cut as a centered parabolic underside relief over roughly 60 percent of the bar length. Final voicing still requires controlled sanding and tuner checks; the workbook is the first-pass schedule.

### Resonators

The resonator tubes are treated as quarter-wave closed pipes:

```text
L_res = 13552 / (4 * f) - 0.82 * bore
```

The sheet currently uses the bar-width column as the resonator bore/end-correction proxy. That is acceptable as a first-pass planning value, but the sourcing pass should decide real tube diameters and update `family-spec.csv` if the selected bore differs from the workbook proxy.

The distinction is important:

- Bar pitch is tuned by bar length, thickness, arch geometry, and material.
- Resonator length is tuned to reinforce the already-tuned bar frequency.
- A resonator mismatch changes sustain/loudness/color; it does not fix a wrong bar pitch.

## Bar Schedule

The full schedule is in `family-spec.csv`. Representative rows:

| Note | MIDI | Target Hz | Length in | Width in | Node 1 in | Node 2 in | Arch in | Center in | Resonator in |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| C3 | 48 | 130.813 | 32.251 | 2.000 | 7.224 | 25.027 | 0.625 | 0.250 | 24.260 |
| C4 | 60 | 261.626 | 22.805 | 1.750 | 5.108 | 17.697 | 0.469 | 0.406 | 11.515 |
| A4 | 69 | 440.000 | 17.585 | 1.750 | 3.939 | 13.646 | 0.352 | 0.523 | 6.265 |
| C6 | 84 | 1046.502 | 11.403 | 1.250 | 2.554 | 8.848 | 0.156 | 0.719 | 2.212 |

## Resonator Schedule

`family-spec.csv` includes a first-pass tube length for every note. Treat these as cut-long values until a tube material, bore, cap style, and stopper/trim strategy are selected.

Recommended build behavior:

1. Cut resonators at least `0.5 in` long for C5 and above, and at least `1.0 in` long below C5.
2. Use adjustable caps or removable plugs for the first build.
3. Tune resonators after the bars are struck and measured in the frame.
4. Record final tube length and cents response in `validation.csv`.

## Hardware Alignment

The support rails follow the node path rather than a fixed straight rail. For each bar:

- Left support: `node_1_in`.
- Right support: `node_2_in`.
- Cord/support hole diameter: `0.250 in` starting point.
- Frame pin/rubber support must touch at the node, not at the bar end.
- Bar spacing and frame taper are `TBD` until mallet clearance and resonator tube diameters are chosen.

## SolidWorks MasterLayout Plan

The SolidWorks model should be driven from a master sketch and equations:

1. A `Master_Bar` part with configurations from `cad/design-table-inputs.csv`.
2. A `Master_Resonator` part with tube length, bore, cap allowance, and mounting hole variables.
3. A `Frame_MasterLayout` sketch defining bass and treble rail curves, bar spacing, resonator centerlines, and player-side datum.

Do not model hand-edited dimensions in SolidWorks. Every repeated note configuration should be driven by the variables listed in `cad/sw-global-variables.csv`.

## Open Assumptions

- Active packet uses C3-C6 instead of the workbook's full C2-F6 or portable C4-F6 variants.
- African Padauk is the workbook-selected material; actual board availability and moisture content are not verified.
- Resonator tube material and exact bore are `TBD`; current resonator lengths use the workbook width/end-correction proxy.
- Frame geometry, rail spacing, bar spacing, and transport strategy need CAD and ergonomic review.
- CNC feeds/speeds are starting notes only; final CAM must use the actual bit, router, hold-down, stock, and simulation.
- No measured bar data exists yet, so all frequencies are target predictions.

## Validation Plan

1. Surface three sacrificial bars first: C3, A4, and C6. These bound the length, arch, and treble-end assumptions.
2. Measure blank thickness, length, density estimate, and moisture content before cutting the arch.
3. Record flat-bar pitch, post-arch pitch, post-sanding pitch, and final assembled pitch.
4. Update `validation.csv` with measured Hz and cents error:

```text
cents = 1200 * log2(measured_hz / target_hz)
```

5. If the C3/A4/C6 pilot set misses by more than +/- 15 cents before final sanding, update the K constant or arch schedule before cutting the remaining 34 bars.
6. Tune resonators only after bars are within the target tuning window.

## Provenance

- Source workbook: `marimba-design-table.xlsx`, generated before this v4.2 packet run.
- Skill workflow: `instrument-maker-v4` v4.2.
- Reference family: `cantilever-idiophone` in `repo-relationships.yaml`; marimba notes call out bar tuning plus resonator coupling.

<div class="page-break"></div>

## bom.csv

Starter bill of materials with part categories, quantities, drawing refs, and notes.

| item | subassembly | part_name | qty | unit | material_or_spec | make_buy | status | notes |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | Bar set | C3-C6 tuned bars | 37 | ea | African Padauk 7/8 in nominal edge thickness | make | workbook-derived | Individual dimensions in family-spec.csv. |  |  |  |
| 2 | Resonators | C3-C6 resonator tubes | 37 | ea | PVC or aluminum tube; bore TBD by sourcing | buy | TBD | Lengths in family-spec.csv are first-pass quarter-wave values using workbook bore proxy. |  |  |  |
| 3 | Resonators | Tube caps or adjustable stoppers | 37 | ea | Matched to selected tube bore | buy | TBD | Use adjustable closure for first validation build. |  |  |  |
| 4 | Frame | Bass-side rail | 1 | ea | Hard maple or laminated hardwood | make | TBD | Final length and curve depend on CAD frame layout. |  |  |  |
| 5 | Frame | Treble-side rail | 1 | ea | Hard maple or laminated hardwood | make | TBD | Must follow support nodes or carry adjustable posts. |  |  |  |
| 6 | Frame | Cross members | 4 | ea | Hardwood or plywood fixture stock | make | TBD | Temporary shop frame acceptable for validation build. |  |  |  |
| 7 | Hardware | Support cord | 1 | roll | Low-stretch braided cord or synthetic marimba cord | buy | TBD | Size to match 1/4 in node holes and rubber isolators. |  |  |  |
| 8 | Hardware | Rubber support tubing or grommets | 74 | ea | Rubber or silicone isolation supports | buy | TBD | Two supports per bar minimum. |  |  |  |
| 9 | Hardware | Frame fasteners | 1 | set | Wood screws |  threaded inserts |  washers | buy | TBD | Prefer removable fasteners for tuning access. |  |
| 10 | CNC tooling | 3/4 in ball-end mill | 1 | ea | Hardwood-capable ball-end cutter | buy | TBD | Primary arch undercut tool for bass/mid bars. |  |  |  |
| 11 | CNC tooling | 1/2 in ball-end mill | 1 | ea | Hardwood-capable ball-end cutter | buy | TBD | Alternative or treble arch finish tool. |  |  |  |
| 12 | CNC tooling | 1/4 in downcut spiral | 1 | ea | Hardwood-capable router bit | buy | TBD | Bar profile cleanup and fixture pockets. |  |  |  |
| 13 | CNC tooling | 1/8 in upcut spiral | 1 | ea | Hardwood-capable router bit | buy | TBD | Small reliefs |  pilot features |  or templates. |  |
| 14 | Finish | Sanding and finish consumables | 1 | set | 80-320 grit abrasives plus oil/shellac/lacquer TBD | buy | TBD | Finish must not load bar underside or node areas. |  |  |  |
| 15 | Measurement | Tuning and data capture | 1 | set | Chromatic tuner |  microphone |  calipers |  scale | buy/owned | TBD | Needed for validation.csv completion. |

<div class="page-break"></div>

## sourcing.csv

Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks.

| item | stable_spec | supplier_candidates | current_price_status | lead_time_status | verification_needed | notes |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| African Padauk lumber | Clear straight-grain stock at least 34 in long and 7/8 in final thickness; quartersawn preferred | Local hardwood dealer; Woodcraft; Rockler; specialty tonewood supplier | not verified | not verified | Verify board width/defect-free yield before purchase | Buy enough extra for C3/A4/C6 pilot bars and tuning failures. |  |  |  |
| Alternative bar lumber | Hard maple or cherry at 7/8 in final thickness | Local hardwood dealer; Woodcraft; Rockler | not verified | not verified | Verify K constant before substituting | Use only for material study or education build |  not direct swap without validation. |  |  |
| Resonator tube stock | PVC or aluminum tubes in selected bores from about 1.25-2.00 in or revised bore set | McMaster-Carr; local plumbing supplier; OnlineMetals | not verified | not verified | Verify ID/OD |  wall thickness |  cap availability |  and cut length | Current workbook lengths use a bore proxy; update after selecting tube sizes. |
| Tube caps/stoppers | Adjustable or removable closed end matching tube ID | McMaster-Carr; plumbing supplier; 3D printed plugs | not verified | not verified | Confirm air seal and tuning adjustability | Prototype with removable caps before permanent end caps. |  |  |  |
| Frame hardwood | Hard maple or stable hardwood rail stock | Local hardwood dealer | not verified | not verified | Confirm straightness and final rail length | Frame geometry is still CAD-driven TBD. |  |  |  |
| Support cord | Low-stretch braided synthetic cord sized for 1/4 in support holes | Music hardware supplier; climbing accessory cord supplier | not verified | not verified | Confirm diameter and stretch | Must not buzz against bar holes. |  |  |  |
| Rubber supports | Silicone/rubber tubing or grommets sized to isolate bars | McMaster-Carr; marimba parts supplier | not verified | not verified | Confirm durometer and fit | Two supports per bar minimum. |  |  |  |
| CNC ball-end bit | 3/4 in carbide ball-end mill suitable for hardwood | Amana; Whiteside; Onsrud; local tooling supplier | not verified | not verified | Verify shank |  flute length |  machine collet |  and feeds/speeds | Use actual bit geometry in CAM. |
| CNC downcut bit | 1/4 in carbide downcut spiral for clean top edges | Amana; Whiteside; Onsrud | not verified | not verified | Verify cut length and chip evacuation | Profile passes need tabs or fixture retention. |  |  |  |
| Finish | Thin oil/shellac/lacquer finish compatible with tuned bars | Wood finishing supplier | not verified | not verified | Test on offcuts for pitch shift | Heavy finishes can detune/damp bars. |  |  |  |

<div class="page-break"></div>

## cut-list.csv

Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts.

| cut_id | subassembly | qty | material | rough_dimension_in | finished_dimension_or_reference | operation | notes |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| CUT-BAR-BASS | Bars C3-B3 | 12 | African Padauk | 34.0 x 2.25 x 1.00 each max rough blank | See MAR-C3 through MAR-B3 in family-spec.csv | Surface/thickness/profile/arch/drill | Long bars are the stock-yield driver; cut long and tune down. |  |
| CUT-BAR-MID | Bars C4-B4 | 12 | African Padauk | 24.0 x 2.00 x 1.00 each max rough blank | See MAR-C4 through MAR-B4 in family-spec.csv | Surface/thickness/profile/arch/drill | Keep grain direction consistent across the octave. |  |
| CUT-BAR-TREBLE | Bars C5-B5 | 12 | African Padauk | 17.0 x 1.75 x 1.00 each max rough blank | See MAR-C5 through MAR-B5 in family-spec.csv | Surface/thickness/profile/arch/drill | Smaller arch depths need careful Z-zero discipline. |  |
| CUT-BAR-TOP | Bars C6 | 1 | African Padauk | 12.5 x 1.50 x 1.00 rough blank | See MAR-C6 in family-spec.csv | Surface/thickness/profile/arch/drill | High bar is short and sensitive to over-sanding. |  |
| CUT-RES-BASS | Resonators C3-B3 | 12 | PVC or aluminum tube | Cut 1.0 in oversize from family-spec.csv lengths | Final trim after bar tuning | Tube cut/deburr/cap/drill | Use selected tube bore |  not blindly the workbook bore proxy. |
| CUT-RES-MID | Resonators C4-B4 | 12 | PVC or aluminum tube | Cut 0.75 in oversize from family-spec.csv lengths | Final trim after bar tuning | Tube cut/deburr/cap/drill | Mark each tube with note and target Hz. |  |
| CUT-RES-TREBLE | Resonators C5-C6 | 13 | PVC or aluminum tube | Cut 0.5 in oversize from family-spec.csv lengths | Final trim after bar tuning | Tube cut/deburr/cap/drill | Very short tubes may need larger bore or box coupling review. |  |
| CUT-RAIL-BASS | Frame bass rail | 1 | Hard maple or laminated hardwood | TBD | Node-following rail curve from CAD | Rip/plane/CNC drill | Do not freeze until bar spacing and tube diameters are selected. |  |
| CUT-RAIL-TREBLE | Frame treble rail | 1 | Hard maple or laminated hardwood | TBD | Node-following rail curve from CAD | Rip/plane/CNC drill | Keep removable for tuning access. |  |
| CUT-CROSS | Frame cross members | 4 | Hardwood or plywood | TBD | Width set by resonator clearance | Cut/drill/assemble | Prototype frame can be sacrificial. |  |
| CUT-JIG | Bar underside arch fixture | 1 | MDF or plywood spoilboard | CNC bed sized | Datum fence and tabs per cnc/setup-sheet.md | CNC fixture | Use repeatable X datum and replaceable spoilboard. |  |

<div class="page-break"></div>

## drawing-brief.md

Manufacturing drawing and technical product sketch brief.

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

<div class="page-break"></div>

## assembly-manual.md

Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes.

# Marimba Assembly Manual

## Build Philosophy

Cut three pilot bars before committing the whole set: C3, A4, and C6. They bound the low arch-depth limit, the center of the scale, and the short/high-bar behavior. Use their measured pitch and resonator response to decide whether the workbook K constant, selected wood, and CNC arch path are ready for the full run.

## Preflight

- [ ] Confirm active range: C3-C6 chromatic, 37 bars.
- [ ] Confirm selected bar wood and moisture content.
- [ ] Confirm actual resonator tube bore and update `family-spec.csv` if it differs from the workbook proxy.
- [ ] Confirm CNC bed size, hold-down, bit length, and dust collection.
- [ ] Print or open `drawings/arch-undercut-section.svg`, `drawings/resonator-layout.svg`, and `cnc/setup-sheet.md`.

## Bar Workflow

1. Break down rough Padauk stock into oversize blanks using `cut-list.csv`.
2. Joint one face and edge. Mark grain direction and top face.
3. Plane or sand each blank to `0.875 in` nominal edge thickness.
4. Label every blank with `member_id`, note, target Hz, and top face.
5. CNC profile each bar oversize or leave tabs for final cleanup.
6. Mark node positions from `family-spec.csv`.
7. Drill support/cord holes at the node line. Start with `0.250 in`, then adapt to the actual cord/rubber support system.
8. Cut the underside parabolic arch. Use a conservative Z-zero and leave a sanding/tuning allowance.
9. Deburr and sand without rounding node contact areas excessively.
10. Strike-test on soft supports at the node positions and record measured Hz in `validation.csv`.

## Tuning Direction

- To lower pitch: remove material from the center underside arch region.
- To raise pitch: shorten the bar or reduce mass near the ends; raising pitch after over-cutting is limited, so sneak up slowly.
- Keep both ends visually balanced. Asymmetric mass removal can pull modes sideways or create uneven sustain.
- Tune bars before final resonator matching.

## Resonator Workflow

1. Select tube material and bore.
2. Recalculate tube lengths if the selected bore differs from `resonator_bore_in`.
3. Cut tubes oversize per `cut-list.csv`.
4. Deburr both ends.
5. Add removable caps or adjustable stoppers.
6. Mount under the matching bar with the opening centered below the vibrating region.
7. Trim or adjust caps after the bar pitch is stable in the frame.
8. Record final resonator length, cap style, and response notes.

## Frame Workflow

1. Build a temporary straight or lightly tapered validation frame before the final furniture-grade frame.
2. Lay out rail supports from the node schedule, not from equal bar-end offsets.
3. Keep resonator access open so tubes can be removed and tuned.
4. Add cross members only after checking mallet clearance, tube clearance, and player reach.
5. Use removable fasteners until tuning and buzz checks are done.

## Final Checks

- [ ] All bars are labeled and match `family-spec.csv`.
- [ ] Node supports touch at node positions.
- [ ] No bar contacts the frame except through intended rubber/cord supports.
- [ ] No resonator tube touches a vibrating bar.
- [ ] Every measured pitch has a `validation.csv` row.
- [ ] Any bar outside +/- 10 cents after final tuning is flagged for rework.

<div class="page-break"></div>

## validation.csv

Target/measured values, tolerance, environment, result, and tuning/build action log.

| member_id | target_note | target_hz | predicted_length_in | stage | measured_hz | cents_error | tuner | environment | notes |  |  |  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| MAR-C3 | C3 | 130.813 | 32.251 | prebuild |  |  |  |  | Pilot low bar; record flat blank |  post-arch |  post-sand |  final frame. |
| MAR-Csharp3 | C#3 | 138.591 | 31.333 | prebuild |  |  |  |  |  |  |  |  |
| MAR-D3 | D3 | 146.832 | 30.441 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Dsharp3 | D#3 | 155.563 | 29.575 | prebuild |  |  |  |  |  |  |  |  |
| MAR-E3 | E3 | 164.814 | 28.733 | prebuild |  |  |  |  |  |  |  |  |
| MAR-F3 | F3 | 174.614 | 27.915 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Fsharp3 | F#3 | 184.997 | 27.120 | prebuild |  |  |  |  |  |  |  |  |
| MAR-G3 | G3 | 195.998 | 26.348 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Gsharp3 | G#3 | 207.652 | 25.598 | prebuild |  |  |  |  |  |  |  |  |
| MAR-A3 | A3 | 220.000 | 24.869 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Asharp3 | A#3 | 233.082 | 24.161 | prebuild |  |  |  |  |  |  |  |  |
| MAR-B3 | B3 | 246.942 | 23.473 | prebuild |  |  |  |  |  |  |  |  |
| MAR-C4 | C4 | 261.626 | 22.805 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Csharp4 | C#4 | 277.183 | 22.156 | prebuild |  |  |  |  |  |  |  |  |
| MAR-D4 | D4 | 293.665 | 21.525 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Dsharp4 | D#4 | 311.127 | 20.912 | prebuild |  |  |  |  |  |  |  |  |
| MAR-E4 | E4 | 329.628 | 20.317 | prebuild |  |  |  |  |  |  |  |  |
| MAR-F4 | F4 | 349.228 | 19.739 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Fsharp4 | F#4 | 369.994 | 19.177 | prebuild |  |  |  |  |  |  |  |  |
| MAR-G4 | G4 | 391.995 | 18.631 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Gsharp4 | G#4 | 415.305 | 18.100 | prebuild |  |  |  |  |  |  |  |  |
| MAR-A4 | A4 | 440.000 | 17.585 | prebuild |  |  |  |  | Pilot reference bar; use to calibrate K and arch schedule. |  |  |  |
| MAR-Asharp4 | A#4 | 466.164 | 17.085 | prebuild |  |  |  |  |  |  |  |  |
| MAR-B4 | B4 | 493.883 | 16.598 | prebuild |  |  |  |  |  |  |  |  |
| MAR-C5 | C5 | 523.251 | 16.126 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Csharp5 | C#5 | 554.365 | 15.667 | prebuild |  |  |  |  |  |  |  |  |
| MAR-D5 | D5 | 587.330 | 15.221 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Dsharp5 | D#5 | 622.254 | 14.787 | prebuild |  |  |  |  |  |  |  |  |
| MAR-E5 | E5 | 659.255 | 14.366 | prebuild |  |  |  |  |  |  |  |  |
| MAR-F5 | F5 | 698.456 | 13.957 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Fsharp5 | F#5 | 739.989 | 13.560 | prebuild |  |  |  |  |  |  |  |  |
| MAR-G5 | G5 | 783.991 | 13.174 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Gsharp5 | G#5 | 830.609 | 12.799 | prebuild |  |  |  |  |  |  |  |  |
| MAR-A5 | A5 | 880.000 | 12.435 | prebuild |  |  |  |  |  |  |  |  |
| MAR-Asharp5 | A#5 | 932.328 | 12.081 | prebuild |  |  |  |  |  |  |  |  |
| MAR-B5 | B5 | 987.767 | 11.737 | prebuild |  |  |  |  |  |  |  |  |
| MAR-C6 | C6 | 1046.502 | 11.403 | prebuild |  |  |  |  | Pilot high bar; validate shallow arch and short resonator behavior. |  |  |  |

<div class="page-break"></div>

## supplier-rfq.md

Supplier email/request-for-quote starter.

# Supplier RFQ - Marimba C3-C6 Build

## Scope

Request quotes for one 37-bar C3-C6 marimba prototype build. Prices, stock, and lead times are intentionally not assumed in this repo; verify current facts before purchasing.

## Bar Lumber

Please quote clear straight-grain African Padauk suitable for tuned percussion bars.

Required:

- Final thickness after surfacing: `0.875 in`.
- Longest finished bar: `32.251 in`.
- Widest finished bar: `2.000 in`.
- Preferred rough allowance: at least `34 in x 2.25 in x 1.00 in` for the longest bass blanks.
- Quantity: enough for 37 bars plus at least 3 pilot/scrap bars.
- Grain: straight, stable, no checks through the finished bar area.
- Moisture content: provide measured or estimated value.

Alternates:

- Hard maple for education/prototype comparison.
- Cherry for easier machining comparison.

Do not substitute material directly into the build schedule without updating the K constant and validating pitch.

## Resonator Tubes

Please quote PVC or aluminum tube options for 37 quarter-wave resonators.

Required quote data:

- Material.
- Nominal size.
- Actual ID and OD.
- Wall thickness.
- Available lengths.
- Compatible caps, plugs, or stopper hardware.
- Cutting service availability.

The first-pass length range in this packet is about `2.2 in` to `24.3 in`, before oversize tuning allowance. Actual lengths must be recalculated if bore differs from the workbook proxy.

## Hardware

Please quote:

- Low-stretch support cord or equivalent.
- Rubber or silicone tubing/grommets for support isolation.
- Frame fasteners suitable for removable tuning access.
- Optional threaded inserts for rail/cross-member joints.

## CNC Tooling

Please quote:

- 3/4 in carbide ball-end mill, hardwood capable.
- 1/2 in carbide ball-end mill, hardwood capable.
- 1/4 in downcut spiral router bit.
- 1/8 in upcut spiral router bit.

Include shank diameter, cut length, recommended feed/speed range, and replacement availability.

## Response Format

Please return:

```text
item
supplier part number
material/spec
actual dimensions
quantity available
unit price
lead time
shipping estimate
notes/substitution risks
```

<div class="page-break"></div>

## visual-bom-brief.md

Art direction for an image-forward visual BOM.

# Visual BOM Brief

## Goal

Create a visual BOM plate that lets another maker understand the marimba build at a glance: bars, resonators, support hardware, frame rails, tooling, and measurement gear.

## Required Views

1. Hero view of the assembled C3-C6 marimba on a simple shop frame.
2. Exploded view showing bars above resonator tubes above frame rails.
3. Detail inset for one bar: node holes, underside arch, grain direction.
4. Detail inset for one resonator: tube, cap/stopper, mounting clearance.
5. Material swatches: Padauk bar wood, tube material, rubber supports, frame wood.

## BOM Rows To Show

| Item | Visual Needed | Source |
| --- | --- | --- |
| Tuned Padauk bars | Actual shop photo once cut; concept placeholder acceptable before build | `family-spec.csv` |
| Resonator tubes | Supplier image or shop photo | `sourcing.csv` |
| Support cord | Supplier image or shop photo | `bom.csv` |
| Rubber supports | Supplier image or shop photo | `bom.csv` |
| Frame rails | CAD render or shop photo | `cad/` |
| CNC bits | Supplier image or shop photo | `bom.csv` |
| Tuning tools | Shop photo | `validation.csv` workflow |

## Labeling Rules

- Label generated images as concept placeholders.
- Do not use generated images for exact dimensions.
- Every dimension callout must match `family-spec.csv` or be marked `TBD`.
- Keep supplier prices out of the visual until current quotes are verified.

## First Plate Layout

Top: title, date, range, and material.

Middle left: exploded assembly with numbered callouts.

Middle right: BOM table grouped by bars, resonators, frame, hardware, tooling.

Bottom: assumptions and missing purchase-verification items.

<div class="page-break"></div>

## README.md

Project artifact.

# Marimba - CNC Bar And Resonator Build Packet

> A workbook-derived 37-bar C3-C6 marimba packet for CNC-cut Padauk bars, 3D arch undercuts, tuned quarter-wave resonators, and a SolidWorks-ready master-layout handoff.

## What This Is

This repository is the Mode A v4.2 build packet for a marimba: tuned wooden free-free bars suspended at their nodes, with a matched resonator under each note. It turns the existing `marimba-design-table.xlsx` scaffold into a shop-facing documentation set:

1. `design.md` explains the physics model, build range, assumptions, and validation plan.
2. `family-spec.csv` is the 37-bar C3-C6 schedule extracted from the workbook formulas.
3. `bom.csv`, `sourcing.csv`, and `cut-list.csv` separate stable specifications from supplier facts that should be verified before buying.
4. `drawings/`, `cad/`, `cnc/`, `wolfram/`, and `site/` carry the technical handoff layers.

Part of the [tonykoop/instrument-maker](https://github.com/tonykoop/instrument-maker) catalog.

## Physics In One Minute

A marimba bar is a free-free beam. The first mode uses `lambda_1 = 4.730`, and the practical workbook model is:

```text
f ~= K * t / L^2
L ~= sqrt(K * t / f)
```

Length is the dominant pitch lever. Bar thickness and the underside arch tune the bar; width mostly affects feel, loudness, stiffness distribution, and available resonator bore. The cord/support points land at about `0.224 * L` and `0.776 * L`.

The resonator tubes are quarter-wave closed pipes:

```text
L_res ~= c / (4 * f) - 0.82 * bore
```

The resonator reinforces the bar's target frequency. It does not tune the bar itself.

## Build Range

The active packet is a 37-bar chromatic range from C3 to C6, using the workbook's African Padauk setting:

| Note | Frequency | Bar length | Width | Arch depth | Resonator |
| --- | ---: | ---: | ---: | ---: | ---: |
| C3 | 130.813 Hz | 32.251 in | 2.000 in | 0.625 in | 24.260 in |
| C4 | 261.626 Hz | 22.805 in | 1.750 in | 0.469 in | 11.515 in |
| A4 | 440.000 Hz | 17.585 in | 1.750 in | 0.352 in | 6.265 in |
| C6 | 1046.502 Hz | 11.403 in | 1.250 in | 0.156 in | 2.212 in |

The workbook also documents two expansion shapes: a full C2-F6 marimba and a portable C4-F6 instrument. Those are not cut lists yet; they are future configurations once the C3-C6 bar and resonator workflow is validated.

## Repository Structure

```text
marimba/
|-- README.md
|-- design.md
|-- marimba-design-table.xlsx
|-- family-spec.csv
|-- bom.csv
|-- sourcing.csv
|-- cut-list.csv
|-- validation.csv
|-- assembly-manual.md
|-- supplier-rfq.md
|-- visual-bom-brief.md
|-- drawing-brief.md
|-- risks.md
|-- photo-shotlist.md
|-- cad/
|-- cnc/
|-- data/
|-- drawings/
|-- images/
|-- site/
`-- wolfram/
```

## Status

| Area | Status |
| --- | --- |
| Workbook scaffold | done, source table in `marimba-design-table.xlsx` |
| Guided intake | done, see `data/design-intake.json` |
| C3-C6 bar schedule | done, see `family-spec.csv` |
| CNC operation plan | generated, pre-CAM only |
| SolidWorks handoff | prepared as CSV/Markdown contract, no native CAD yet |
| Wolfram source | prepared as `.wl`; notebook execution pending local Wolfram |
| Build photos | pending first shop build |
| Measured tuning data | pending prototype validation |

## License

[CC BY 4.0](LICENSE) - see `LICENSE` for details.

<div class="page-break"></div>

## family-spec.csv

Project artifact.

| member_id | target_note | midi | target_hz | predicted_length_in | predicted_width_in | predicted_thick_in | node_1_in | node_2_in | arch_depth_in | center_thickness_in | resonator_length_in | resonator_bore_in | material | k_constant | scale_label | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| MAR-C3 | C3 | 48 | 130.813 | 32.251 | 2.000 | 0.875 | 7.224 | 25.027 | 0.625 | 0.250 | 24.260 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Csharp3 | C#3 | 49 | 138.591 | 31.333 | 2.000 | 0.875 | 7.019 | 24.315 | 0.612 | 0.263 | 22.806 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-D3 | D3 | 50 | 146.832 | 30.441 | 2.000 | 0.875 | 6.819 | 23.622 | 0.599 | 0.276 | 21.434 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Dsharp3 | D#3 | 51 | 155.563 | 29.575 | 2.000 | 0.875 | 6.625 | 22.950 | 0.586 | 0.289 | 20.139 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-E3 | E3 | 52 | 164.814 | 28.733 | 2.000 | 0.875 | 6.436 | 22.297 | 0.573 | 0.302 | 18.917 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-F3 | F3 | 53 | 174.614 | 27.915 | 2.000 | 0.875 | 6.253 | 21.662 | 0.560 | 0.315 | 17.763 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Fsharp3 | F#3 | 54 | 184.997 | 27.120 | 2.000 | 0.875 | 6.075 | 21.045 | 0.547 | 0.328 | 16.674 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-G3 | G3 | 55 | 195.998 | 26.348 | 2.000 | 0.875 | 5.902 | 20.446 | 0.534 | 0.341 | 15.646 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Gsharp3 | G#3 | 56 | 207.652 | 25.598 | 2.000 | 0.875 | 5.734 | 19.864 | 0.521 | 0.354 | 14.676 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-A3 | A3 | 57 | 220.000 | 24.869 | 2.000 | 0.875 | 5.571 | 19.298 | 0.508 | 0.367 | 13.760 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Asharp3 | A#3 | 58 | 233.082 | 24.161 | 2.000 | 0.875 | 5.412 | 18.749 | 0.495 | 0.380 | 12.896 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-B3 | B3 | 59 | 246.942 | 23.473 | 2.000 | 0.875 | 5.258 | 18.215 | 0.482 | 0.393 | 12.080 | 2.000 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-C4 | C4 | 60 | 261.626 | 22.805 | 1.750 | 0.875 | 5.108 | 17.697 | 0.469 | 0.406 | 11.515 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Csharp4 | C#4 | 61 | 277.183 | 22.156 | 1.750 | 0.875 | 4.963 | 17.193 | 0.456 | 0.419 | 10.788 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-D4 | D4 | 62 | 293.665 | 21.525 | 1.750 | 0.875 | 4.822 | 16.704 | 0.443 | 0.432 | 10.102 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Dsharp4 | D#4 | 63 | 311.127 | 20.912 | 1.750 | 0.875 | 4.684 | 16.228 | 0.430 | 0.445 | 9.454 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-E4 | E4 | 64 | 329.628 | 20.317 | 1.750 | 0.875 | 4.551 | 15.766 | 0.417 | 0.458 | 8.843 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-F4 | F4 | 65 | 349.228 | 19.739 | 1.750 | 0.875 | 4.421 | 15.317 | 0.404 | 0.471 | 8.266 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Fsharp4 | F#4 | 66 | 369.994 | 19.177 | 1.750 | 0.875 | 4.296 | 14.881 | 0.391 | 0.484 | 7.722 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-G4 | G4 | 67 | 391.995 | 18.631 | 1.750 | 0.875 | 4.173 | 14.458 | 0.378 | 0.497 | 7.208 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Gsharp4 | G#4 | 68 | 415.305 | 18.100 | 1.750 | 0.875 | 4.054 | 14.046 | 0.365 | 0.510 | 6.723 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-A4 | A4 | 69 | 440.000 | 17.585 | 1.750 | 0.875 | 3.939 | 13.646 | 0.352 | 0.523 | 6.265 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Asharp4 | A#4 | 70 | 466.164 | 17.085 | 1.750 | 0.875 | 3.827 | 13.258 | 0.339 | 0.536 | 5.833 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-B4 | B4 | 71 | 493.883 | 16.598 | 1.750 | 0.875 | 3.718 | 12.880 | 0.326 | 0.549 | 5.425 | 1.750 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-C5 | C5 | 72 | 523.251 | 16.126 | 1.500 | 0.875 | 3.612 | 12.513 | 0.312 | 0.562 | 5.245 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Csharp5 | C#5 | 73 | 554.365 | 15.667 | 1.500 | 0.875 | 3.509 | 12.157 | 0.299 | 0.576 | 4.881 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-D5 | D5 | 74 | 587.330 | 15.221 | 1.500 | 0.875 | 3.409 | 11.811 | 0.286 | 0.589 | 4.538 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Dsharp5 | D#5 | 75 | 622.254 | 14.787 | 1.500 | 0.875 | 3.312 | 11.475 | 0.273 | 0.602 | 4.215 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-E5 | E5 | 76 | 659.255 | 14.366 | 1.500 | 0.875 | 3.218 | 11.148 | 0.260 | 0.615 | 3.909 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-F5 | F5 | 77 | 698.456 | 13.957 | 1.500 | 0.875 | 3.126 | 10.831 | 0.247 | 0.628 | 3.621 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Fsharp5 | F#5 | 78 | 739.989 | 13.560 | 1.500 | 0.875 | 3.037 | 10.523 | 0.234 | 0.641 | 3.348 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-G5 | G5 | 79 | 783.991 | 13.174 | 1.500 | 0.875 | 2.951 | 10.223 | 0.221 | 0.654 | 3.091 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Gsharp5 | G#5 | 80 | 830.609 | 12.799 | 1.500 | 0.875 | 2.867 | 9.932 | 0.208 | 0.667 | 2.849 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-A5 | A5 | 81 | 880.000 | 12.435 | 1.500 | 0.875 | 2.785 | 9.649 | 0.195 | 0.680 | 2.620 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-Asharp5 | A#5 | 82 | 932.328 | 12.081 | 1.500 | 0.875 | 2.706 | 9.375 | 0.182 | 0.693 | 2.404 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-B5 | B5 | 83 | 987.767 | 11.737 | 1.500 | 0.875 | 2.629 | 9.108 | 0.169 | 0.706 | 2.200 | 1.500 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |
| MAR-C6 | C6 | 84 | 1046.502 | 11.403 | 1.250 | 0.875 | 2.554 | 8.848 | 0.156 | 0.719 | 2.212 | 1.250 | African Padauk | 155502 | C3-C6 chromatic | Workbook-derived from Marimba sheet; resonator bore currently follows width/end-correction proxy. |

<div class="page-break"></div>

## photo-shotlist.md

Project artifact.

# Photo Shotlist

This shotlist follows the repo-level photo pipeline expectations from `instrument-maker/docs/photo-pipeline.md`: capture real process images first, use generated or supplier images only as labeled placeholders, and keep build-log image names stable enough for `site/index.html`.

## Intake And Materials

- `images/01-workbook-table.png`: screenshot of `marimba-design-table.xlsx` showing the Marimba sheet.
- `images/02-padauk-stock.jpg`: rough Padauk boards with ruler and grain direction.
- `images/03-resonator-tube-options.jpg`: tube material and cap options.
- `images/04-cnc-tooling.jpg`: ball-end mills and profile bits.

## Bar Fabrication

- `images/10-blank-layout.jpg`: labeled rough blanks before cutting.
- `images/11-thickness-check.jpg`: calipers on surfaced blank.
- `images/12-node-marking.jpg`: node positions marked on one bass and one treble bar.
- `images/13-cnc-arch-setup.jpg`: bar blank held for underside arch.
- `images/14-arch-detail.jpg`: finished underside arch with straightedge.
- `images/15-support-hole-detail.jpg`: clean support hole at node.

## Resonators And Frame

- `images/20-resonator-cutting.jpg`: tube cutting/deburring setup.
- `images/21-resonator-cap-detail.jpg`: adjustable cap or stopper.
- `images/22-frame-rail-layout.jpg`: rail layout with node/support marks.
- `images/23-dry-fit-overview.jpg`: bars, rails, and resonators dry-fit.

## Validation

- `images/30-pilot-c3-tuning.jpg`: C3 supported at nodes and measured.
- `images/31-pilot-a4-tuning.jpg`: A4 tuning reference.
- `images/32-pilot-c6-tuning.jpg`: C6 treble validation.
- `images/33-validation-log.jpg`: tuner, microphone, and `validation.csv` workflow.

## Final Documentation

- `images/40-finished-front.jpg`: full instrument front view.
- `images/41-finished-player-view.jpg`: player reach/ergonomics view.
- `images/42-resonator-underneath.jpg`: underside resonator alignment.
- `images/43-detail-beauty.jpg`: finish/detail close-up.

<div class="page-break"></div>

## risks.md

Project artifact.

# Marimba Risk Register

## Acoustic Risks

### Bar pitch misses workbook prediction

- Risk: The selected Padauk stock has a different effective stiffness/density than the workbook K constant.
- Impact: All bars may cut sharp or flat by a consistent amount.
- Test: Cut and measure C3, A4, and C6 pilot bars before the full run.
- Pass criterion: Post-arch bars can be brought within +/- 10 cents by normal sanding/tuning allowance.
- Mitigation: Update K constant or arch schedule before cutting the remaining bars.

### Resonator bore proxy is wrong

- Risk: The workbook currently uses bar width as the resonator bore/end-correction proxy.
- Impact: Tube lengths may be wrong after real tube diameters are selected.
- Test: Select actual tube ID, recalculate C3/A4/C6 resonator lengths, and compare response.
- Pass criterion: Resonator reinforcement peaks near target pitch without strong buzz or deadening.
- Mitigation: Update `family-spec.csv` and regenerate resonator drawings before cutting all tubes.

## Structural Risks

### Arch cut-through or weak low bars

- Risk: C3 reaches the `0.250 in` minimum center thickness.
- Impact: Bass bars may crack, warp, or lose sustain.
- Test: Measure remaining center thickness after CNC and after final sanding.
- Pass criterion: No pilot bar falls below `0.250 in`; no visible checking under normal strike force.
- Mitigation: Increase minimum center thickness or choose denser/stiffer stock.

### Support holes weaken bars

- Risk: 1/4 in holes near nodes may split if drilled too close to edges or with poor backing.
- Impact: Cracks, buzzes, or support failure.
- Test: Drill sample holes in offcuts and pilot bars with the intended bit and backing board.
- Pass criterion: Clean holes with no breakout or splitting.
- Mitigation: Reduce hole diameter, use cord grooves, or add rubber support posts instead.

## Ergonomic Risks

### Frame too wide or awkward for reach

- Risk: C3-C6 chromatic layout may become too wide/deep once resonators and accidental row are placed.
- Impact: Poor playing ergonomics or impossible transport.
- Test: Tape full-size bar positions on a bench and test mallet reach before building the final frame.
- Pass criterion: Natural and accidental rows are reachable without shoulder strain for intended player.
- Mitigation: Use a compact portable range, split frame, or revised bar spacing.

## Supply Risks

### Padauk availability and quality

- Risk: Clear long Padauk stock may be expensive, unstable, or unavailable.
- Impact: Build delays or inconsistent tone.
- Test: Request current quotes and inspect board quality/moisture before purchase.
- Pass criterion: Enough straight stock for 37 bars plus pilot failures.
- Mitigation: Use hard maple/cherry for an education prototype and update material constants.

### Tube/cap system mismatch

- Risk: Selected tube caps may leak, rattle, or be hard to tune.
- Impact: Weak or noisy resonators.
- Test: Build three tube prototypes with removable caps.
- Pass criterion: Tubes hold adjustment and do not buzz under playing vibration.
- Mitigation: Use adjustable stoppers, gasketed plugs, or alternate tube material.

## Fit And Finish Risks

### Finish shifts pitch or damps sustain

- Risk: A heavy finish adds mass and damping to tuned bars.
- Impact: Bars go flat or lose sustain after finishing.
- Test: Finish an offcut and one sacrificial tuned test bar; measure before/after Hz and decay.
- Pass criterion: Pitch shift is predictable and within final tuning allowance.
- Mitigation: Use thin finish, tune after finish, or mask underside tuning zones until final pass.

### Frame buzzes after assembly

- Risk: Bars, tubes, caps, or fasteners touch unintentionally.
- Impact: Audible buzzes and unreliable validation data.
- Test: Strike every bar at soft, medium, and loud dynamics while muting adjacent parts.
- Pass criterion: No persistent buzz in the assembled frame.
- Mitigation: Add clearance, isolate hardware, and use thread-locking or removable dampers where appropriate.
