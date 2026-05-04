/**
 * @file blueLightBlockLightPanelStand.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Floor stand for the 'Blue Light Block Red Light Panel'.
 */

$fa = 0.01;
INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

PANEL_HEIGHT = 535.00;
PANEL_WIDTH  = 210.00;
PANEL_DEPTH  = 65.00;
PANEL_FEET_RADIUS_1 = 19.00/2;
PANEL_FEET_RADIUS_2 = 25.00/2;
PANEL_FEET_HEIGHT = 14.00;
PANEL_BACK_FEET_HEIGHT = 19.00;
BASE_STAND_HEIGHT = 85.00;

/**
 * @brief Blue light block panel base feet.
 */
module blueLightBlockPanelFeet(panelFeetHeight, panelFeetRadius1, panelFeetRadius2) {
    feetWidthSpacingApart = 33.50;
    feetLengthSpacingApart = 140.00;
    union () {
        /* Front Right Foot */
        translate([feetLengthSpacingApart/2, -feetWidthSpacingApart/2, 0])
            cylinder(panelFeetHeight, panelFeetRadius1, panelFeetRadius2, center=true);
        
        /* Back Right Foot */
        translate([feetLengthSpacingApart/2, feetWidthSpacingApart/2, 0])
            cylinder(panelFeetHeight, panelFeetRadius1, panelFeetRadius2, center=true);
        
        /* Front Left Foot */
        translate([-feetLengthSpacingApart/2, -feetWidthSpacingApart/2, 0])
            cylinder(panelFeetHeight, panelFeetRadius1, panelFeetRadius2, center=true);
        
        /* Back Left Foot */
        translate([-feetLengthSpacingApart/2, feetWidthSpacingApart/2, 0])
            cylinder(panelFeetHeight, panelFeetRadius1, panelFeetRadius2, center=true);
    }
}

/**
 * @brief Blue light block panel back feet.
 */
module blueLightBlockPanelBackFeet(panelFeetHeight, panelFeetRadius1, panelFeetRadius2) {
    feetWidthSpacingApart = 210.00 - (panelFeetRadius2 * 2) - 21.85;
    feetLengthSpacingApart = 535.00 - (panelFeetRadius2 * 2) - 12.85;
    union () {
        /* Front Right Foot */
        translate([feetLengthSpacingApart/2, -feetWidthSpacingApart/2, 0])
            cylinder(panelFeetHeight, panelFeetRadius1, panelFeetRadius2, center=true);
        
        /* Back Right Foot */
        translate([feetLengthSpacingApart/2, feetWidthSpacingApart/2, 0])
            cylinder(panelFeetHeight, panelFeetRadius1, panelFeetRadius2, center=true);
        
        /* Front Left Foot */
        translate([-feetLengthSpacingApart/2, -feetWidthSpacingApart/2, 0])
            cylinder(panelFeetHeight, panelFeetRadius1, panelFeetRadius2, center=true);
        
        /* Back Left Foot */
        translate([-feetLengthSpacingApart/2, feetWidthSpacingApart/2, 0])
            cylinder(panelFeetHeight, panelFeetRadius1, panelFeetRadius2, center=true);
    }
}


/**
 * @brief LEDs
*/
module blueLightBlockRedLeds(ledCoverSize) {
    numberOfLedsPerHeight = 24;
    numberOfLedsPerWidth = 5;
    ledCoverSpacing = 12.75;
    ledCoverHeightSpacing = 1.00;
    union() {
        for ( j = [0 : numberOfLedsPerHeight-1]) {
            ledHeightIndex = j * ledCoverSize * 2 + (j * ledCoverHeightSpacing);
            ledWidthOffset = j % 2 ? ledCoverSize : 0;
            translate([ledWidthOffset, ledHeightIndex, 0])
                union() {
                    for (i = [0: numberOfLedsPerWidth-1]) {
                        translate([(i * ledCoverSize * 2) + ledCoverSpacing * i, 0 , 0])
                            cylinder(10, ledCoverSize, ledCoverSize, center=true);
                    }
                }
        }
    }
}

/**
 * @brief Mock up of the blue light panel.
 */
module blueLightBlockPanel(panelHeight, panelWidth, panelDepth, panelFeetHeight, panelBackFeetHeight, panelFeetRadius1, panelFeetRadius2, renderLeds) {
    ledCoverSize = 19.50/2;
    ledDistanceFromBottom = 27.00;
    ledDistanceFromEdge = 22.00;

    powerSocketDepth = 10;
    powerSocketWidth = 50;
    powerSocketHeight = 50;
    powerSocketDistanceFromSide = 61.30;
    powerSocketDistanceFromBottom = 21.75;
    
    union() {
        difference() {
            color("white")
                cube([panelWidth, panelDepth, panelHeight], center=true);
            
            if (renderLeds)
                translate([(-(panelWidth)/2) + ledCoverSize + ledDistanceFromEdge, -panelDepth/2, -((panelHeight)/2) + ledCoverSize + ledDistanceFromBottom])
                    rotate([90, 0, 0])
                        color("red")
                            blueLightBlockRedLeds(ledCoverSize);
        }
        
        /* Bottom Feet */
        translate([0, 0, (-(panelHeight + panelFeetHeight)/2) + INTERFERENCE_FIT])
            blueLightBlockPanelFeet(panelFeetHeight, panelFeetRadius1, panelFeetRadius2);
        
        /* Back Feet */
        translate([0, ((panelDepth + panelBackFeetHeight)/2) + INTERFERENCE_FIT, 0])
            rotate([90, 90, 0])
                blueLightBlockPanelBackFeet(panelBackFeetHeight, panelFeetRadius1, panelFeetRadius2);
        
        /* Power Socket */
        
        translate([((panelWidth - powerSocketWidth)/2) - powerSocketDistanceFromSide, panelDepth/2, (-(panelHeight - powerSocketHeight)/2) + powerSocketDistanceFromBottom])
            cube([powerSocketWidth, powerSocketDepth, powerSocketHeight], center=true);
    }
            
}

module blueLightBlockPanelStand(panelHeight, panelWidth, panelDepth, panelFeetHeight, panelBackFeetHeight, panelFeetRadius1, panelFeetRadius2, baseStandHeight) {
    standWallThickness = 10.00;
    standWallHeight = 40.00 + baseStandHeight;
    panelGap = 5.00;
    
    union() {
        difference() {
            rounded_box(panelWidth + (standWallThickness * 2), panelDepth + (standWallThickness * 2), standWallHeight, 5);
            translate([0, 0, ((panelHeight + standWallHeight - panelGap)/2) - 20])
                rounded_box(panelWidth + panelGap, panelDepth + panelGap, panelHeight, 5);
            translate([0, 0, ((panelHeight + standWallHeight)/2) - 20])
                blueLightBlockPanel(panelHeight, panelWidth, panelDepth, panelFeetHeight + panelGap, panelBackFeetHeight + panelGap, panelFeetRadius1 + panelGap/2, panelFeetRadius2 + panelGap/2, false);
        }
        
        /* Base Stand */
        translate([((-standWallThickness-panelWidth)/2), (panelDepth/2), (panelGap-baseStandHeight)/2  -baseStandHeight/4])
            rotate([90, 0, 90])
                right_triangle(panelDepth, baseStandHeight/2, panelWidth + standWallThickness);
        
        /* Base Stand */
        translate([((standWallThickness+panelWidth)/2), -(panelDepth/2), (panelGap-baseStandHeight)/2  -baseStandHeight/4])
            rotate([90, 0, -90])
                right_triangle(panelDepth, baseStandHeight/2, panelWidth + standWallThickness);
    }
}

module rounded_box(x, y, z, r) {
    hull() {
        for(i=[-1,1]) for(j=[-1,1]) for(k=[-1,1])
            translate([i*(x/2-r), j*(y/2-r), k*(z/2-r)])
                sphere(r=r, $fn=30);
    }
}

module right_triangle(base, height, thickness) {
    linear_extrude(height = thickness) {
        polygon(points=[[0,0],[base,0],[0,height]]);
    }
}

//translate([0, 0, (PANEL_HEIGHT + BASE_STAND_HEIGHT)/2])
//    blueLightBlockPanel(PANEL_HEIGHT, PANEL_WIDTH, PANEL_DEPTH, PANEL_FEET_HEIGHT, PANEL_BACK_FEET_HEIGHT,  PANEL_FEET_RADIUS_1, PANEL_FEET_RADIUS_2, true);
blueLightBlockPanelStand(PANEL_HEIGHT, PANEL_WIDTH, PANEL_DEPTH, PANEL_FEET_HEIGHT, PANEL_BACK_FEET_HEIGHT, PANEL_FEET_RADIUS_1, PANEL_FEET_RADIUS_2, BASE_STAND_HEIGHT);