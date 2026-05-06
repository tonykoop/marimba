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
