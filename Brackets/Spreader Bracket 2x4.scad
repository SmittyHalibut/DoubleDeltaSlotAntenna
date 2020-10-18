/*
 * Top bracket for W6NBC's Double Delta Slot HF antenna design.
 * This one is designed to fit on top of a 2x4, because that's the mast I have.
 */
 
// Square mast X, in inches
mast_x_in = 3.5;
// Square mast Y, in inches
mast_y_in = 1.5;

// Mast depth, how large of a cup to make, in inches
mast_depth_in = 3;

// Wall thickness, in inches
wall_thickness_in = 0.25;

// Spreader diameter, in inches
spreader_d_in = 0.5;
spreader_depth_in = 3.0;

// Set screw hole diameter, in mm
set_screw_d = 3.2;

// Wood screw hole diameter, in mm (4.0mm for drywall screw)
wood_screw_d = 4.0; 

// Derived parameters; you shouldn't have to change anything below.
in_to_mm = 25.4;

mast_x = mast_x_in * in_to_mm;
mast_y = mast_y_in * in_to_mm;
mast_depth = mast_depth_in * in_to_mm;
wall_thickness = wall_thickness_in * in_to_mm;

pocket_x = mast_x + wall_thickness*2;
pocket_y = mast_y + wall_thickness*2;
pocket_z = mast_depth + wall_thickness;

spreader_d = spreader_d_in * in_to_mm;
spreader_length = spreader_depth_in * in_to_mm;
spreader_width = spreader_d + wall_thickness*2;


spreaders();

module spreaders() {
    difference() {
        union() {
            // Spreaders
            spreader(0);
            spreader(90);
            spreader(180);
            spreader(270);
            // Mast box
            translate([0, 0, -pocket_z/2]) {
                cube([pocket_x, pocket_y, pocket_z], center=true);
            }        
        }
        // Wire exits
        wire_exit(0);
        wire_exit(90);
        wire_exit(180);
        wire_exit(270);

        // The inside pocket
        translate([0, 0, -pocket_z/2-wall_thickness]) {
            cube([mast_x, mast_y, mast_depth], center=true);
        }
        
        // Mast mount screws
        wood_screw(0, -mast_y/4+5, mast_depth/2);
        wood_screw(90, mast_x/4+5, mast_depth/4);
        wood_screw(90, -mast_x/4+5, mast_depth/4);
        wood_screw(90, -mast_x/4+5, mast_depth*3/4);
        wood_screw(180, -mast_y/4+5, mast_depth/2);
        wood_screw(270, mast_x/4+5, mast_depth/4);
        wood_screw(270, -mast_x/4+5, mast_depth/4);
        wood_screw(270, -mast_x/4+5, mast_depth*3/4);
    }
}

module wire_exit(a) {
    // Wire exit
    rotate(a, [0, 0, 1]) {
        translate([wall_thickness, spreader_width/2, spreader_width-wall_thickness]) {
            rotate(-30, [0, 1, 0]) {
                cylinder(h=wall_thickness*3.2, d=spreader_d*0.7, center=true, $fn=50);
            }
        }
    }
}
    
module spreader(a) {
    rotate(a, [0, 0, 1]) {
        difference() {
            cube([spreader_length, spreader_width, spreader_width], center=false);
            // Spreader cylinder
            translate([wall_thickness+1, spreader_width/2, spreader_width/2]) {
                rotate(90, [0, 1, 0]) {
                    cylinder(h=(spreader_length - wall_thickness), d=spreader_d, center=false, $fn=50);
                }
            }
            // Set screws
            translate([spreader_length-spreader_width/2, spreader_width-wall_thickness*1.5, spreader_width/2]) {
                rotate(-90, [1, 0, 0]) {
                    cylinder(h=wall_thickness*2, d=set_screw_d, center=false, $fn=25);
                }
            }
            translate([spreader_width/2+wall_thickness*2, spreader_width-wall_thickness*1.5, spreader_width/2]) {
                rotate(-90, [1, 0, 0]) {
                    cylinder(h=wall_thickness*2, d=set_screw_d, center=false, $fn=25);
                }
            }
        }
        // Support
        translate([0, spreader_width/2-wall_thickness/2, -spreader_length]) {
            difference() {
                cube([spreader_length, wall_thickness, spreader_length]);
                // Remove the angle bits
                translate([0, -wall_thickness/2, 0]) {
                    rotate(45, [0, 1, 0]) {
                        cube([spreader_length*1.5, wall_thickness*2, spreader_length*1.5]);
                    }
                }
            }
        }
    }
}

// a = which face: 0, 90, 180, 270
// x, z = where on that face you want the center of the hole
// x = 0 is center, z = 0 is bottom edge.

module wood_screw(a, x, z) {
    rotate(a, [0, 0, 1]) { // Put it on the correct face
        translate([0, x, -pocket_z+z]) {
            rotate(90, [0, 1, 0]) {  // Get it pointing outward
                cylinder(h=spreader_length+1, d=wood_screw_d, center=false, $fn=25);
            }
        }
    }
}