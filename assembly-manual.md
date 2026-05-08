# Marimba Assembly Manual

## Build Philosophy

Cut three pilot bars before committing the whole set: C3, A4, and C6. They bound the low arch-depth limit, the center of the scale, and the short/high-bar behavior. Use their measured pitch and resonator response to decide whether the workbook K constant, selected wood, and CNC arch path are ready for the full run.

## Preflight

- [ ] Confirm active range: C3-C6 chromatic, 37 bars.
- [ ] Confirm selected bar wood and moisture content.
- [ ] Confirm actual resonator tube bore and update `family-spec.csv` if it differs from the workbook proxy.
- [ ] Confirm CNC bed size, hold-down, bit length, and dust collection.
- [ ] Review `jig-decision.md` and build only the pilot jigs required for C3, A4, and C6.
- [ ] Print or open `drawings/arch-undercut-section.svg`, `drawings/resonator-layout.svg`, and `cnc/setup-sheet.md`.

## Jig Decision Gate

Use `jig-decision.md` as the shop stop/go sheet. Do not build the full 37-bar fixture, final frame, or fixed resonator stop system until the pilot rows in `validation.csv` have measured values for `flat_blank`, `post_arch`, `post_sand`, `resonator_coupled`, and `final_frame`.

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
