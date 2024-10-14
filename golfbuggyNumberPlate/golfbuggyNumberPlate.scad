 /**
 * @file golfbuggyNumberPlate.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Golfbuggy numberplate
 */
INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

NUMBERPLATE_REG = "RN1";

/**
 * @brief Handlebar mount
 */
module handlebarMount() {
    mountBracketWidth = 13;

    union() {
        rotate([0, 90, 0])
            difference() {
                cylinder(25, 17, 17, center=true);
                cylinder(25 + INTERFERENCE_FIT, 12.5, 12.5, center=true);
                translate([0, -8, 0])
                    cube([2, 25, 34 + INTERFERENCE_FIT], center=true);
            }
            
            /* Body Between Number Plate Mount and Handlebar Mount */
            /* Top Mount */
            translate([0, 0, -8.5])
                union() {
                    translate([0, -17.5, 5])
                        cube([25, 5, 5], center=true);
                    
                    translate([0, -30, 5])
                        difference() {
                            cube([mountBracketWidth, 20, 5], center=true);
                            cylinder(5 + INTERFERENCE_FIT, 3, 3, center=true, $fn=50);
                            translate([0, -12, 0])
                                cube([mountBracketWidth + INTERFERENCE_FIT, 10, 5 + INTERFERENCE_FIT], center=true);
                        }
                }

            /* Bottom Mount */
            union() {
                translate([0, -17.5, 3.5])
                    cube([25, 5, 5], center=true);

                translate([0, -30, 3.5])
                    difference() {
                            cube([mountBracketWidth, 20, 5], center=true);
                            cylinder(5 + INTERFERENCE_FIT, 3, 3, center=true, $fn=50);
                            translate([0, 0, 0])
                            cylinder(3, 4, 4, $fn=6);
                        }
            }

            /* Circle Pick Up Between Number Plate Mounts */
            translate([-0, -43, 3])
                difference() {
                    rotate([0, 90, 0])
                        cylinder(mountBracketWidth, 5, 5, center=true);
                    rotate([0, 90, 0])
                        cylinder(mountBracketWidth + INTERFERENCE_FIT, 3, 3, center=true, $fn=50);
                }
    }
}

/**
 * @brief The mounting bracket to affix the number plate to the buggy
 */
module mountingBracket() {
    bracketThickness = 10;
    bracketHeight = 17.5;
    bracketWidth = 50;

    difference() {
        union() {
            rotate([90, 0, 90])
                difference() {
                    cylinder(bracketThickness, bracketHeight, bracketHeight, center=true, $fn=50);
                    translate([0, 10, 0])
                        cube([50, 30, 20], center=true);
                }

            translate([25, 0, 0])
                rotate([90, 0, 90])
                    difference() {
                        cylinder(bracketThickness, bracketHeight, bracketHeight, center=true, $fn=50);
                        translate([0, 10, 0])
                            cube([50, 30, 20], center=true);
                    }
        }

        translate([12.5, 0, -12])
            rotate([0, 90, 0])
                cylinder(35 + INTERFERENCE_FIT, 3, 3, center=true, $fn=50);
    }
}

/**
 * @brief Creates a number plate
 */
module golfbuggyNumberPlate() {
    union() {

        difference() {
            color("black")
                cube([200, 100, 3], center=true);
            color("white")
                translate([0, 0, +1 + INTERFERENCE_FIT])
                    cube([198, 98, 1], center=true);
        }

        color("black")
            translate([-97, -33, 1])
                linear_extrude(1, center=true)
                    text(NUMBERPLATE_REG, size=70);

        translate([-12.5, 33.2, 5])
            mountingBracket();
    }
}

golfbuggyNumberPlate();

color("black")
    translate([0, 76, -10])
        handlebarMount();