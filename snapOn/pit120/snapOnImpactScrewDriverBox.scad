/**
 * @file snapOnImpactScrewDriverBox.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief The chain adjuster bolt for the Cagiva Mito/Raptor/Planet swinging arm
 */

$fa = 0.01;
INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

BASE_WIDTH= 90;
BASE_LENGTH = 150;
WALL_THICKNESS = 3;
WALL_HEIGHT = 37.5;
SLIDE_WALL_THICKNESS = WALL_THICKNESS - 1;
SLIDE_WALL_HEIGHT= WALL_HEIGHT/2;

/**
 * @brief Mocks the driver so that it can be placed in the box as a reference.
 */
module snapOnInpactScrewDriver() {
    screwDriverBodyWidth = 32.00;
    screwDriverBodyDepth = 32.00;
    screwDriverBodyLength = 115.00;
    screwDriverDiameter = 35.75;
    
    screwDriverBodyInsertDiameter = 25.50;
    screwDriverBodyInsertHeight = 5;
    
    screwDriverImpactTaperDiameter = 17.00;
    screwDriverImpactTaperHeight = 10.00;
    
    screwDriverSocketWidth = 10.0;
    screwDriverSocketDepth = 10.0;
    screwDriverSocketHeight = 11.5;
    union() {
        intersection() {
            cylinder(screwDriverBodyLength, d = screwDriverDiameter, center=true);
            cube([screwDriverBodyWidth, screwDriverBodyDepth, screwDriverBodyLength], center = true);
        }
        translate([0, 0, ((screwDriverBodyLength + screwDriverBodyInsertHeight)/2) - INTERFERENCE_FIT])
            cylinder(screwDriverBodyInsertHeight, d = screwDriverBodyInsertDiameter, center = true);
        
        translate([0 , 0, ((screwDriverBodyLength + screwDriverBodyInsertHeight + screwDriverImpactTaperHeight)/2) - INTERFERENCE_FIT])
        cylinder(screwDriverImpactTaperHeight, d = screwDriverImpactTaperDiameter, center = true);
        translate([0 , 0, ((screwDriverBodyLength + screwDriverBodyInsertHeight + screwDriverImpactTaperHeight + screwDriverSocketHeight)/2) - INTERFERENCE_FIT])
        cube([screwDriverSocketWidth, screwDriverSocketDepth, screwDriverSocketHeight], center = true);
    }
}

/**
 * @brief Example socket insert so it can be placed in the box as a reference.
 */
module exampleSocket() {
    socketDiameter = 18.00;
    socketHeight = 15.00;
    
    socketInnerTaperDiameter = 16;
    socketInnerTaperTransitionHeight = 2.00;
    socketInnerTaperHeight = 9.5;
    
    socketBitWidth = 9.00;
    socketBitHeight = 22.00;
    
    union() {
        cylinder(socketHeight, d=socketDiameter, center = true);
        translate([0, 0, ((socketHeight + socketInnerTaperTransitionHeight)/2) - INTERFERENCE_FIT])
            cylinder(socketInnerTaperTransitionHeight, socketDiameter/2, socketInnerTaperDiameter/2, center = true);
        
        translate([0, 0, ((socketHeight + socketInnerTaperHeight)/2) + socketInnerTaperTransitionHeight - INTERFERENCE_FIT])
            cylinder(socketInnerTaperHeight, d = socketInnerTaperDiameter, center = true);

        translate([0, 0, ((socketHeight + socketBitHeight)/2) + socketInnerTaperHeight + socketInnerTaperTransitionHeight - INTERFERENCE_FIT])
            cube([socketBitWidth, socketBitWidth, socketBitHeight], center = true);
    }
}

/**
 * @brief Tray to hold the sockets in.
 */
module socketInsertBox(boxLength, boxWidth, socketDiameter, socketHeight) {
    difference() {
        cube([boxLength, boxWidth, socketDiameter], center = true);
        
        translate([-(socketDiameter * 3), 0, 0])
            cylinder(boxWidth + INTERFERENCE_FIT, d = socketDiameter, center = true);
        
        translate([-(socketDiameter * 2) + socketDiameter/2, 0, 0])
            cylinder(boxWidth + INTERFERENCE_FIT, d = socketDiameter, center = true);
        
        cylinder(boxWidth + INTERFERENCE_FIT, d = socketDiameter, center = true);
        
        translate([(socketDiameter * 3), 0, 0])
            cylinder(boxWidth + INTERFERENCE_FIT, d = socketDiameter, center = true);
        
        translate([(socketDiameter * 2) - socketDiameter/2, 0, 0])
            cylinder(boxWidth + INTERFERENCE_FIT, d = socketDiameter, center = true);
    }
}

/**
 * @brief Box to hold the screw driver and sockets.
 */
module snapOnImpactScrewDriverBox(wallThickness, wallHeight, slideWallThickness, slideWallHeight, baseWidth, baseLength) {

    socketDiameterWithSlack = 20.00;
    socketDiameterHeight = 17.50;
    socketTrayWidth = socketDiameterWithSlack + 5.00;

    baseSocketReinforcementWidth = baseWidth - (socketTrayWidth*2);

    union() {
        /* Base plate */
        color("red")
            cube([baseLength, baseWidth, wallThickness], center=true);
        /* Screw Driver Base Plate Reinforcement */
        color("white")
            translate([0, 0, wallThickness/2])
                cube([baseLength - wallThickness + INTERFERENCE_FIT, baseSocketReinforcementWidth, wallThickness], center=true);

        /* Back Wall */
        translate([-(baseLength - wallThickness)/2, 0, ((wallThickness + wallHeight)/2) - INTERFERENCE_FIT])
            union() {            
                cube([wallThickness, baseWidth, wallHeight], center=true);
                translate([slideWallThickness/2 ,0, (wallHeight + slideWallHeight)/2])
                    cube([slideWallThickness/2, (baseWidth - (wallThickness*2)) + INTERFERENCE_FIT, slideWallHeight], center=true);
            }

        /* Front Wall */
        translate([(baseLength - wallThickness)/2, 0, ((wallThickness + wallHeight)/2) - INTERFERENCE_FIT])
            union() {            
                cube([wallThickness, baseWidth, wallHeight], center=true);
                translate([-slideWallThickness/2 ,0, (wallHeight + slideWallHeight)/2])
                    cube([slideWallThickness/2, (baseWidth - (wallThickness*2)) + INTERFERENCE_FIT, slideWallHeight], center=true);
            }

        /* Side Wall */
        translate([0, (baseWidth - wallThickness)/2, ((wallThickness + wallHeight)/2) - INTERFERENCE_FIT])
            union() {
                cube([baseLength, wallThickness, wallHeight], center=true);
                translate([0, -slideWallThickness/2, (wallHeight + slideWallHeight)/2])
                    cube([baseLength - (slideWallThickness*2), slideWallThickness/2, slideWallHeight], center=true);
            }

        translate([0, -(baseWidth - wallThickness)/2, ((wallThickness + wallHeight)/2) - INTERFERENCE_FIT])
            union() {
                cube([baseLength, wallThickness, wallHeight], center=true);
                translate([0, slideWallThickness/2, (wallHeight + slideWallHeight)/2])
                    cube([baseLength - (slideWallThickness*2), slideWallThickness/2, slideWallHeight], center=true);
            }

        /* Socket Inserts */
        translate([0, (baseWidth - socketTrayWidth - wallThickness)/2, ((socketDiameterHeight + wallThickness)/2) - INTERFERENCE_FIT])
            socketInsertBox((baseLength - (wallThickness*2)), socketTrayWidth, socketDiameterWithSlack, socketDiameterHeight);
        
        translate([0, -(baseWidth - socketTrayWidth - wallThickness)/2, ((socketDiameterHeight + wallThickness)/2) - INTERFERENCE_FIT])
            socketInsertBox((baseLength - (wallThickness*2)), socketTrayWidth, socketDiameterWithSlack, socketDiameterHeight);
    }
}

module snapOnImpactScrewDriverLid(wallThickness, wallHeight, baseWidth, baseLength) {
    slideInterferenceFit = 0.15;
    
    union() {
        /* Lid */
        difference() {
            cube([baseLength, baseWidth, wallThickness], center = true);
            translate([-30, 0, (wallThickness/2) - INTERFERENCE_FIT])
                union() {
                    linear_extrude(wallThickness/2, center = true)
                        text("Snap-On", size=10);
                    translate([-13, -10, 0])
                    linear_extrude(wallThickness/2, center = true)
                        text("Impact Driver", size=10);
                }
        }
        
        /* Front Wall */
        translate([(baseLength - wallThickness + slideInterferenceFit)/2, 0, -((wallThickness + wallHeight)/2) + INTERFERENCE_FIT])
            cube([wallThickness - slideInterferenceFit, baseWidth, wallHeight], center=true);
        
        /* Back Wall */
        translate([-(baseLength - wallThickness + slideInterferenceFit)/2, 0, -((wallThickness + wallHeight)/2) + INTERFERENCE_FIT])
            cube([wallThickness - slideInterferenceFit, baseWidth, wallHeight], center=true);
        
        /* Side Walls */
        translate([0, (baseWidth - wallThickness + slideInterferenceFit)/2, -((wallThickness + wallHeight)/2) + INTERFERENCE_FIT])
            cube([baseLength - wallThickness, wallThickness - slideInterferenceFit, wallHeight], center=true);
        translate([0, -(baseWidth - wallThickness + slideInterferenceFit)/2, -((wallThickness + wallHeight)/2) +INTERFERENCE_FIT])
            cube([baseLength - wallThickness, wallThickness - slideInterferenceFit, wallHeight], center=true);
    }
}

snapOnImpactScrewDriverBox(WALL_THICKNESS, WALL_HEIGHT, SLIDE_WALL_THICKNESS, SLIDE_WALL_HEIGHT, BASE_WIDTH, BASE_LENGTH);

//translate([0, -BASE_WIDTH, (WALL_HEIGHT * 1.5) + 3])
//   rotate([30, 0, 0])
//        snapOnImpactScrewDriverLid(SLIDE_WALL_THICKNESS, SLIDE_WALL_HEIGHT, BASE_WIDTH, BASE_LENGTH);

//color("grey")
//    translate([-10, 0, 20])
//        rotate([0, 90, 0])
//            snapOnInpactScrewDriver();
//
//color("grey")
//    translate([-60, 30, 10])
//        exampleSocket();
//color("grey")
//    translate([-30, 30, 10])
//        exampleSocket();
//color("grey")
//    translate([0, 30, 10])
//        exampleSocket();
//color("grey")
//    translate([30, 30, 10])
//        exampleSocket();
//color("grey")
//    translate([60, 30, 10])
//        exampleSocket();
//color("grey")
//    translate([-60, -30, 10])
//        exampleSocket();
//color("grey")
//    translate([-30, -30, 10])
//        exampleSocket();
//color("grey")
//    translate([0, -30, 10])
//        exampleSocket();
//color("grey")
//    translate([30, -30, 10])
//        exampleSocket();
//color("grey")
//    translate([60, -30, 10])
//        exampleSocket();