# Marimba Piano Design Notes

Current status: bare-bones readiness packet

Fabrication authority: not build-ready. Generated images, sketches, and first-order estimates do not control dimensions. Future CAD, DXF, design tables, measured templates, or explicitly reviewed drawings will control fabrication.

## Intent

Build a keyboard instrument that plays like a small upright piano but sounds through struck tone bars and tuned resonators. The player can swap a complete tone-bar frame to change the instrument voice, then use a side handle to change hammer-face material without removing the hammers from the chassis.

The design goal is not just "piano plus marimba." The interesting part is a repeatable experimental platform for idiophone timbre:

- Same keyboard action, different bar materials.
- Same bars, different hammer faces.
- Same pitch bank, different aperture and resonator couplings.
- Same chassis, multiple voice cassettes.

## Baseline Architecture

### Fixed Chassis

The chassis holds the key bed, hammer action, left-side hammer selector, right-side platen lever, and adjustable resonator bed. For the first prototype, use a 13-note chromatic module from C4 to C5 instead of a full keyboard.

### Interchangeable Voice Cassette

Each voice cassette carries:

- Tone bars mounted at free-free beam suspension nodes.
- Bar supports and quiet locating hardware.
- A lower aperture plate aligned to the resonator bank.
- Gaskets bonded to the aperture plate or seated in replaceable gasket pockets.
- Tapered alignment features that locate the cassette before the platen lever compresses it.

The cassette should slide into the front plane, then move a short controlled distance under platen pressure to seal against the resonators.

### Adjustable Resonator Bed

The resonator bank is independent from the tone-bar cassette. It should have:

- Threaded standoffs for height and angle adjustment.
- Compression springs or compliant mounts to take up slack.
- Tapered pins or V-block features for repeatable alignment.
- Replaceable pipe banks for wood/synthetic voices versus metallic voices if testing shows the same bank cannot support both well.

The first assumption is that resonator pipe length sets the main pitch support, while the cassette aperture controls coupling, loudness, sustain, and spectral balance.

### Platen Lever

The right-side platen lever should move the tone-bar cassette into the fixed or floating resonator bank. Preferred first mechanism:

- Over-center cam shaft or toggle clamp linkage.
- 2 to 4 mm gasket compression target for P0 testing.
- Adjustable hard stop so the lever cannot over-crush gaskets.
- Mechanical interlock that prevents cassette removal while clamped.

### Hammer Selector

The left-side selector changes hammer material across the row. For P0, test one hammer with a manual three-face head. For P1, use a ganged selector rail only after the one-note mechanism is reliable.

Preferred P1 direction:

- Each hammer has a small indexed three-face rotor at the strike end.
- The selector rail engages the hammer-head rotors only at rest.
- A left-side handle indexes the rail by 120 degrees.
- A detent confirms soft, medium, or hard face selection.
- The hammer action remains free during play, without continuous drag from the selector.

Avoid treating the ganged selector as solved until the one-note coupon proves rebound, noise, return, and indexing repeatability.

## Acoustic Model

### Tone Bars

Tone bars are modeled as free-free beams. First-order support nodes are 22.4 percent and 77.6 percent of bar length.

For rectangular flat bars:

```text
f is proportional to thickness / length^2
```

The first table uses the instrument-maker free-free beam estimate derived from the listed material constants. These are planning estimates only. Wood bars should be tuned by undercutting and measurement; aluminum bars may need different thickness, width, damping, or support choices.

### Resonators

Resonator tubes are treated as closed-open quarter-wave pipes:

```text
L_tube = c / (4f) - 0.82 * bore_diameter
```

The C4-C5 table assumes about 68 F air temperature and A4 = 440 Hz. Bent, downward-facing, upward-facing, and straight-out tubes can share effective length only if the bend and aperture losses are validated by measurement.

### Apertures

Apertures are part of the voice cassette, not the fixed resonator bank. Aperture geometry is treated as a coupling/Q control, not the primary pitch control.

Initial aperture hypotheses:

- Wood bars: larger, more open throats for bloom and projection.
- Synthetic bars: medium throats for consistency and controlled sustain.
- Aluminum bars: smaller throats, slot throats, baffles, or damping screens to reduce excessive sustain and high-frequency glare.

## Open Measurements

- Actual tone-bar stock dimensions, density, grain direction, and moisture state.
- Measured pitch of each flat bar before and after support drilling or cording.
- Amount of pitch drop available from undercutting each wood profile.
- Hammer strike speed and rebound with each face material.
- Mechanical noise from selector detents and hammer return.
- Gasket compression needed for an audible seal.
- Resonator pipe pitch before aperture coupling.
- Effect of aperture diameter/slot/baffle on loudness, sustain, and timbre.
- Whether a single pipe bank can support multiple wood/synthetic cassettes.
- Whether metallic cassettes require a separate pipe bank.

## First Build Scope

P0 is one note, not a whole keyboard. Build one middle-range note, preferably A4 or C5, because the bar and resonator dimensions are manageable and measurement is easy. P1 is the 13-note C4-C5 module.

Do not build the full instrument until P0 proves the seal, hammer selector, and resonator coupling.
