# Marimba Validation Report

Generated: 2026-05-08

## Clean Checks

- `validate_packet.py . --fix --json` returned `ok: true` with no pass-1 or pass-2 findings.
- Required Tier 1 files exist for the current Mode A packet.
- `capstone-deck.md` has enough slides and no placeholder intent fallback.
- README length and referenced files pass the v4 verifier heuristics.
- `print-packet.pdf` exists and passes the verifier's light PDF sanity check.
- Referenced deck drawings exist on disk.
- CSV row-shape check passes for `validation.csv`, `cnc/operations.csv`, `bom.csv`, `cut-list.csv`, and `sourcing.csv`.

## Fixed In V4 Verifier Loop

- None. The scripted verifier had no fixable findings.

## Manual Fixes During This Pass

- Added `jig-decision.md` as the fixture decision and pilot-release layer.
- Added C3/A4/C6 pilot validation rows for `flat_blank`, `post_arch`, `post_sand`, `resonator_coupled`, and `final_frame`.
- Cross-linked the jig layer from `README.md`, `design.md`, `assembly-manual.md`, `cnc/setup-sheet.md`, `cnc/operations.csv`, `drawing-brief.md`, `visual-bom-brief.md`, `capstone-deck.md`, `print-packet.md`, and `site/index.html`.
- Quoted comma-containing CSV cells in `bom.csv`, `sourcing.csv`, and `cut-list.csv` so downstream CSV readers keep a stable column count.

## Escalated

- None for packet completeness.
- Shop decisions still open by design: actual resonator tube ID/material, support method, final frame geometry, and CAM feeds/speeds must be selected after pilot data.
