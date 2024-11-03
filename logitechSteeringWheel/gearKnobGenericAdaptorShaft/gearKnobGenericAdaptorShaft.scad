 /**
 * @file gearKnobGenericAdaptorShaft.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Replaces the shaft assembly with a generic Adaptor to replace the stock gear knob with a generic one for Logitech G25/27/29/920
 */
use <threadlib/threadlib.scad>
use <thread_profile.scad>


INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

/**
 */
module roundEdgeForSquarePeg(squarePegInsertWidth, squarePegInsertHeight) {
    roundEdgeRadius = squarePegInsertWidth/2;
    
    translate([roundEdgeRadius, 0, 0])
        linear_extrude(squarePegInsertHeight)
            difference() {
                circle(roundEdgeRadius, $fn=50);
                translate([0, -5, 0])
                    square([squarePegInsertWidth + 5, squarePegInsertWidth +5], center=true);
            }
}

/**
 * @brief Creates the gear knob adaptor shaft
 */
module gearKnobGenericAdaptorShaft() {
    gearLinkageShaftHeight = 86.30;
    gearLinkageShaftRadius = 5;
    
    connectionLength = 18;
    connectionInternalDiameter = 5.5;
    connectionExternalDiameter = 8;

    m4Radius = 2;
    screwFaceHeight = 3;
    theadOuterRadius = 6;

    squarePegInsertWidth = 7;
    squarePegInsertDepth = 5;
    squarePegInsertHeight = 24;

    /* For M4 Rivnut at 3mm then tap */
    m4ScrewHoleUnderSizeRadius = 3;
    m4ScrewHoleFromBottom = 14;

    union() {
        /* Gear Knob Fitting */
        /* 20mm Long */
        bolt("M12x1.25", turns=15);

        /* Gear Linkage Shaft */
        difference() {
            translate([0, 0, -gearLinkageShaftHeight])
                cylinder(gearLinkageShaftHeight, gearLinkageShaftRadius, gearLinkageShaftRadius, $fn=50);
            
            /* Gear Linkage Thru-Hole */
            rotate([90, 0, 0])
                translate([0, -gearLinkageShaftHeight + m4ScrewHoleUnderSizeRadius + m4ScrewHoleFromBottom, (-gearLinkageShaftRadius)])
                    cylinder((gearLinkageShaftRadius*2) + INTERFERENCE_FIT, m4ScrewHoleUnderSizeRadius, m4ScrewHoleUnderSizeRadius, $fn=30);
        }
        
        /* Gear Linkage Connecting Rod */
            translate([(-squarePegInsertWidth/2) + 2, -squarePegInsertDepth/2, -gearLinkageShaftHeight - squarePegInsertHeight])
                cube([squarePegInsertWidth - 4, squarePegInsertDepth, squarePegInsertHeight]);

        /* Gear Linkage Connecting Rod Round End */
        translate([(-squarePegInsertWidth/2) + 2, -squarePegInsertDepth/2, -gearLinkageShaftHeight - squarePegInsertHeight])
            rotate([0, 0, 90])
                roundEdgeForSquarePeg(squarePegInsertDepth, squarePegInsertHeight);

        /* Gear Linkage Connecting Rod Round End */
        translate([(squarePegInsertWidth/2) - 2, squarePegInsertDepth/2, -gearLinkageShaftHeight - squarePegInsertHeight])
            rotate([0, 0, -90])
                roundEdgeForSquarePeg(squarePegInsertDepth, squarePegInsertHeight);
    }
}

gearKnobGenericAdaptorShaft();