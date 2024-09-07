/**
 * @file dtrBrakeCarrier.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Yamaha DTRE Brake Carrier for 3ET Swinging Arm with Aprilia RS 125 Wheels
 */
$fa = 0.01;

INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

CALIPER_CARRIER_THICKNESS = 10;
CALIPER_BRACKET_THICKNESS = 5.4;

WHEEL_SPINDLE_SPACER_HEIGHT = 27;
WHEEL_SPINDLE_SPACER_OUTER_RADIUS = 19;
WHEEL_SPINDLE_RADIUS = 10;

/* The size of the carrier at its most extreme width, aka the bottom part */
CARRIER_MAX_WIDTH = 129;
/* The size of the carrier at its most extreme height, aka the left part */
CARRIER_MAX_HEIGHT = 137.50;
CARRIER_HEIGHT_OFFSET = -0.4;

SWINGING_ARM_SLIDE_CUTOUT_HEIGHT = 13.5;
SWINGING_ARM_SLIDE_CUTOUT_DEPTH  = 12;
SWINGING_ARM_SLIDE_CUTOUT_LENGTH = 55;
SWINGING_ARM_SLIDE_DISTANCE_FROM_BOTTOM = 12;

BRAKE_CALIPER_BOLT_DISTANCE = 93;

/**
 * @brief Creates the left wheelspacer
 */
module leftWheelSpacer() {
    difference() {
        cylinder(8, WHEEL_SPINDLE_SPACER_OUTER_RADIUS+5, WHEEL_SPINDLE_SPACER_OUTER_RADIUS+5, center=true);
        cylinder(8, WHEEL_SPINDLE_RADIUS,WHEEL_SPINDLE_RADIUS, center=true);
    }
}

/**
 * @brief The cutoff for the lower left corner
 */
module lowerLeftCornerCutout() {
    difference() {
        outlineBrakeCarrier(CALIPER_CARRIER_THICKNESS+2);
        translate([-(CARRIER_MAX_WIDTH/2) + WHEEL_SPINDLE_SPACER_OUTER_RADIUS, -(CARRIER_MAX_HEIGHT/2) + WHEEL_SPINDLE_SPACER_OUTER_RADIUS + CARRIER_HEIGHT_OFFSET, 0])
            wheelSpindleSpacer(WHEEL_SPINDLE_SPACER_HEIGHT);
            translate([40, -134, -(CALIPER_CARRIER_THICKNESS+10)/2])
        rotate([0, 0 ,53 ])
            cube([150, 200, CALIPER_CARRIER_THICKNESS+10]);
    }
}

/**
 * @brief The outline of the carrier extruded
 *
 * @param height - The height to perform the linear_extrude to
 */
module outlineBrakeCarrier(height) {
    linear_extrude(height, center=true)
//        import("outline-curved.svg", center=true);
        translate([-65.5, 81, 0])
        Layer_1();
}

/**
 * @brief The cutout for the swinging arm slide to rest against
 */
module swingingArmSlideCutout() {
    union() {
        translate([-SWINGING_ARM_SLIDE_CUTOUT_LENGTH/2, 0, 0])
            cylinder(SWINGING_ARM_SLIDE_CUTOUT_HEIGHT, SWINGING_ARM_SLIDE_CUTOUT_DEPTH/2, SWINGING_ARM_SLIDE_CUTOUT_DEPTH/2, center=true);
            cube([SWINGING_ARM_SLIDE_CUTOUT_LENGTH, SWINGING_ARM_SLIDE_CUTOUT_DEPTH + SLIDE_FIT, SWINGING_ARM_SLIDE_CUTOUT_HEIGHT], center=true);
    }
}

/**
 * @brief The lower left corner where the spindle goes through
 */
module wheelSpindleSpacer(height) {
    difference() {
        cylinder(height, WHEEL_SPINDLE_SPACER_OUTER_RADIUS, WHEEL_SPINDLE_SPACER_OUTER_RADIUS, center=true);
        cylinder(height+INTERFERENCE_FIT, WHEEL_SPINDLE_RADIUS, WHEEL_SPINDLE_RADIUS, center=true);
    }
}

/**
 * @brief The brake carrier
 */
module brakeCarrier() {
    union() {
        difference() {
            /* Brake Carrier */
            outlineBrakeCarrier(CALIPER_CARRIER_THICKNESS);

            /* Caliper Mount */
            /* Cutout For Brake Mount */
            union() {
                color("red")
                    translate([-8, -15, CALIPER_BRACKET_THICKNESS-CALIPER_CARRIER_THICKNESS-0.4 - INTERFERENCE_FIT])
                        cube([70, 40, CALIPER_BRACKET_THICKNESS]);

                    color("red")
                        translate([20-82, 30, CALIPER_BRACKET_THICKNESS-CALIPER_CARRIER_THICKNESS-0.4 - INTERFERENCE_FIT])
                            cube([40, 40, CALIPER_BRACKET_THICKNESS]);
            }
            /* Holes */
            union() {
                translate([-43, 47.5, 0])
                    cylinder(CALIPER_BRACKET_THICKNESS +10, 4.5, 4.5, center=true);
                translate([28, 4, 0])
                cylinder(CALIPER_BRACKET_THICKNESS+10, 4.5, 4.5, center=true);
            }

            /* Bottom Left Cutout to make it round */
            translate([-INTERFERENCE_FIT, -INTERFERENCE_FIT, 0])
                lowerLeftCornerCutout();

            /* Cutout for the spindle to go through */
            translate([-(CARRIER_MAX_WIDTH/2) + WHEEL_SPINDLE_SPACER_OUTER_RADIUS, -(CARRIER_MAX_HEIGHT/2) + WHEEL_SPINDLE_SPACER_OUTER_RADIUS + CARRIER_HEIGHT_OFFSET, 0])
                cylinder(WHEEL_SPINDLE_SPACER_HEIGHT+10, WHEEL_SPINDLE_RADIUS + SLIDE_FIT, WHEEL_SPINDLE_RADIUS + SLIDE_FIT, center=true);

            /* Swinging arm slide cutout */
            translate([((CARRIER_MAX_WIDTH - SWINGING_ARM_SLIDE_CUTOUT_LENGTH)/2) + INTERFERENCE_FIT, ((-CARRIER_MAX_HEIGHT + SWINGING_ARM_SLIDE_CUTOUT_DEPTH)/2) + SWINGING_ARM_SLIDE_DISTANCE_FROM_BOTTOM, 5+INTERFERENCE_FIT])
                swingingArmSlideCutout();
        }

        /* Wheel Spacer */
        translate([-(CARRIER_MAX_WIDTH/2) + WHEEL_SPINDLE_SPACER_OUTER_RADIUS, -(CARRIER_MAX_HEIGHT/2) + WHEEL_SPINDLE_SPACER_OUTER_RADIUS + CARRIER_HEIGHT_OFFSET, ((CALIPER_CARRIER_THICKNESS-WHEEL_SPINDLE_SPACER_HEIGHT)/2) + 4.4])
            wheelSpindleSpacer(WHEEL_SPINDLE_SPACER_HEIGHT);
    }
}

brakeCarrier();
//translate([100, 0 ,0])
//    leftWheelSpacer();

// Group ID: layer1
module Layer_1() {
	// Path ID: path113
	bezier_polygon([[[130.0, -150.0], [130.0, -150.0], [1.0, -150.0], [1.0, -150.0]], [[1.0, -150.0], [1.0, -150.0], [13.0, -12.5], [13.0, -12.5]], [[13.0, -12.5], [13.0, -12.5], [27.22112, -5.4780099], [34.0, -29.328111]], [[34.0, -29.328111], [37.71307, -42.391787], [35.249094, -40.598198], [39.449, -57.0]], [[39.449, -57.0], [40.502151999999995, -61.11285], [42.975988, -62.423243], [46.805, -65.211]], [[46.805, -65.211], [50.662141, -68.019237], [55.886022, -72.288725], [60.153, -72.0]], [[60.153, -72.0], [80.261262, -70.639373], [87.738012, -64.849601], [104.01155, -67.5]], [[104.01155, -67.5], [111.58475, -68.733414], [121.0, -67.3], [121.0, -67.3]], [[121.0, -67.3], [121.0, -67.3], [124.5, -102.0], [124.5, -102.0]], [[124.5, -102.0], [124.5, -102.0], [130.0, -116.5], [130.0, -116.5]], [[130.0, -116.5], [130.0, -116.5], [130.0, -150.0], [130.0, -150.0]], [[130.0, -150.0], [130.0, -150.0], [130.0, -150.0], [130.0, -150.0]]]);
}

/**
 * Stripped down version of "bezier_v2.scad".
 * For full version, see: https://www.thingiverse.com/thing:2170645
 */

function BEZ03(u) = pow((1-u), 3);
function BEZ13(u) = 3*u*(pow((1-u),2));
function BEZ23(u) = 3*(pow(u,2))*(1-u);
function BEZ33(u) = pow(u,3);

function bezier_2D_point(p0, p1, p2, p3, u) = [
	BEZ03(u)*p0[0]+BEZ13(u)*p1[0]+BEZ23(u)*p2[0]+BEZ33(u)*p3[0],
	BEZ03(u)*p0[1]+BEZ13(u)*p1[1]+BEZ23(u)*p2[1]+BEZ33(u)*p3[1]
];

function bezier_coordinates(points, steps) = [
	for (c = points)
		for (step = [0:steps])
			bezier_2D_point(c[0], c[1], c[2],c[3], step/steps)
];

module bezier_polygon(points) {
	steps = $fn <= 0 ? 30 : $fn;
	polygon(bezier_coordinates(points, steps));
}


