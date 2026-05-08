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

`jig-decision.md` is the controlling fixture decision record. It keeps the pilot workflow staged: build only the carrier, two-sided spoilboard, arch cradle, node-drilling support, and tube V-block needed for C3/A4/C6 before freezing full-set CAM or final frame geometry.

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
