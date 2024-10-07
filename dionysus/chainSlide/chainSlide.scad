/**
 * @file apriliaRxChainSlide.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Chain slide for the Aprilia ETX/MX/RX/SX 125 1990-2011.
 */
$fa = 0.01;
 
INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

CHAIN_SLIDE_DEPTH = 22;

/**
 * @brief Creates a through hole for the bolt to go through.
 */
module chainSlideThroughHole() {
     CHAIN_SLIDE_DEPTH = 22;
     boltStayRadius = 4;
    
     cylinder(CHAIN_SLIDE_DEPTH + SLIDE_FIT, boltStayRadius, boltStayRadius, center=true, $fn=15);
}

/**
 * @brief Creates the chain slide bolt through holes.
 */
module chainSlideThroughHoles() {
    holeDistance = 51;
    holeSpacing = holeDistance/2;
    
    union() {
        /* Right Hole */
        translate([holeSpacing, 0, 0])
            chainSlideThroughHole();
        
        /* Left Hole */
        translate([-holeSpacing, 0, 0])
            chainSlideThroughHole();
     }
}

/**
 */
module chainSlideMainBody() {
    mainBodyWidth = 51.5;
    
    endTailWidth = 33;
    endCylinderRadius = 7.5;
    
    union() {
        /* Right End */
        translate([25, 0, 0])
            cylinder(CHAIN_SLIDE_DEPTH, CHAIN_SLIDE_DEPTH/2, CHAIN_SLIDE_DEPTH/2, center=true);

        /* Main Body */
        translate([0, 2, 0])
            cube([mainBodyWidth, 18, CHAIN_SLIDE_DEPTH], center=true);
        
        /* Left End */
        translate([-25, 0, 0])
            cylinder(CHAIN_SLIDE_DEPTH, CHAIN_SLIDE_DEPTH/2, CHAIN_SLIDE_DEPTH/2, center=true);
        
        /* Tail End */
        translate([-45, 5.5, 0])
            rotate([0, 0, 5])
            cube([endTailWidth + 7.5, endCylinderRadius, CHAIN_SLIDE_DEPTH], center=true);
        
        translate([-49, 0, 0])
            cube([endTailWidth, endCylinderRadius*2, CHAIN_SLIDE_DEPTH], center=true);
        
        translate([-25 - 41, 0, 0])
            cylinder(CHAIN_SLIDE_DEPTH, endCylinderRadius, endCylinderRadius, center=true);
    }
}
/**
 * @brief Chain slide.
 */
module chainSlide() {
    difference() {
        chainSlideMainBody();
        chainSlideThroughHoles();     
    }
}
 
chainSlide();