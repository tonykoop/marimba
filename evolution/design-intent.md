# Design Intent — marimba rev A

- Master CAD: `cad/marimba-master.scad` (sha256: 21992d58f3f68e8395d4e0ee72059a1bea4e34cf695be2ac47890f6cfe9047b7, existing master — kept, not rewritten), driven by `marimba-design-table.xlsx` (sha256: 18026262836f8fb903d49de57e870309a49bbbb24a219b928fb5d9400e56b172) via `cad/design-table-inputs.csv` / `family-spec.csv`.
- Function: 37-bar C3-C6 chromatic marimba. Free-free Padauk bars suspended near their 0.224L/0.776L nodes, each paired with a tuned quarter-wave closed resonator tube. Bar length is the dominant pitch lever (`f ~= K*t/L^2`); resonator length reinforces the bar's target frequency (design.md "Physics In One Minute").
- Environment: shop-built percussion instrument; CNC-cut bars with 3D-printed/machined arch undercuts.
- Target qty: 1 pilot (C3/A4/C6), then full 37-bar run. Deadline: TBD. Budget: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Bar length (per note) | e.g. A4 17.585 in | +/- 10 cents after tuning allowance | sets fundamental pitch | family-spec.csv / marimba-design-table.xlsx |
| Bar thickness / arch depth | e.g. A4 0.352 in arch | measurement_required; C3 floor 0.250 in center thickness | tunes pitch, avoids cracking | family-spec.csv; risks.md "Arch cut-through or weak low bars" |
| Support node positions | 0.224 L / 0.776 L | measurement_required | free-free suspension points | design.md "Physics In One Minute" |
| Resonator length | e.g. A4 6.265 in | measurement_required — bore proxy currently uses bar width | tunes resonator coupling | family-spec.csv; risks.md "Resonator bore proxy is wrong" |
| Support hole diameter | 1/4 in | measurement_required (splitting risk near nodes) | structural | risks.md "Support holes weaken bars" |

## Incidental (free for DFM)

- Frame/rail cosmetic styling, non-mating surface finish, resonator tube color/coating.

## Must-nots (DFM may never violate)

- Bar length/thickness stay workbook-formula-derived (`f ~= K*t/L^2`) until pilot C3/A4/C6 measurement corrects the K constant (risks.md "Bar pitch misses workbook prediction").
- Do not cut the full 37-bar run before the C3/A4/C6 pilot passes tuning and structural gates (README.md "Status" table; risks.md).
- Never let C3 (or any bar) go below 0.250 in center thickness after arch cut (risks.md "Arch cut-through or weak low bars").
- Resonator bore/end-correction proxy (currently bar width) must be replaced with real tube ID before cutting the full resonator bank (risks.md "Resonator bore proxy is wrong").

## Material intent

- Bars: African Padauk (active workbook setting) per bom.csv/sourcing.csv. Resonator tubes: material/bore TBD pending selection.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run — no concessions logged, nothing presented as shippable. Remains L1 concept/scaffold; not a V5 build-packet candidate (README.md).
