// Marimba OpenSCAD starter.
// Build-critical dimensions live in family-spec.csv and CAD CSV files.
// This starter is for visual/spacing review, not final CAM.

$fn = 48;

function inch(x) = x * 25.4;

module bar(length_in, width_in, edge_thickness_in, center_thickness_in, arch_depth_in, node_1_in, node_2_in) {
    length = inch(length_in);
    width = inch(width_in);
    edge = inch(edge_thickness_in);
    center = inch(center_thickness_in);
    node1 = inch(node_1_in);
    node2 = inch(node_2_in);

    difference() {
        cube([length, width, edge], center=false);

        // Simplified centered underside relief. The real CAM path should use a
        // parabolic surface over about 60 percent of the bar length.
        translate([length * 0.20, -1, -0.1])
            cube([length * 0.60, width + 2, edge - center], center=false);

        translate([node1, width / 2, edge / 2])
            rotate([90, 0, 0])
                cylinder(h=width + 2, d=inch(0.25), center=true);

        translate([node2, width / 2, edge / 2])
            rotate([90, 0, 0])
                cylinder(h=width + 2, d=inch(0.25), center=true);
    }
}

module resonator(length_in, bore_in) {
    length = inch(length_in);
    bore = inch(bore_in);
    difference() {
        cylinder(h=length, d=bore + inch(0.125), center=false);
        translate([0, 0, -1])
            cylinder(h=length + 2, d=bore, center=false);
    }
}

module note_assembly(length_in, width_in, edge_thickness_in, center_thickness_in, arch_depth_in, node_1_in, node_2_in, resonator_length_in, resonator_bore_in) {
    bar(length_in, width_in, edge_thickness_in, center_thickness_in, arch_depth_in, node_1_in, node_2_in);
    translate([inch(length_in) / 2, inch(width_in) / 2, -inch(resonator_length_in) - inch(0.75)])
        resonator(resonator_length_in, resonator_bore_in);
}

// Representative configurations. Use cad/design-table-inputs.csv for the full
// SolidWorks configuration set.
translate([0, 0, 0])
    note_assembly(32.251, 2.000, 0.875, 0.250, 0.625, 7.224, 25.027, 24.260, 2.000);

translate([0, inch(4.0), 0])
    note_assembly(17.585, 1.750, 0.875, 0.523, 0.352, 3.939, 13.646, 6.265, 1.750);

translate([0, inch(7.5), 0])
    note_assembly(11.403, 1.250, 0.875, 0.719, 0.156, 2.554, 8.848, 2.212, 1.250);
