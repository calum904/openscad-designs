/**
 * @file deskCableBungPenHolder.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Pen Holder that sits inside the cable tidy hole on a desk.
 */

$fa = 0.01;
INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

HOLE_DIAMETER = 50.00;

module penHolder(holeDiameter) {
    penHolderHeight = 110.00;
    wallThickness = 1.75;
    lipOffset = 5.00;
    
    union() {
        /* Top Lip */
        translate([0, 0, ((penHolderHeight)/2 - wallThickness)])
            difference() {
                cylinder(wallThickness * 2, (holeDiameter + (lipOffset*2))/2, ((holeDiameter + (lipOffset*2))/2) - 5, center=true, $fn=100);
                cylinder((wallThickness * 2)+ INTERFERENCE_FIT, d=holeDiameter, center=true, $fn=100);
            }

        /* Grip Ridge*/
        translate([0, 0, ((penHolderHeight)/2 - (wallThickness * 4))])
        difference() {
            cylinder(wallThickness, d=(holeDiameter + wallThickness/4), center=true, $fn=100);
            translate([0, 0, wallThickness*2])
                cylinder(penHolderHeight, d=(holeDiameter - (wallThickness * 2)), center=true, $fn=100);
        }

        /* Grip Ridge*/
        translate([0, 0, ((penHolderHeight)/2 - (wallThickness * 6))])
        difference() {
            cylinder(wallThickness, d=(holeDiameter + wallThickness/4), center=true, $fn=100);
            translate([0, 0, wallThickness*2])
                cylinder(penHolderHeight, d=(holeDiameter - (wallThickness * 2)), center=true, $fn=100);
        }

        /* Grip Ridge*/
        translate([0, 0, ((penHolderHeight)/2 - (wallThickness * 8))])
        difference() {
            cylinder(wallThickness, d=(holeDiameter + wallThickness/4), center=true, $fn=100);
            translate([0, 0, wallThickness*2])
                cylinder(penHolderHeight, d=(holeDiameter - (wallThickness * 2)), center=true, $fn=100);
        }

        /* Body */
        difference() {
            cylinder(penHolderHeight, d=holeDiameter, center=true, $fn=100);
            translate([0, 0, wallThickness*2])
                cylinder(penHolderHeight, d=(holeDiameter - (wallThickness * 2)), center=true, $fn=100);
        }
        
    }
}

penHolder(HOLE_DIAMETER);