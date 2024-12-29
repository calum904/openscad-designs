/**
 * @file airboxDelete.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Deleting the airbox for a Yamaha DT 125 RE
 */
INTERFERENCE_FIT = 0.001;

IMAGES_DIR = "./images/";
AIRBOX_BACKING_OUTLINE = str(IMAGES_DIR, "airboxSide.svg");
AIRBOX_COVER_OUTLINE = str(IMAGES_DIR, "airboxCoverOutline.svg");
AIRBOX_TOP_RIGHT_OUTLINE = str(IMAGES_DIR, "airboxTopRight.svg");
AIRBOX_LEFT_RAISED_OUTLINE = str(IMAGES_DIR, "airboxLeftSideRaised.svg");
AIRBOX_COVER_RAISED_OUTLINE = str(IMAGES_DIR, "airboxCoverRasiedOutline.svg");

BACKING_THICKNESS = 5;

/**
 * @brief Creates an right angled bracket
 */
module angularBracket() {
    bracketSize = 20;
    
    union() {
        /* Base */
        cube([bracketSize, bracketSize, BACKING_THICKNESS], center=true);
        
        
        difference() {
            /* Semi-Circle part */
            union() {
                translate([0, (bracketSize/2) - BACKING_THICKNESS/2, bracketSize/2])
                    rotate([90, 0, 0])
                        cube([bracketSize, bracketSize, BACKING_THICKNESS], center=true);
                
                translate([0, (bracketSize/2) - BACKING_THICKNESS/2, bracketSize])
                    rotate([90, 0, 0])
                            cylinder(BACKING_THICKNESS, bracketSize/2, bracketSize/2, center=true);
            }
            
            /* Bracket Hole */
            translate([0, (bracketSize/2) - BACKING_THICKNESS/2, bracketSize])
                rotate([90, 0, 0])
                    cylinder(BACKING_THICKNESS + INTERFERENCE_FIT, 3, 3, center=true);
        }
    }
}

/**
 * @brief Imports the airboxCoverOutline SVG which is a trace of the OEM airbox
 */
module airboxBackingOutline() {
    linear_extrude(BACKING_THICKNESS)
        import(AIRBOX_BACKING_OUTLINE);
}

/**
 * @brief The lower left frame mount
 */
module airboxLowerFrameMount() {
    lowerMountRadius = 12.5;
    
    prettyHalfMoonRadius = 21.9;
    
    translate([0, 0, -(BACKING_THICKNESS/4) + INTERFERENCE_FIT])
        union() {
            /* Left Arm to Air Box */
            translate([-8.7, 10, 0])
                rotate([0, 0, 20])
                    cube([15, 30, BACKING_THICKNESS], center=true);

            /* Mounting Circle */
            cylinder(BACKING_THICKNESS, lowerMountRadius, lowerMountRadius, center=true);
            translate([0, 10, 0])
            cube([15, 30, BACKING_THICKNESS], center=true);

            /* Right Arm to Air Box */
            translate([8.7, 10, 0])
                rotate([0, 0, -20])
                    cube([15, 30, BACKING_THICKNESS], center=true);

            /* "Pretty" Circular Backing */
            translate([0, 27.5, 0])
                difference() {
                    cylinder(BACKING_THICKNESS, prettyHalfMoonRadius, prettyHalfMoonRadius, center=true);
                    translate([0, -(prettyHalfMoonRadius/2), -0])        
                        cube([prettyHalfMoonRadius*2, 10, BACKING_THICKNESS + INTERFERENCE_FIT], center=true);
                }
        }
}

/**
 * @brief Imports the airboxCoverOutline SVG which is a trace of the OEM airbox
 */
module airboxCoverOutline() {
    linear_extrude(BACKING_THICKNESS)
        import(AIRBOX_COVER_OUTLINE);
}

/**
 * @brief Imports the airboxTopRight SVG which is a trace of the OEM airbox
 */
module airboxTopRightOutline() {
    linear_extrude(BACKING_THICKNESS)
        import(AIRBOX_TOP_RIGHT_OUTLINE);
}

/**
 * @brief Imports the airboxLeftSideRaised SVG which is a trace of the OEM airbox
 */
module airboxLeftRaisedOutline() {
    airboxCoverRaisedHeight = 4.15 + BACKING_THICKNESS;
    
    linear_extrude(airboxCoverRaisedHeight)
        import(AIRBOX_LEFT_RAISED_OUTLINE);
}

/**
 * @brief Imports the airboxCoverRaisedOutline SVG which is a trace of the OEM airbox
 */
module airboxCoverRaisedOutline() {
    airboxCoverRaisedHeight = 4.15;
    
    linear_extrude(airboxCoverRaisedHeight)
        import(AIRBOX_COVER_RAISED_OUTLINE);
}

/**
 * @brief Airbox cover stand off mount to the frame.
 */
module airboxCoverFrameMountStandout(airboxFrameMoutStandoutHeight, airboxFrameMoutStandoutRadius) {
    difference() {
        cylinder(airboxFrameMoutStandoutHeight, airboxFrameMoutStandoutRadius, airboxFrameMoutStandoutRadius, center=true);
        cylinder(airboxFrameMoutStandoutHeight + INTERFERENCE_FIT, 3, 3, center=true);
    }
}

/**
 * @brief Constructs the air filter cover access
 */
module airboxAirFilterCover() {
    airboxFrameMountStandoutHeight = 4.15;
    airboxFrameMountStandoutRadius = 10.5;
    
    airboxFrameMountStandoutXOffset = 55 + airboxFrameMountStandoutRadius;
    airboxFrameMountStandoutYOffset = 147.0 + airboxFrameMountStandoutRadius;
    airboxFrameMountStandoutZOffset = (airboxFrameMountStandoutHeight/2) + BACKING_THICKNESS - INTERFERENCE_FIT;
    
    union() {
        color("red")
            translate([-80, -10, 0])
                airboxLeftRaisedOutline();

        color("blue")
            airboxCoverOutline();
        
        color("blue")
            translate([150, 90, 0])
                airboxTopRightOutline();
        
        color("red")
            translate([0, 0, BACKING_THICKNESS - INTERFERENCE_FIT])
                  airboxCoverRaisedOutline();
        color("red")
            translate([airboxFrameMountStandoutXOffset, airboxFrameMountStandoutYOffset, airboxFrameMountStandoutZOffset])
                airboxCoverFrameMountStandout(airboxFrameMountStandoutHeight, airboxFrameMountStandoutRadius);
    }
}

/**
 * @brief Recreates the airbox cover
 */
module airboxCover() {
    
    union() {
        color("white")
            airboxBackingOutline();

        translate([80, 24.6, BACKING_THICKNESS - INTERFERENCE_FIT])
            airboxAirFilterCover();
        
        color("pink")
            translate([56, 0, 0])
                airboxLowerFrameMount();

        /* Bottom Bracket */
        color("red")
            rotate([0, 180, -90])
                translate([78, 174.5, -BACKING_THICKNESS/2])
                    rotate([0,0, 52])
                    angularBracket();
        
        /* Top Bracket */
        color("red")
            rotate([0, 180, -90])
                translate([155, 270, -BACKING_THICKNESS/2])
                    rotate([0,0, 52])
                    angularBracket();
    }
}

module airboxDelete() {

    union() {
        airboxCover();
    }
}

airboxDelete();