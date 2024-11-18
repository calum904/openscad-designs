/**
 * @file frontWheelSpacers.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Aprilia RS 125 2006-2011 front wheel fitted to 2005 Yamaha 250WRF Forks
 */
$fa = 0.01;

INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

SPINDLE_RADIUS = 10;

CAPTIVE_LIP_HEIGHT = 1.75;
CAPTIVE_LIP_RADIUS_ADD = 0.5;

FRONT_RIGHT_SPACER_HEIGHT = 22;
FRONT_LEFT_SPACER_HEIGHT = 10;
FRONT_SPACER_OUT_RADIUS = 13.825;
FRONT_CAPTIVE_LIP_RADIUS = FRONT_SPACER_OUT_RADIUS + CAPTIVE_LIP_RADIUS_ADD;
FRONT_FORK_FACE_RADIUS = 16;
FRONT_FORK_FACE_HEIGHT = 2.65;

/**
 * @brief Front Left Spacer (Disc/Caliper Side)
 */
module leftFrontSpacer() {
    difference() {
        union() {
            cylinder(FRONT_LEFT_SPACER_HEIGHT, FRONT_SPACER_OUT_RADIUS, FRONT_SPACER_OUT_RADIUS, center=true);
            translate([0, 0, (-(FRONT_LEFT_SPACER_HEIGHT -FRONT_FORK_FACE_HEIGHT)/2)])
                cylinder(FRONT_FORK_FACE_HEIGHT, FRONT_FORK_FACE_RADIUS, FRONT_FORK_FACE_RADIUS, center=true);
            translate([0, 0, ((FRONT_LEFT_SPACER_HEIGHT - CAPTIVE_LIP_HEIGHT)/2)])
                cylinder(CAPTIVE_LIP_HEIGHT, FRONT_CAPTIVE_LIP_RADIUS, FRONT_CAPTIVE_LIP_RADIUS, center=true);
        }
        cylinder(FRONT_LEFT_SPACER_HEIGHT + INTERFERENCE_FIT, SPINDLE_RADIUS + SLIDE_FIT, SPINDLE_RADIUS + SLIDE_FIT, center=true);
    }
}

/**
 * @brief Front Right Spacer
 */
module rightFrontSpacer() {
    difference() {
        union() {
            cylinder(FRONT_RIGHT_SPACER_HEIGHT, FRONT_SPACER_OUT_RADIUS, FRONT_SPACER_OUT_RADIUS, center=true);
            translate([0, 0, (-(FRONT_RIGHT_SPACER_HEIGHT -FRONT_FORK_FACE_HEIGHT)/2)])
                cylinder(FRONT_FORK_FACE_HEIGHT, FRONT_FORK_FACE_RADIUS, FRONT_FORK_FACE_RADIUS, center=true);
            translate([0, 0, ((FRONT_RIGHT_SPACER_HEIGHT - CAPTIVE_LIP_HEIGHT)/2)])
                cylinder(CAPTIVE_LIP_HEIGHT, FRONT_CAPTIVE_LIP_RADIUS, FRONT_CAPTIVE_LIP_RADIUS, center=true);
        }
        cylinder(FRONT_RIGHT_SPACER_HEIGHT + INTERFERENCE_FIT, SPINDLE_RADIUS + SLIDE_FIT, SPINDLE_RADIUS + SLIDE_FIT, center=true);
    }
}

leftFrontSpacer();

translate([50, 0, 0])
    rightFrontSpacer();
