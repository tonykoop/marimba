#!/usr/bin/env python3
"""Validate the marimba pilot DXF against repo-local design tables.

This is a narrow traceability check for drawings/marimba-pilot-plate.dxf.
It confirms that the C3/A4/C6 pilot bar outlines and node centers match
cad/design-table-inputs.csv. It is not a CAM, toolpath, or build-readiness
validator.
"""

from __future__ import annotations

import argparse
import csv
import sys
from pathlib import Path


PILOT_MEMBERS = {
    "MAR-C3": {"bar_layer": "BAR_C3", "node_layer": "NODES_C3"},
    "MAR-A4": {"bar_layer": "BAR_A4", "node_layer": "NODES_A4"},
    "MAR-C6": {"bar_layer": "BAR_C6", "node_layer": "NODES_C6"},
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Check marimba pilot DXF dimensions against design table rows."
    )
    parser.add_argument(
        "--design-table",
        default="cad/design-table-inputs.csv",
        help="Design-table CSV to use as dimensional authority.",
    )
    parser.add_argument(
        "--dxf",
        default="drawings/marimba-pilot-plate.dxf",
        help="Pilot DXF to validate.",
    )
    parser.add_argument(
        "--tolerance",
        type=float,
        default=0.001,
        help="Allowed numeric mismatch in inches.",
    )
    return parser.parse_args()


def read_design_table(path: Path) -> dict[str, dict[str, float | str]]:
    with path.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        rows = {row["configuration"]: row for row in reader}

    missing = sorted(set(PILOT_MEMBERS) - set(rows))
    if missing:
        raise ValueError(f"missing pilot configuration row(s): {', '.join(missing)}")
    return rows


def dxf_pairs(path: Path) -> list[tuple[str, str]]:
    raw = path.read_text(encoding="utf-8").splitlines()
    if len(raw) % 2:
        raise ValueError("DXF has an odd number of group-code/value lines")
    return [(raw[index].strip(), raw[index + 1].strip()) for index in range(0, len(raw), 2)]


def insunits_is_inches(pairs: list[tuple[str, str]]) -> bool:
    for index, (code, value) in enumerate(pairs[:-1]):
        if code == "9" and value == "$INSUNITS":
            next_code, next_value = pairs[index + 1]
            return next_code == "70" and next_value == "1"
    return False


def parse_entities(pairs: list[tuple[str, str]]) -> list[dict[str, object]]:
    entities: list[dict[str, object]] = []
    current: dict[str, object] | None = None

    for code, value in pairs:
        if code == "0":
            if current and current.get("type") not in {"SECTION", "ENDSEC", "EOF"}:
                entities.append(current)
            current = {"type": value, "groups": []}
            continue
        if current is not None:
            current.setdefault("groups", []).append((code, value))

    if current and current.get("type") not in {"SECTION", "ENDSEC", "EOF"}:
        entities.append(current)
    return entities


def group_value(entity: dict[str, object], code: str) -> str | None:
    for group_code, value in entity.get("groups", []):
        if group_code == code:
            return value
    return None


def numeric_group(entity: dict[str, object], code: str) -> float:
    value = group_value(entity, code)
    if value is None:
        raise ValueError(f"entity {entity.get('type')} missing DXF group {code}")
    return float(value)


def layer_entities(
    entities: list[dict[str, object]], entity_type: str, layer: str
) -> list[dict[str, object]]:
    return [
        entity
        for entity in entities
        if entity.get("type") == entity_type and group_value(entity, "8") == layer
    ]


def assert_close(
    errors: list[str], label: str, actual: float, expected: float, tolerance: float
) -> None:
    if abs(actual - expected) > tolerance:
        errors.append(
            f"{label}: actual {actual:.3f} != expected {expected:.3f} "
            f"(tolerance {tolerance:.3f})"
        )


def validate_member(
    member_id: str,
    design_row: dict[str, str],
    entities: list[dict[str, object]],
    tolerance: float,
    errors: list[str],
) -> None:
    layers = PILOT_MEMBERS[member_id]
    bar_lines = layer_entities(entities, "LINE", layers["bar_layer"])
    node_circles = layer_entities(entities, "CIRCLE", layers["node_layer"])

    if len(bar_lines) != 4:
        errors.append(f"{member_id}: expected 4 bar outline lines, found {len(bar_lines)}")
        return
    if len(node_circles) != 2:
        errors.append(f"{member_id}: expected 2 node circles, found {len(node_circles)}")
        return

    xs: list[float] = []
    ys: list[float] = []
    for line in bar_lines:
        xs.extend([numeric_group(line, "10"), numeric_group(line, "11")])
        ys.extend([numeric_group(line, "20"), numeric_group(line, "21")])

    actual_length = max(xs) - min(xs)
    actual_width = max(ys) - min(ys)
    expected_length = float(design_row["bar_length_in"])
    expected_width = float(design_row["bar_width_in"])

    assert_close(errors, f"{member_id} bar length", actual_length, expected_length, tolerance)
    assert_close(errors, f"{member_id} bar width", actual_width, expected_width, tolerance)

    actual_nodes = sorted(numeric_group(circle, "10") for circle in node_circles)
    expected_nodes = sorted(
        [float(design_row["node_1_in"]), float(design_row["node_2_in"])]
    )
    for index, (actual, expected) in enumerate(zip(actual_nodes, expected_nodes), start=1):
        assert_close(errors, f"{member_id} node {index}", actual, expected, tolerance)

    labels = [
        group_value(entity, "1") or ""
        for entity in layer_entities(entities, "TEXT", "LABELS")
    ]
    label_fragment = (
        f"{member_id} {design_row['bar_note']} {float(design_row['target_frequency_hz']):.3f} Hz "
        f"L={expected_length:.3f} W={expected_width:.3f}"
    )
    if not any(label_fragment in label for label in labels):
        errors.append(f"{member_id}: missing label fragment {label_fragment!r}")


def main() -> int:
    args = parse_args()
    design_table = Path(args.design_table)
    dxf = Path(args.dxf)

    try:
        rows = read_design_table(design_table)
        pairs = dxf_pairs(dxf)
        entities = parse_entities(pairs)
    except (OSError, ValueError) as exc:
        print(f"validate_marimba_pilot_dxf: ERROR: {exc}", file=sys.stderr)
        return 2

    errors: list[str] = []
    if not insunits_is_inches(pairs):
        errors.append("$INSUNITS is not set to 1 (inches)")

    for member_id in PILOT_MEMBERS:
        validate_member(member_id, rows[member_id], entities, args.tolerance, errors)

    if errors:
        print("validate_marimba_pilot_dxf: FAIL")
        for error in errors:
            print(f"  [ERROR] {error}")
        return 1

    print(
        "validate_marimba_pilot_dxf: OK "
        f"({len(PILOT_MEMBERS)} pilot bars match {design_table} within "
        f"{args.tolerance:.3f} in)"
    )
    print("  Boundary: traceability check only; CAM, toolpaths, and measured tuning remain open.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
