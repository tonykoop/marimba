# CNC / Manufacturing Setup Sheet

- Packet: `/mnt/c/Users/Tony/Documents/GitHub/marimba`
- Family: `beam-idiophone`
- Generated: 2026-05-06
- Machine note: Maker Nexus/home shop; verify exact machine, spindle, collet, bed size, and hold-down before CAM.

## Assumptions

- This is a pre-CAM operation graph, not verified G-code.
- The active build range is C3-C6, 37 bars.
- Source dimensions come from `family-spec.csv` and `marimba-design-table.xlsx`.
- The CNC plan assumes African Padauk blanks surfaced to `0.875 in`.
- Resonator tube bore is still a sourcing variable; update tube lengths after selecting actual ID.

## Pilot Gate

Cut C3, A4, and C6 before cutting the full set.

Release to full production only if:

- C3 center thickness remains at least `0.250 in`.
- A4 tunes within normal sanding allowance.
- C6 shallow arch does not become overly stiff or dead.
- Resonator prototypes reinforce without buzz.
- The measured K trend is consistent enough to continue.

## Operation Graph

### OP-010 - Review design package and pilot gate

- Machine: Bench
- Tool: `README.md`, `design.md`, calipers, tuner
- Workholding: Flat bench, drawing packet
- Datum: Top face A, left end B, bar centerline C
- Inputs: `design.md`, `family-spec.csv`, `drawings/arch-undercut-section.svg`, `validation.csv`
- Outputs: pilot-build checklist
- Checks:
  - C3/A4/C6 pilot bars identified.
  - Actual wood species and tube bore confirmed.
  - Full-set cutting is held until pilot data is reviewed.

### OP-110 - Surface and thickness bar blanks

- Machine: Jointer, planer, drum sander
- Tool: Jointer knives, planer, drum sander, calipers
- Workholding: Flat carrier board, push blocks
- Datum: Top face A and grain arrow
- Inputs: `cut-list.csv`, `family-spec.csv`
- Outputs: 37 surfaced oversize blanks
- Checks:
  - Thickness `0.875 in +/- 0.005 in`.
  - Grain direction logged.
  - Defects outside finished bar area.

### OP-120 - Label blanks and mark nodes

- Machine: Bench
- Tool: Marking knife, square, center punch, calipers
- Workholding: Flat bench with stop block
- Datum: Left end B and centerline C
- Inputs: `family-spec.csv`, generated bar drawings
- Outputs: Labeled blanks with note, target Hz, nodes
- Checks:
  - `node_1_in` and `node_2_in` match `family-spec.csv`.
  - Top face remains marked through the flip operation.

### OP-210 - Prepare CNC fixture and datum verification

- Machine: CNC router
- Tool: Spoilboard surfacing bit, edge finder/probe, clamps/tape
- Workholding: Replaceable spoilboard, datum fence, optional vacuum plus clamps
- Datum: X0 at left end B, Y0 at centerline C, Z0 at top face A
- Inputs: `cnc/setup-sheet.md`, `drawings/arch-undercut-section.svg`
- Outputs: Verified fixture and air-cut report
- Checks:
  - Spoilboard surfaced.
  - Clamps clear every toolpath.
  - Sample air-cut passes.

### OP-220 - Rough profile bars with tabs

- Machine: CNC router
- Tool: 1/4 in downcut spiral; optional 1/8 in upcut for small reliefs
- Workholding: Spoilboard tape/clamps, tabs at non-vibrating ends
- Datum: Top face A, left end B, centerline C
- Inputs: `family-spec.csv`, `cad/design-table-inputs.csv`
- Outputs: Profiled bar blanks with tabs
- Checks:
  - Tabs avoid node holes and arch region.
  - Final length retains tuning allowance.
  - Note label survives operation.

### OP-230 - 3D arch underside relief

- Machine: CNC router
- Tool: 3/4 in ball-end mill; 1/2 in ball-end for treble alternative
- Workholding: Cradle or flip fixture supporting top face without denting
- Datum: Top face A re-referenced after flip; left end B retained
- Inputs: `family-spec.csv`, `drawings/arch-undercut-section.svg`
- Outputs: Underside arch cut on each bar
- Checks:
  - Center thickness never below `0.250 in`.
  - Arch is centered.
  - No chatter or burning.
  - Toolpath simulation or air-cut completed.

### OP-240 - Drill support holes at nodes

- Machine: Drill press or CNC router
- Tool: 1/4 in brad-point bit or boring tool
- Workholding: Backer board, bar support fixture
- Datum: Left end B, centerline C
- Inputs: `family-spec.csv`, generated bar drawings
- Outputs: Clean node/support holes
- Checks:
  - Hole breakout absent.
  - Node positions within `+/- 0.020 in`.
  - Holes deburred.

### OP-310 - Hand tune bars

- Machine: Bench
- Tool: Soft node supports, tuner, sanding block, scraper, scale
- Workholding: Padded bench, supports at `node_1_in` and `node_2_in`
- Datum: Acoustic node support datum
- Inputs: `validation.csv`, `family-spec.csv`
- Outputs: Measured pitch log and tuned bars
- Checks:
  - Measured Hz recorded at flat, post-arch, post-sand, and final frame stages.
  - Cents error computed.
  - Material removal region documented.

### OP-410 - Cut and deburr resonator tubes

- Machine: Chop saw, band saw, or tube cutter
- Tool: Tube cutter, deburring tool, calipers
- Workholding: Tube V-block, stop block
- Datum: Tube open end
- Inputs: `family-spec.csv`, `sourcing.csv`, `drawings/resonator-layout.svg`
- Outputs: Oversize resonator tubes labeled by note
- Checks:
  - Tube ID matches updated bore.
  - Cut length includes trim allowance.
  - Burrs removed.

### OP-420 - Cap and mount resonators

- Machine: Bench and drill press
- Tool: Drill bits, caps/stoppers, seal material
- Workholding: Tube holding jig, frame mockup
- Datum: Tube open end and bar centerline
- Inputs: `assembly-manual.md`, `drawings/frame-overview.svg`
- Outputs: Mounted adjustable resonators
- Checks:
  - Caps seal without buzz.
  - Tubes clear bars and rails.
  - Note labels visible after assembly.

### OP-510 - Build frame and support rails

- Machine: Table saw, CNC router, drill press
- Tool: Saw blade, drill bits, router bits
- Workholding: Rail fixture, cross-member clamps
- Datum: Player-side datum and rail centerlines
- Inputs: `drawings/frame-overview.svg`, `cad/SolidWorks-MasterLayout-Plan.md`
- Outputs: Temporary or final support frame
- Checks:
  - Supports land at nodes.
  - Cross members remain removable.
  - Mallet and resonator clearance checked.

### OP-900 - Final validation and release

- Machine: Bench
- Tool: Chromatic tuner, microphone, calipers, camera
- Workholding: Assembled frame on stable stand
- Datum: Same support and strike datum used for every note
- Inputs: `validation.csv`, `photo-shotlist.md`
- Outputs: Updated validation.csv and process photos
- Checks:
  - All notes measured.
  - Outliers flagged.
  - Resonator response notes captured.

## Release Checks

- [ ] Every operation has a datum and workholding method.
- [ ] Every tool has a real machine available or an escalation note.
- [ ] All tuning-critical features include trim allowance.
- [ ] C3/A4/C6 pilot data is reviewed before cutting all 37 bars.
- [ ] Actual resonator bore is selected before final tube lengths are frozen.
- [ ] `validation.csv` receives measured data after the first prototype.
