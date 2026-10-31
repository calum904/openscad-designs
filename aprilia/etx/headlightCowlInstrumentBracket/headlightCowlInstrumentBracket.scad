/**
 * @file headlightCowlInstrumentBracket.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Fix for broken Aprilia ETX 125 instrument bracket that hangs off the headlight cowl.
 */
INTERFERENCE_FIT=0.001;
SLIDE_FIT=0.05;

module right_angle_triangle(base, height, thickness) {
    linear_extrude(height = thickness, center = true) {
        polygon(points = [[0, 0],          // The 90-degree corner at the origin
            [base, 0],       // The end of the flat base (X-axis)
            [0, height]      // The top vertex (Y-axis)
        ]);
    }
}

module originalBracketHole(bracketCubeHole, bracketHeight) {
    union() {
        cube([bracketCubeHole, 3.85, bracketHeight + SLIDE_FIT], center=true);
        translate([0, bracketCubeHole/6, 0])
            cylinder(bracketHeight + SLIDE_FIT, d=bracketCubeHole, center=true);
        translate([0, -bracketCubeHole/6, 0])
            cylinder(bracketHeight + SLIDE_FIT, d=bracketCubeHole, center=true);
    }
}

module originalSupportingBracket(triangleThickness) {
    triangleHeight = 10.00 - triangleThickness;
    triangleBase = 12.50;
    
    rotate([-90, 0, 90])
        translate([0, (triangleHeight/4) + 0.1, 0])
            right_angle_triangle(triangleBase, triangleHeight, triangleThickness);
}

module originalBracketPiece(bracketWidth, bracketHeight, bracketLength, bracketCubeHole) {
    bracketHoleDistanceFromTop = 5.00;
    bracketHoleComputeDistanceFromTop = (bracketLength/2) - (bracketCubeHole/1.52) - bracketHoleDistanceFromTop;
    
    difference() {
            cube([bracketWidth, bracketLength, bracketHeight], center=true);

            translate([0, bracketHoleComputeDistanceFromTop, 0])
                originalBracketHole(bracketCubeHole, bracketHeight);
            
            
        }
}

module instrumentBracket() {
    bracketWidth = 24.00;
    bracketHeight = 3.50;
    bracketLength = 32.50;
    
    bracketCubeHole = 11.00;
    
    union() {
        /* Left Bracket */
        translate([(bracketWidth-bracketHeight)/2, -bracketLength/2, 0])
            originalSupportingBracket(bracketHeight);

        originalBracketPiece(bracketWidth, bracketHeight, bracketLength, bracketCubeHole);
        
        /* Right Bracket */
        translate([-(bracketWidth-bracketHeight)/2, -bracketLength/2, 0])
            originalSupportingBracket(bracketHeight);
    }
}

instrumentBracket();