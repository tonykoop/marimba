# Marimba - CNC Bar And Resonator Build Packet

> A workbook-derived 37-bar C3-C6 marimba packet for CNC-cut Padauk bars, 3D arch undercuts, tuned quarter-wave resonators, and a SolidWorks-ready master-layout handoff.

## What This Is

This repository is the Mode A v4.2 build packet for a marimba: tuned wooden free-free bars suspended at their nodes, with a matched resonator under each note. It turns the existing `marimba-design-table.xlsx` scaffold into a shop-facing documentation set:

1. `design.md` explains the physics model, build range, assumptions, and validation plan.
2. `family-spec.csv` is the 37-bar C3-C6 schedule extracted from the workbook formulas.
3. `bom.csv`, `sourcing.csv`, and `cut-list.csv` separate stable specifications from supplier facts that should be verified before buying.
4. `drawings/`, `cad/`, `cnc/`, `wolfram/`, and `site/` carry the technical handoff layers.
5. `jig-decision.md` turns the fixture assumptions into pilot-build gates before the full Padauk run.
6. `visual-output-register.csv`, `docs/v5-authority-register.csv`,
   `validation-loop.csv`, `docs/v5-readiness.md`, and
   `cad/mcp-session-log.md` make the V5 promotion boundary explicit.

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
|-- validation-loop.csv
|-- visual-output-register.csv
|-- assembly-manual.md
|-- supplier-rfq.md
|-- visual-bom-brief.md
|-- drawing-brief.md
|-- risks.md
|-- photo-shotlist.md
|-- cad/
|-- cnc/
|-- data/
|-- docs/
|-- drawings/
|-- images/
|-- site/
`-- wolfram/
```

## Status

| Area | Status |
| --- | --- |
| V5 status | explorer/prototype scaffold only; not a V5 build-packet candidate |
| Workbook scaffold | done, source table in `marimba-design-table.xlsx` |
| Guided intake | done, see `data/design-intake.json` |
| C3-C6 bar schedule | done, see `family-spec.csv` |
| Visual authority register | done, see `visual-output-register.csv` |
| Issue #5 V5 authority register | reviewed packet surface, see `docs/v5-authority-register.csv` |
| Pilot DXF | C3/A4/C6 only, see `drawings/marimba-pilot-plate.dxf` |
| Validation loop | measurement-required, see `validation-loop.csv` |
| V5 readiness ledger | scaffolded, see `docs/v5-readiness.md` |
| MCP provenance | scaffolded with no live sessions yet, see `cad/mcp-session-log.md` |
| CNC operation plan | generated, pre-CAM only |
| SolidWorks handoff | prepared as CSV/Markdown contract, no native CAD yet |
| Wolfram source | prepared as `.wl`; notebook execution pending local Wolfram |
| Jig decision layer | done, see `jig-decision.md` |
| Build photos | pending first shop build |
| Measured tuning data | pending prototype validation |

The current CAD/DXF authority chain is a reviewed packet surface, not measured
fabrication authority. Workbook-derived design tables, the OpenSCAD starter,
and the pilot DXF plate are registered as `pending_measurement` in
`visual-output-register.csv` and `docs/v5-authority-register.csv`. Generated or
rendered visuals, when added later, are concept/support artifacts only and do
not control dimensions, node locations, resonator lengths, or CNC toolpaths.

## License

[CC BY 4.0](LICENSE) - see `LICENSE` for details.
