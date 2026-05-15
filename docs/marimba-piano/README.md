# Marimba Piano

Current status: bare-bones readiness packet

Fabrication authority: not build-ready. The sketch, notes, and estimates in this folder are concept and planning material only until a measured coupon build promotes specific dimensions into CAD, DXF, or a reviewed drawing.

## Concept

The Marimba Piano is a keyboard-driven modular idiophone. Piano-style keys and hammers stay in the chassis. The sound source is a removable tone-bar frame that can be swapped for different acoustic profiles: wood, synthetic bar stock, aluminum, or other tested materials.

The core idea has three modular systems:

- Interchangeable tone-bar frames on the front plane.
- A right-side platen lever that clamps the selected frame and seals its aperture plate against the resonator bank.
- A left-side hammer selector that rotates or indexes multiple hammer-face materials across the whole keyboard.

## File Map

- `design.md` - architecture, assumptions, acoustic model, and open measurements.
- `prototype-plan.md` - P0 through P3 build sequence.
- `tuning-targets-c4-c5.csv` - first-order C4-C5 targets for a 13-note module.
- `hammer-head-test-matrix.csv` - candidate hammer faces and expected effects.
- `aperture-test-matrix.csv` - aperture and coupling tests for resonator throats.
- `bom.csv` - starter bill of materials.
- `sourcing.csv` - sourcing placeholders; all supplier facts are unverified.
- `cut-list.csv` - candidate parts with TBD or estimate status.
- `validation.csv` - gates needed before this becomes a build-ready packet.
- `risks.md` - failure modes and mitigations.
- `drawing-brief.md` - future drawings and authority rules.
- `photo-shotlist.md` - optional documentation shots.
- `references/sketch-20260514.jpg` - original morning sketch, reference-only.

## Next Gates

1. Build a one-note P0 coupon with one key, one hammer, one interchangeable bar, one aperture plate, and one resonator.
2. Measure bar pitch, resonator pitch, gasket leakage, hammer-face tone changes, and platen repeatability.
3. Update the estimates with measured corrections.
4. Promote only measured or reviewed geometry into CAD/DXF authority.

## License Note

No license has been selected for this concept packet yet. Add a license before publishing or sharing fabrication files.
