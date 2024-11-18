/**
 * @file exoticCarbonForkBrakeGuide.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief A guide for the brake line that wraps around the fork leg of eXotic Carbon fork leg
 */

$fa = 0.01;

INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;


/**
 * @brief Makes a brake clamp
 */
module brakeLineClamp() {
    brakeHoseRadius = 2;
    brakeHoseHeight = 2;
    clampDepth = 10;
    
    union() {
        difference() {
            cube([3, clampDepth, clampDepth], center=true);
            rotate([0, 90, 0])
                cylinder(3 + INTERFERENCE_FIT, 2, 2, center=true, $fn=20);
        }

        translate([1.5, -((clampDepth/2) + brakeHoseHeight - 1), 0])
            difference() {
                cylinder(brakeHoseHeight, brakeHoseRadius, brakeHoseRadius, center=true, $fn=20);
                cylinder(brakeHoseHeight + INTERFERENCE_FIT, brakeHoseRadius - 0.5, brakeHoseRadius - 0.5, center=true, $fn=20);
                translate([brakeHoseRadius, 0, 0])
                    cube([brakeHoseRadius * 2, brakeHoseRadius * 2, brakeHoseRadius + INTERFERENCE_FIT], center=true);    
            }
        
    }
}

/**
 * @brief Creates a pivot through hole
 */
module pivotThroughHole() {
    throughHoleHeight = 5;

    union() {
        difference() {
            translate([-1.1, -1, 0])
                cube([1.3, 3, throughHoleHeight], center=true);
                cylinder(throughHoleHeight + INTERFERENCE_FIT, 2, 2, center=true, $fn=20);
        }

        difference() {
            cylinder(throughHoleHeight, 2, 2, center=true, $fn=20);
            cylinder(throughHoleHeight + INTERFERENCE_FIT, 1.5, 1.5, center=true, $fn=20);
        }
    }
}

module brakeGuide() {
    forkRadius = 16.5;
    brakeGuideHeight = 20;

    pivotThroughHoleOffset = forkRadius + 5;
    
    union() {
        /* Left Side */
        union() {
            difference() {
                cylinder(brakeGuideHeight, forkRadius + 3, forkRadius + 3, center=true, $fn=100);
                cylinder(brakeGuideHeight + INTERFERENCE_FIT, forkRadius, forkRadius, center=true, $fn=100);
                translate([forkRadius, 0, 0])
                    cube([forkRadius*2, forkRadius*4, brakeGuideHeight + INTERFERENCE_FIT], center=true);
            }

            translate([0.5, pivotThroughHoleOffset, 6])
                pivotThroughHole();
            translate([0.5, pivotThroughHoleOffset, -6])
                pivotThroughHole();
        }

        /* Right Side */
        translate([1, 0, 0])
            union() {
                difference() {
                    cylinder(brakeGuideHeight, forkRadius + 3, forkRadius + 3, center=true, $fn=100);
                    cylinder(brakeGuideHeight + INTERFERENCE_FIT, forkRadius, forkRadius, center=true, $fn=100);
                    translate([-forkRadius, 0, 0])
                        cube([forkRadius*2, forkRadius*4, brakeGuideHeight + INTERFERENCE_FIT], center=true);
                }

                translate([-0.5, pivotThroughHoleOffset, 0])
                    rotate([0, 180, 0])
                        pivotThroughHole();
            }

        /* Pivot Pin */
        translate([0.5, pivotThroughHoleOffset, 0])
            union() {
                /* Top Pivot Clamp */
                translate([0, 0, (brakeGuideHeight)/2 - 0.5])
                    cylinder(1, 1.8, 1.8, center=true, $fn=20);
                /* Pivot */
                cylinder(brakeGuideHeight, 1.3, 1.3, center=true, $fn=20);
                
                /* Bottom Pivot Clamp */
                translate([0, 0, -(brakeGuideHeight)/2 + 0.5])
                    cylinder(1, 1.8, 1.8, center=true, $fn=20);
            }

        /* Clamp */
        translate([-1.5, -forkRadius - 7, 5])
            brakeLineClamp();
            
        translate([2.5, -forkRadius - 7, 5])
            rotate([0, 180, 0])
                brakeLineClamp();
    }
}

brakeGuide();