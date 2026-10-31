/**
 * @file headlightCowlInstrumentBracketRepair.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Fix for broken Aprilia ETX 125 instrument bracket that hangs off the headlight cowl.
 */
use <headlightCowlInstrumentBracket.scad>;

INTERFERENCE_FIT=0.01;
SLIDE_FIT=0.05;

module repairPart(bracketWidth, bracketHeight, bracketLength, bracketCubeHole) {

    cutOriginalPartOffset = -11.3;
    cutSquareDepth = 15;
    
    repairPartWidth = bracketWidth - (bracketHeight*2) - (SLIDE_FIT * 2);
    repairPartDepth = 12.5;
    repairPartHeight = bracketHeight + 2.00;

    rampWidth = 6.5;
    
    union() {
        difference() {
            originalBracketPiece(bracketWidth, bracketHeight, bracketLength, bracketCubeHole);
            translate([0, cutOriginalPartOffset, 0])
                cube([bracketWidth + INTERFERENCE_FIT, cutSquareDepth, bracketHeight + INTERFERENCE_FIT], center=true);
        }
        
        /* Repair Joining Piece */
        translate([0, 3.7, 0])
            difference() {
                cube([bracketWidth, cutSquareDepth, repairPartHeight], center=true);
                originalBracketHole(bracketCubeHole, repairPartHeight + INTERFERENCE_FIT);
                translate([0, cutSquareDepth/2, 0])
                    cube([bracketWidth + INTERFERENCE_FIT, cutSquareDepth, repairPartHeight + INTERFERENCE_FIT], center=true);
            }
        
        /* Repair Insert */
        translate([0, -(10), 0])
            difference() {
                cube([repairPartWidth, repairPartDepth, repairPartHeight], center=true);
                cube([repairPartWidth + INTERFERENCE_FIT, repairPartDepth + INTERFERENCE_FIT, bracketHeight], center=true);
            }

        /* Ramps */
        translate([(bracketWidth-rampWidth)/2, 3.7, bracketHeight/2])
            rotate([90, 0, 90])
                right_angle_triangle(2, 1, 6.50);
        
        translate([-(bracketWidth-rampWidth)/2, 3.7, bracketHeight/2])
            rotate([90, 0, 90])
                right_angle_triangle(2, 1, 6.50);
                
        translate([(bracketWidth-rampWidth)/2, 3.7, -bracketHeight/2])
            rotate([-90, 0, 90])
                right_angle_triangle(2, 1, 6.50);
        
        translate([-(bracketWidth-rampWidth)/2, 3.7, -bracketHeight/2])
            rotate([-90, 0, 90])
                right_angle_triangle(2, 1, 6.50);
    }
}

module brokenPart(bracketWidth, bracketHeight, bracketLength, bracketCubeHole) {
    bracketCutLength = 25.00;
    
    difference() {
        instrumentBracket();
        translate([0, 8.7, 0])
            cube([bracketWidth + INTERFERENCE_FIT, bracketCutLength, bracketHeight + INTERFERENCE_FIT], center=true);
    }
}

BRACKET_WIDTH = 24.00;
BRACKET_HEIGHT = 3.50;
BRACKET_LENGTH = 32.50;

BRACKET_CUBE_HOLE = 11.00;

color("red")
    repairPart(BRACKET_WIDTH, BRACKET_HEIGHT, BRACKET_LENGTH, BRACKET_CUBE_HOLE);

//color("yellow")
//    brokenPart(BRACKET_WIDTH, BRACKET_HEIGHT, BRACKET_LENGTH, BRACKET_CUBE_HOLE);