(* Marimba computational packet - instrument-maker-v4.2 *)
(* Open in Wolfram Desktop or Cloud. This source is intentionally readable and diffable. *)

ClearAll["Global`*"];

packetDir = DirectoryName[$InputFileName] /. "" -> NotebookDirectory[];
If[!StringQ[packetDir], packetDir = "/mnt/c/Users/Tony/Documents/GitHub/marimba/wolfram/"];
repoDir = ParentDirectory[packetDir];

metadata = <|
  "Instrument" -> "Marimba",
  "Packet" -> "C3-C6 CNC bar and resonator build packet",
  "GeneratedOn" -> "2026-05-06",
  "Model" -> "FreeFreeBeamWithQuarterWaveResonators",
  "SourceWorkbook" -> FileNameJoin[{repoDir, "marimba-design-table.xlsx"}],
  "FamilySpec" -> FileNameJoin[{repoDir, "family-spec.csv"}],
  "Validation" -> FileNameJoin[{repoDir, "validation.csv"}],
  "CncPlan" -> FileNameJoin[{repoDir, "cnc", "cnc-plan.json"}]
|>;

familySpecPath = metadata["FamilySpec"];
validationPath = metadata["Validation"];

readCsvAssociations[path_] := Module[{raw, headers},
  If[!FileExistsQ[path], Return[{}]];
  raw = Import[path, "CSV"];
  If[Length[raw] < 2, Return[{}]];
  headers = First[raw];
  AssociationThread[headers, #] & /@ Rest[raw]
];

toNumber[x_] := Quiet@Check[N@ToExpression[x], Missing["NotNumeric"]];
field[row_, key_] := Lookup[row, key, Missing["MissingKey"]];
num[row_, key_] := toNumber[field[row, key]];

familyRows = readCsvAssociations[familySpecPath];
validationRows = readCsvAssociations[validationPath];

familyDataset = Dataset[familyRows];
validationDataset = Dataset[validationRows];

(* Governing equations *)

lambda1 = 4.730;
speedOfSoundInPerSec = 13552; (* approx. 343 m/s at room temperature *)

frequencyFromMidi[midi_, a4_: 440] := a4*2^((midi - 69)/12);
centsError[measured_, target_] := 1200*Log[2, measured/target];

freeFreeBeamFrequency[k_, edgeThicknessIn_, lengthIn_] := k*edgeThicknessIn/lengthIn^2;
freeFreeBeamLength[k_, edgeThicknessIn_, targetHz_] := Sqrt[k*edgeThicknessIn/targetHz];
nodePositions[lengthIn_] := {0.224*lengthIn, 0.776*lengthIn};

archDepthFromMidi[midi_, edgeThicknessIn_: 0.875, minCenterIn_: 0.250] :=
  (edgeThicknessIn - minCenterIn)*Min[1, (96 - midi)/48];

centerThickness[edgeThicknessIn_, archDepthIn_] := edgeThicknessIn - archDepthIn;

quarterWaveResonatorLength[targetHz_, boreIn_, cInPerSec_: speedOfSoundInPerSec] :=
  cInPerSec/(4*targetHz) - 0.82*boreIn;

barMassEstimateOz[lengthIn_, widthIn_, thicknessIn_, densityKgM3_: 745] := Module[
  {volumeIn3, densityLbIn3},
  volumeIn3 = lengthIn*widthIn*thicknessIn;
  densityLbIn3 = densityKgM3*0.0000361273;
  16*volumeIn3*densityLbIn3
];

materialK = <|
  "Honduras Rosewood" -> 158466,
  "African Padauk" -> 155502,
  "Purpleheart" -> 171249,
  "Hard Maple" -> 171084,
  "Cherry" -> 173557,
  "Black Walnut" -> 176475,
  "Wenge" -> 172459,
  "Mahogany" -> 167438,
  "Synthetic Kelon/FRP" -> 134895
|>;

(* Workbook-derived schedule checks *)

scheduleCheck = Dataset[
  familyRows /. row_Association :> <|
    "note" -> field[row, "target_note"],
    "target_hz" -> num[row, "target_hz"],
    "length_in" -> num[row, "predicted_length_in"],
    "freq_from_formula" -> freeFreeBeamFrequency[num[row, "k_constant"], num[row, "predicted_thick_in"], num[row, "predicted_length_in"]],
    "node_1_in" -> First[nodePositions[num[row, "predicted_length_in"]]],
    "node_2_in" -> Last[nodePositions[num[row, "predicted_length_in"]]],
    "resonator_in" -> quarterWaveResonatorLength[num[row, "target_hz"], num[row, "resonator_bore_in"]]
  |>
];

barLengthExplorer = Manipulate[
  Grid[
    {
      {"target Hz", NumberForm[targetHz, {7, 2}]},
      {"bar length in", NumberForm[freeFreeBeamLength[kConstant, edgeThickness, targetHz], {7, 3}]},
      {"node 1 in", NumberForm[0.224*freeFreeBeamLength[kConstant, edgeThickness, targetHz], {7, 3}]},
      {"node 2 in", NumberForm[0.776*freeFreeBeamLength[kConstant, edgeThickness, targetHz], {7, 3}]},
      {"quarter-wave resonator in", NumberForm[quarterWaveResonatorLength[targetHz, bore], {7, 3}]}
    },
    Frame -> All
  ],
  {{targetHz, 440, "target frequency Hz"}, 130, 1050, Appearance -> "Labeled"},
  {{kConstant, 155502, "free-free K"}, 130000, 180000, Appearance -> "Labeled"},
  {{edgeThickness, 0.875, "edge thickness in"}, 0.50, 1.25, Appearance -> "Labeled"},
  {{bore, 1.75, "resonator bore in"}, 1.00, 4.00, Appearance -> "Labeled"}
];

materialComparisonPlot = Module[{targetHz = 440, t = 0.875, pts},
  pts = KeyValueMap[{#1, freeFreeBeamLength[#2, t, targetHz]} &, materialK];
  BarChart[
    pts[[All, 2]],
    ChartLabels -> Placed[pts[[All, 1]], Below],
    Frame -> True,
    FrameLabel -> {None, "A4 bar length in"},
    PlotLabel -> "Material K comparison at A4, t = 0.875 in"
  ]
];

archSensitivity = Manipulate[
  Module[{center = centerThickness[edgeThickness, archDepth], relativePitch},
    relativePitch = Sqrt[Max[center, 0.001]/edgeThickness];
    Grid[
      {
        {"edge thickness in", NumberForm[edgeThickness, {5, 3}]},
        {"arch depth in", NumberForm[archDepth, {5, 3}]},
        {"center thickness in", NumberForm[center, {5, 3}]},
        {"approx. pitch ratio vs flat", NumberForm[relativePitch, {5, 3}]},
        {"warning", If[center < 0.250, "below 0.250 in minimum", "within current minimum"]}
      },
      Frame -> All
    ]
  ],
  {{edgeThickness, 0.875, "edge thickness in"}, 0.50, 1.25, Appearance -> "Labeled"},
  {{archDepth, 0.350, "arch depth in"}, 0.0, 0.75, Appearance -> "Labeled"}
];

resonatorCalculator = Manipulate[
  Plot[
    quarterWaveResonatorLength[f, bore],
    {f, 130, 1050},
    Frame -> True,
    FrameLabel -> {"frequency Hz", "tube length in"},
    PlotLabel -> Row[{"Quarter-wave resonator length, bore = ", bore, " in"}],
    PlotRange -> All
  ],
  {{bore, 1.75, "tube bore in"}, 1.00, 4.00, Appearance -> "Labeled"}
];

validationWithCents[] := Module[{rows},
  rows = Select[validationRows, StringLength[ToString[field[#, "measured_hz"]]] > 0 &];
  If[Length[rows] == 0,
    "No measured validation data yet. Fill validation.csv after the C3/A4/C6 pilot bars.",
    Dataset[
      rows /. row_Association :> Append[row,
        "computed_cents_error" -> centsError[num[row, "measured_hz"], num[row, "target_hz"]]
      ]
    ]
  ]
];

validationPlot[] := Module[{rows, pts},
  rows = Select[validationRows, StringLength[ToString[field[#, "measured_hz"]]] > 0 &];
  If[Length[rows] == 0,
    "No numeric validation rows yet.",
    pts = Table[{i, centsError[num[rows[[i]], "measured_hz"], num[rows[[i]], "target_hz"]]}, {i, Length[rows]}];
    ListPlot[
      pts,
      Frame -> True,
      FrameLabel -> {"measurement row", "cents error"},
      PlotLabel -> "Measured vs target marimba pitch error",
      PlotRange -> All
    ]
  ]
];

audioPreview[targetHz_: 440, seconds_: 1.5] := Sound[
  Play[
    0.70 Sin[2 Pi targetHz t] +
    0.25 Sin[2 Pi 4 targetHz t] +
    0.10 Sin[2 Pi 10 targetHz t],
    {t, 0, seconds},
    SampleRate -> 44100
  ]
];

packetNotebook[] := CreateDocument[
  {
    TextCell["Marimba C3-C6 Computational Packet", "Title"],
    TextCell["Free-free beam bars, CNC arch undercuts, and quarter-wave resonators", "Subtitle"],
    TextCell["Metadata", "Section"],
    ExpressionCell[metadata, "Input"],
    TextCell["Family Spec", "Section"],
    ExpressionCell[familyDataset, "Input"],
    TextCell["Schedule Formula Check", "Section"],
    ExpressionCell[scheduleCheck, "Input"],
    TextCell["Bar Length Explorer", "Section"],
    ExpressionCell[barLengthExplorer, "Input"],
    TextCell["Material K Comparison", "Section"],
    ExpressionCell[materialComparisonPlot, "Input"],
    TextCell["Arch Sensitivity", "Section"],
    ExpressionCell[archSensitivity, "Input"],
    TextCell["Resonator Calculator", "Section"],
    ExpressionCell[resonatorCalculator, "Input"],
    TextCell["Audio Preview", "Section"],
    ExpressionCell[audioPreview[440], "Input"],
    TextCell["Validation", "Section"],
    ExpressionCell[validationWithCents[], "Input"],
    ExpressionCell[validationPlot[], "Input"]
  },
  WindowTitle -> "Marimba C3-C6 Packet"
];

packetNotebook[];
