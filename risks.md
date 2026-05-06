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
