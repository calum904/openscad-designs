/**
 * @file inletManifold.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Inlet manifold designed to accept a 32mm VHSA carburetor at an altered
 *        angle as to avoid the shock.
 */
INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.5;

IMAGES_DIR = "./images/";
BASE_LOGO = str(IMAGES_DIR, "base.svg");

BASE_THICKNESS = 6.5;
TEXT_THICKNESS = 5;
BACKING_THICKNESS = 5;

/**
 * @brief Uses a traced approximation to render the base
 */
module basePlateSvg() {
    linear_extrude(BASE_THICKNESS)
        import(BASE_LOGO);
}

/**
 * @brief Uses geometry to render the base
 */
module basePlate(manifoldCutoutY, manifoldCutoutXOffset) {
    basePlateX = 65;
    basePlateY = 62.75;
    
    cornerRadius = 6.75;
    screwHoleRadius = 3.5;

    difference() {
        /* Base Plate */
        union() {
            cube([basePlateX, basePlateY, BASE_THICKNESS], center=true);
            
            /* Top Right */
            translate([basePlateX/2, (basePlateY/2) - cornerRadius, 0])
                cylinder(BASE_THICKNESS, cornerRadius, cornerRadius, center=true, $fn=50);
            
            /* Bottom Right */
            translate([basePlateX/2, (-basePlateY/2) + cornerRadius, 0])
                cylinder(BASE_THICKNESS, cornerRadius, cornerRadius, center=true, $fn=50);
            
            /* Top Left */
            translate([-basePlateX/2, (basePlateY/2) - cornerRadius, 0])
                cylinder(BASE_THICKNESS, cornerRadius, cornerRadius, center=true, $fn=50);
            
            /* Bottom Left */
            translate([-basePlateX/2, (-basePlateY/2) + cornerRadius, 0])
                cylinder(BASE_THICKNESS, cornerRadius, cornerRadius, center=true, $fn=50);
        }
        
        /* Screw Holes */
        /* Top Right */
        translate([basePlateX/2, (basePlateY/2) - cornerRadius, 0])
            cylinder(BASE_THICKNESS + INTERFERENCE_FIT, screwHoleRadius, screwHoleRadius, center=true, $fn=50);
        
        /* Bottom Right */
        translate([basePlateX/2, (-basePlateY/2) + cornerRadius, 0])
            cylinder(BASE_THICKNESS + INTERFERENCE_FIT, screwHoleRadius, screwHoleRadius, center=true, $fn=50);
        
        /* Top Left */
        translate([-basePlateX/2, (basePlateY/2) - cornerRadius, 0])
            cylinder(BASE_THICKNESS + INTERFERENCE_FIT, screwHoleRadius, screwHoleRadius, center=true, $fn=50);
        
        /* Bottom Left */
        translate([-basePlateX/2, (-basePlateY/2) + cornerRadius, 0])
            cylinder(BASE_THICKNESS + INTERFERENCE_FIT, screwHoleRadius, screwHoleRadius, center=true, $fn=50);

        /* Manifold Cutout */
        translate([manifoldCutoutXOffset, 0, 0])
            inletManifoldOval(BASE_THICKNESS + INTERFERENCE_FIT, manifoldCutoutY);
    }
}

module inletManifoldOval(baseThickness, manifoldCutoutY, ) {
    union() {
            /* Right Oval Cutout */
        translate([3.5, 0, 0])            
            cylinder(baseThickness, manifoldCutoutY/2, manifoldCutoutY/2, center=true, $fn=150);
        
        /* Center Cutout */
        cube([7, manifoldCutoutY, baseThickness], center=true);
        
        /* Right Oval Cutout */
        translate([-3.5, 0, 0])            
            cylinder(baseThickness, manifoldCutoutY/2, manifoldCutoutY/2, center=true, $fn=150);
    }
}

module vhsaCarbMount() {
    vhsaInletOuterRadius = 20;
    vhsaInletInnerRadius = 16.875;
    vhsaInletInnerHeight = 15;
    
    vhsaMountOuterRadius = vhsaInletOuterRadius + 5;
    vhsaMountOuterHeight = 5;

    difference() {
        union() {
            difference() {
                cylinder(vhsaInletInnerHeight, vhsaMountOuterRadius, vhsaMountOuterRadius, center=true, $fn=50);
                cylinder(vhsaInletInnerHeight + INTERFERENCE_FIT, vhsaInletInnerRadius, vhsaInletInnerRadius, center=true, $fn=50);
            }

            /* Slide Groove Mount */
            translate([0, 0, ((vhsaInletInnerHeight + vhsaMountOuterHeight)/2) - INTERFERENCE_FIT])
                difference() {
                    cylinder(vhsaMountOuterHeight, vhsaMountOuterRadius, vhsaMountOuterRadius, center=true, $fn=50);
                    cylinder(vhsaMountOuterHeight + INTERFERENCE_FIT, vhsaInletOuterRadius + SLIDE_FIT, vhsaInletOuterRadius + SLIDE_FIT, center=true, $fn=50);

                    /* Joining Rubber Locating Groove */
                    translate([0, 0, -2])
                        difference() {
                            cylinder(vhsaMountOuterHeight, vhsaMountOuterRadius + INTERFERENCE_FIT, vhsaMountOuterRadius + INTERFERENCE_FIT, center=true, $fn=50);
                            cylinder(vhsaMountOuterHeight + INTERFERENCE_FIT, vhsaMountOuterRadius  - SLIDE_FIT, vhsaMountOuterRadius - SLIDE_FIT, center=true, $fn=50);
                        }
                }
        }
    }
}

module inletManifoldToOval(manifoldCutoutY, inletManifoldToOvalHeight, manifoldToCarbAngle, manifoldToCarbThickness) {
    cubeCutLength = sqrt((50*50) + (inletManifoldToOvalHeight * inletManifoldToOvalHeight));
    vhsaInletInnerRadius = 16.875;
    
    
    union() {

        difference() {
            inletManifoldOval(inletManifoldToOvalHeight, manifoldCutoutY + 10);
            inletManifoldOval(inletManifoldToOvalHeight + INTERFERENCE_FIT, manifoldCutoutY);
            
            translate([0, 0, 4.105])
                rotate([0, manifoldToCarbAngle, 0])
                    cube([cubeCutLength, 50, inletManifoldToOvalHeight], center=true);
        }
        
//        translate([-0.5, 0, inletManifoldToOvalHeight/2])
////            rotate([0, 0, 0])
////                difference() {
////                    inletManifoldOval(inletManifoldToOvalHeight, manifoldCutoutY + 10);
////                    inletManifoldOval(inletManifoldToOvalHeight + INTERFERENCE_FIT, manifoldCutoutY);
//            translate([0, 0, 4.105])
//                rotate([0, -manifoldToCarbAngle, 0])
//                    cube([cubeCutLength, 50, inletManifoldToOvalHeight], center=true);        
//                }
//        translate([0, 0, inletManifoldToOvalHeight/2])
//            rotate([0, manifoldToCarbAngle, 0])
//                cylinder(10, vhsaInletInnerRadius, vhsaInletInnerRadius, center=true);
    }
}

module inletManifold() {
    manifoldCutoutY = 29;
    manifoldCutoutXOffset = 2.5;
    manifoldToCarbAngle = -10;
    
    inletManifoldToOvalHeight = (tan(abs(manifoldToCarbAngle)) * 46);
    
    union() {
        
        color("blue")
            basePlate(manifoldCutoutY, manifoldCutoutXOffset);
        
        translate([manifoldCutoutXOffset, 0, BASE_THICKNESS - INTERFERENCE_FIT])
            union() {
                /* Initial Lead In */
                color("white")
                    difference() {
                        inletManifoldOval(BASE_THICKNESS, manifoldCutoutY + 10);
                        inletManifoldOval(BASE_THICKNESS + INTERFERENCE_FIT, manifoldCutoutY);
                    }
                
                color("yellow")
                    translate([0, 0, ((inletManifoldToOvalHeight+BASE_THICKNESS)/2) - INTERFERENCE_FIT])
                        inletManifoldToOval(manifoldCutoutY, inletManifoldToOvalHeight, manifoldToCarbAngle, BASE_THICKNESS);
                
                color("red")
                    translate([0, 0,((inletManifoldToOvalHeight+BASE_THICKNESS +30)/2) - INTERFERENCE_FIT])
                        rotate([0, manifoldToCarbAngle, 0])
                            vhsaCarbMount();
            }
    }
}

inletManifold();