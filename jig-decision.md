# Marimba Jig Decision Record

Generated: 2026-05-08

## Purpose

This file is the manufacturing decision layer for the marimba packet. The design table gives bar and resonator dimensions; the CNC setup sheet gives operations. This record decides which jigs earn their way into the first build, what each jig controls, and which validation row proves the decision worked.

The active recommendation is a staged jig system, not one universal fixture. The pilot build should make only the jigs needed to cut and measure C3, A4, and C6. The remaining 34 bars wait until those three bars validate material K, CNC arch behavior, support-hole placement, and resonator coupling.

## Source Inputs

| Source | Used for |
| --- | --- |
| `family-spec.csv` | Bar length, width, node positions, arch depth, center thickness, resonator length, bore proxy. |
| `design.md` | Free-free beam model, quarter-wave resonator model, open assumptions. |
| `cnc/setup-sheet.md` | Operation sequence, datum scheme, tool list, pilot gate. |
| `drawings/arch-undercut-section.svg` | Underside arch geometry and minimum center thickness. |
| `drawings/resonator-layout.svg` | Resonator tube length and note mapping. |
| `validation.csv` | Measurement rows that decide whether to scale from pilot to full set. |

## Datum Rules

| Datum | Meaning | Must survive |
| --- | --- | --- |
| A | Top face of the bar blank | Surfacing, profile, flip, arch cut, final thickness check. |
| B | Left end of the bar | Profile, node drilling, arch start/stop, SolidWorks comparison. |
| C | Bar centerline | Node holes, arch center, resonator centerline, frame rail layout. |

If a jig loses A/B/C, the bar is no longer traceable to `family-spec.csv`; stop and remark before cutting.

## Pilot Decision

| Pilot bar | Why it is in the pilot | Pass gate before full set |
| --- | --- | --- |
| C3 | Longest bar, deepest arch, minimum `0.250 in` center thickness, longest resonator. | Center thickness stays at or above `0.250 in`; pitch can be tuned within normal sanding allowance; resonator reinforces without buzz. |
| A4 | A4 = 440 Hz reference, mid-scale K check, mid-depth arch. | Measured K trend matches C3/C6 closely enough to continue; support holes do not damp sustain. |
| C6 | Shortest bar, shallowest arch, shortest resonator. | Z-zero and ball-end toolpath do not leave a dead/stiff bar; short resonator strategy remains audible. |

Full production is blocked until these rows in `validation.csv` have measured values: `flat_blank`, `post_arch`, `post_sand`, `resonator_coupled`, and `final_frame` for C3, A4, and C6.

## Decision Matrix

| Decision ID | Operation | Chosen jig | Why this choice | Go/no-go test |
| --- | --- | --- | --- | --- |
| JD-010 | Surface and thickness blanks | Planer/drum-sander carrier with grain arrow and top-face mark | Keeps Padauk blanks flat and preserves datum A before CNC. | Thickness is `0.875 in +/- 0.005 in` at both ends and center. |
| JD-020 | CNC profile and arch undercut | Two-sided spoilboard with fixed left-end fence, centerline pins, and replaceable tape/clamp zones | A repeatable B/C reference matters more than high clamp force; tabs must avoid nodes and arch region. | Air cut clears clamps; pilot bar length and node marks match drawing within `+/- 0.020 in`. |
| JD-030 | Flip for underside arch | Soft cradle or gasketed fixture under top face A, referenced to B and C | The tuned face cannot be dented; arch must stay centered after the flip. | C3 arch reaches target depth without center thickness dropping below `0.250 in`; no chatter or burn. |
| JD-040 | Node drilling | Drill-press fence or CNC drill cycle with backer board | Node holes are acoustic supports, not cosmetic holes; breakout or drift will damp the bar. | Hole center is within `+/- 0.020 in`; strike test shows no support buzz. |
| JD-050 | Resonator tube cutting | V-block sled with adjustable stop and note label station | Tube length changes with actual selected bore and cap style, so the jig must support trim passes. | C3/A4/C6 tubes can be cut long, capped, adjusted, and re-measured without label confusion. |
| JD-060 | Resonator mounting | Temporary rail with slotted tube mounts | Resonator position and cap access need iteration after bars are tuned. | Tubes clear bars and rails; no buzz at soft, medium, or loud strikes. |
| JD-070 | Frame supports | Temporary validation frame before furniture-grade frame | The frame should validate node paths, mallet clearance, and resonator access before final joinery. | Supports land on node positions; player reach and tube clearance pass full-size layout check. |

## Rejected Fixture Options

| Rejected option | Reason |
| --- | --- |
| One universal 37-bar CNC nest | Too much Padauk is at risk before pilot K and arch behavior are measured. |
| Clamp directly over the tuning arch region | Clamp pressure can dent the bar and bias the pitch/decay measurement. |
| Fixed-length resonator stop block from workbook proxy bore | The workbook uses width as a bore/end-correction proxy; final tube ID must be selected first. |
| Final furniture-grade frame before tuning | It hides access, makes resonator changes harder, and may lock in a bad rail path. |

## Jig Build Order

1. Build only JD-010 through JD-050 for the pilot set.
2. Cut and measure C3, A4, and C6 through `post_sand`.
3. Select actual resonator tube ID and cap/stopper style.
4. Build JD-060 as a temporary resonator rail and run `resonator_coupled` measurements.
5. Build JD-070 only after the pilot bars and resonators pass.
6. Freeze full-set CAM and rail geometry after the pilot gate.

## Validation Rows To Preserve

| Row pattern | Purpose | Release threshold |
| --- | --- | --- |
| `flat_blank` | Material K sanity check before arching. | Trend is consistent enough to update K or continue. |
| `post_arch` | CNC arch and center-thickness check. | No pilot bar violates minimum center thickness or misses by more than `+/- 15 cents` before sanding. |
| `post_sand` | Hand tuning check. | Pilot bars can approach `+/- 10 cents`. |
| `resonator_coupled` | Resonator reinforcement check. | Reinforcement improves sustain/loudness without buzz or obvious detuning. |
| `final_frame` | Full support and assembly check. | Node supports do not damp, and no hardware buzz remains. |

## Open Decisions

- Actual resonator tube material and inside diameter remain `TBD`.
- Final support method remains open: cord through holes, rubber posts, or hybrid rail pins.
- Final frame width and accidental/natural row offsets remain `TBD` until a full-size layout confirms mallet reach.
- CAM feeds/speeds and stepover must be set from the actual CNC router, bit geometry, hold-down, and dust collection setup.
