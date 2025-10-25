/**
 * @file snapOnBlindBearingPullerCase.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Simple case for a Snap On Blind Bearing Puller.
 */
INTERFERENCE_FIT = 0.01;
SLIDE_FIT = 5;

A78_TOOL_HEIGHT = 180;
A78_TOOL_WIDTH  = 83.50;
A78_TOOL_DEPTH  = 32.50;

WALL_THICKNESS = 3;
TOOL_PADDING = 5;

IMAGES_DIR = "../../images/";
SNAP_ON_LOGO_PATH = str(IMAGES_DIR, "logo.svg");

/**
 * @brief Creates the SnapOn logo.
 *
 * @return logo - The Snap On logo
 */
module snapOnLogo() {
    linear_extrude(WALL_THICKNESS)
        scale([0.3, 0.3, 0.3])
            import(SNAP_ON_LOGO_PATH);
}

/**
 * @brief Locator for the tools feet to sit into.
 *
 * @param  feetWidth   - The width of the feet
 * @param  feetDepth   - The depth of the feet
 * @param  feetHeight  - The height of the feet locator
 * @return feetLocator - An individual feet locator
 */
module toolFeetLocator(feetWidth, feetDepth, feetHeight) {
    innerLocatorWidth = feetWidth + (TOOL_PADDING * 2);
    outerLocatorWidth = innerLocatorWidth + (WALL_THICKNESS  * 2);
    
    innerLocatorDepth = feetDepth + (TOOL_PADDING * 2);
    outerLocatorDepth = innerLocatorDepth + (WALL_THICKNESS * 2);
    
    union() {
        difference() {
            cube([outerLocatorWidth, outerLocatorDepth, feetHeight], center=true);
            cube([innerLocatorWidth, innerLocatorDepth, feetHeight + INTERFERENCE_FIT], center=true);
        }
    }
}

/**
 * @brief Creates the lid for the box.
 */
module snapOnLid(wallThickness, baseWidth, baseDepth) {
    sphereRadius = 10;

    /* Inner lid which sits inside the case */
    innerLidWidth = baseWidth - wallThickness - SLIDE_FIT;
    innerLidDepth = baseDepth - wallThickness - SLIDE_FIT;
    innerLidHeight = wallThickness * 2;

    /* Cut out for o-ring */
    innerGroveWidth = innerLidWidth - 2;
    innerGroveDepth = innerLidDepth - 2;
    innerGroveHeight = 1;
    
    union() {
        /* Lid Plate */
        cube([baseWidth, baseDepth, wallThickness], center=true);

        /* Lid Inner */
        translate([0, 0, INTERFERENCE_FIT - wallThickness])
        difference() {
            /* Inner Lid */
            cube([innerLidWidth, innerLidDepth, innerLidHeight], center=true);
                /* Cut out for O-Ring */
                difference() {
                    cube([innerLidWidth + INTERFERENCE_FIT, innerLidDepth + INTERFERENCE_FIT, innerGroveHeight], center=true);
                    cube([innerGroveWidth, innerGroveDepth, innerLidHeight + INTERFERENCE_FIT], center=true);
                }
        }
        /* Handle */
        translate([0, 0, sphereRadius])
            sphere(sphereRadius, $fn=100);

        /* Logo */
        translate([-baseWidth/2.5, -baseWidth/8, (wallThickness/2) - INTERFERENCE_FIT])
            snapOnLogo();
    }
}

/**
 * @brief Creates the box for the tool.
 *
 * @param  wallThickness - The thickness of the walls
 * @param  baseWidth     - The width of the base plate
 * @param  baseDepth     - The depth of the base plate
 * @param  boxHeight     - The height of the box
 *
 * @return snapOnBox     - The box for the tool to sit in
 */
module snapOnBox(wallThickness, baseWidth, baseDepth, boxHeight) {
    /* Dimensions for the feet locator */
    feetWidth = 7;
    feetDepth = 31.50;
    feetHeight = 15.0;
    feetWidthApart = 35.375;

    union() {
        /* Base Plate */
        cube([baseWidth, baseDepth, wallThickness], center=true);

        /* Tool Feet Locators */
        /* Right Foot Locactor */
        translate([feetWidthApart, 0, (feetHeight/2) - INTERFERENCE_FIT])
            toolFeetLocator(feetWidth, feetDepth, feetHeight);
        /* Left Foot Locactor */
        translate([-feetWidthApart, 0, (feetHeight/2) - INTERFERENCE_FIT])
            toolFeetLocator(feetWidth, feetDepth, feetHeight);

        /* Walls */
        /* Front Wall */
        translate([0, ((wallThickness-baseDepth)/2), ((boxHeight+wallThickness)/2) - INTERFERENCE_FIT])
            cube([baseWidth, wallThickness, boxHeight], center=true);
        
        /* Back Wall */
        translate([0, -(wallThickness-baseDepth)/2, ((boxHeight+wallThickness)/2) - INTERFERENCE_FIT])
            cube([baseWidth, wallThickness, boxHeight], center=true);

        /* Left Wall */
        translate([(-baseWidth + wallThickness)/2, 0, ((boxHeight+wallThickness)/2) - INTERFERENCE_FIT])
            cube([wallThickness, baseDepth, boxHeight], center=true);
        /* Right Wall */
        translate([((baseWidth - wallThickness)/2), 0, (boxHeight+wallThickness)/2])
            cube([wallThickness, baseDepth, boxHeight], center=true);
    }
}

/**
 * @brief Creates the case for the A78 tool.
 */
module snapOnCase() {
    lidDepth = WALL_THICKNESS;
    
    baseWidth = A78_TOOL_WIDTH  + (WALL_THICKNESS * 2) + (TOOL_PADDING * 2);
    baseDepth = A78_TOOL_DEPTH  + (WALL_THICKNESS * 2) + (TOOL_PADDING * 2);
    boxHeight = A78_TOOL_HEIGHT + (TOOL_PADDING   * 2) + lidDepth;
    union() {
        snapOnBox(WALL_THICKNESS, baseWidth, baseDepth, boxHeight);
        
        translate([0, 0, boxHeight + WALL_THICKNESS - INTERFERENCE_FIT])
            snapOnLid(lidDepth, baseWidth, baseDepth);
    }
}

snapOnCase();