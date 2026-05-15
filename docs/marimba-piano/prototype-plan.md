# Prototype Plan

## P0: One-Note Truth Coupon

Goal: prove the architecture before committing to a keyboard-width mechanism.

Build:

- One key or lever.
- One hammer with a manually indexed three-face head.
- One removable bar holder.
- One tone bar, starting with A4 or C5.
- One aperture plate with replaceable aperture inserts.
- One resonator tube with adjustable height.
- One mini platen clamp that compresses the gasket.

Measure:

- Bar pitch alone.
- Resonator pitch alone.
- Coupled note pitch, loudness, and sustain.
- Cents error from target.
- Gasket leakage by listening and by comparing clamped versus unclamped level.
- Hammer attack character for each face.
- Rebound and double-strike behavior.
- Mechanical noise.

Pass condition:

- The note speaks cleanly.
- The cassette can be removed and reinstalled three times with no more than 5 cents pitch/coupling shift.
- At least two hammer faces produce clearly different recorded attacks without causing unreliable rebound.

## P1: 13-Note C4-C5 Module

Goal: prove registration, repeatability, and player ergonomics across a small keyboard span.

Build:

- 13 keys, C4 through C5.
- 13 hammer assemblies.
- One wood or synthetic voice cassette.
- One test aperture set.
- One resonator bank with adjustable float.
- Right-side platen lever.
- Left-side hammer selector, initially allowed to be a slower indexed service control rather than a performance control.

Measure:

- Per-note tuning.
- Bar support noise.
- Strike alignment at rest and after cassette swaps.
- Platen compression uniformity across the width.
- Resonator balance across low and high notes.
- Whether hammer selector changes all notes evenly.

Pass condition:

- All notes play without missed strikes or double strikes.
- Cassette swap returns hammer-to-bar alignment within a visible target window.
- Resonator seal remains stable after repeated clamping.
- At least one complete cassette is playable enough for musical testing.

## P2: Second Voice Cassette

Goal: prove the instrument is actually modular, not just removable.

Build one contrasting cassette:

- If P1 used wood, make P2 aluminum or synthetic.
- If P1 used aluminum, make P2 wood.

Test:

- Same chassis and hammer row.
- Same resonator bank first.
- Alternate aperture inserts before building a second pipe bank.
- Second pipe bank only if measurements show the first bank cannot support the new material.

## P3: Extended Keyboard

Goal: scale only after the mechanics stop changing.

Candidate ranges:

- 25 notes for a compact lap/bench instrument.
- 37 notes for a small performance instrument.
- 49 or 61 notes only after action weight, selector torque, and resonator packaging are proven.

Promotion requirement:

- CAD/DXF authority exists for the chassis, cassette, action, selector, resonator bed, and platen.
- Validation rows for tuning, seal, safety, and repeatability are closed or have explicit tolerances.
