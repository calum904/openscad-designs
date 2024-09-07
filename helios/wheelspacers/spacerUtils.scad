/**
 * @file spacerUtils.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Aprilia RS 125 2006-2011 spacer utilities
 */
INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

SPROCKET_CARRIER_SPACER_HEIGHT = 17;
BRAKE_CARRIER_SPACER_HEIGHT = 15.25;

SPACER_OUTER_RADIUS = 15;
SPINDLE_RADIUS = 10;
SWINGING_ARM_FACE_RADIUS = 17.5;
SWINGING_ARM_FACE_HEIGHT = 5;

CAPTIVE_LIP_HEIGHT = 1.75;
CAPTIVE_LIP_RADIUS = SPACER_OUTER_RADIUS + 0.5;

SPROCKET_CARRIER_INNER_BEARING_SPACER_HEIGHT = 16.5;

SPROCKET_CARRIER_INNER_BEARING_OUTER_RADIUS = 12.475;
SPROCKET_CARRIER_INNER_BEARING_FACE_RADIUS = 16;
SPROCKET_CARRIER_INNER_BEARING_FACE_HEIGHT = 5.55;

/**
 * @brief Aprilia RS 125 2006-2011 rear brake carrier side spacer with captive flange
 */
module brakeCarrierSpacer() {
    difference() {
        union() {
            cylinder(BRAKE_CARRIER_SPACER_HEIGHT, SPACER_OUTER_RADIUS, SPACER_OUTER_RADIUS, center=true);
            translate([0, 0, (-(BRAKE_CARRIER_SPACER_HEIGHT -SWINGING_ARM_FACE_HEIGHT)/2)])
                cylinder(SWINGING_ARM_FACE_HEIGHT, SWINGING_ARM_FACE_RADIUS, SWINGING_ARM_FACE_RADIUS, center=true);
            translate([0, 0, ((BRAKE_CARRIER_SPACER_HEIGHT - CAPTIVE_LIP_HEIGHT)/2)])
                cylinder(CAPTIVE_LIP_HEIGHT, CAPTIVE_LIP_RADIUS, CAPTIVE_LIP_RADIUS, center=true);
        }
        cylinder(BRAKE_CARRIER_SPACER_HEIGHT + INTERFERENCE_FIT, SPINDLE_RADIUS + SLIDE_FIT, SPINDLE_RADIUS + SLIDE_FIT, center=true);
    }
}

/**
 * @brief Aprilia RS 125 2006-2011 rear sprocket carrier side internal spacer
 */
module sprocketCarrierInnerBearingSpacer() {
    difference() {
        union() {
            cylinder(SPROCKET_CARRIER_INNER_BEARING_SPACER_HEIGHT, SPROCKET_CARRIER_INNER_BEARING_OUTER_RADIUS, SPROCKET_CARRIER_INNER_BEARING_OUTER_RADIUS, center=true);
            translate([0, 0, (-(SPROCKET_CARRIER_INNER_BEARING_SPACER_HEIGHT -SPROCKET_CARRIER_INNER_BEARING_FACE_HEIGHT)/2)])
                cylinder(SPROCKET_CARRIER_INNER_BEARING_FACE_HEIGHT, SPROCKET_CARRIER_INNER_BEARING_FACE_RADIUS, SPROCKET_CARRIER_INNER_BEARING_FACE_RADIUS, center=true);
        }
        cylinder(SPROCKET_CARRIER_INNER_BEARING_SPACER_HEIGHT + INTERFERENCE_FIT, SPINDLE_RADIUS + SLIDE_FIT, SPINDLE_RADIUS + SLIDE_FIT, center=true);
    }
}

/**
 * @brief Aprilia RS 125 2006-2011 rear sprocket carrier side spacer with captive flange
 */
module sprocketCarrierSpacer() {
    difference() {
        union() {
            cylinder(SPROCKET_CARRIER_SPACER_HEIGHT, SPACER_OUTER_RADIUS, SPACER_OUTER_RADIUS, center=true);
            translate([0, 0, (-(SPROCKET_CARRIER_SPACER_HEIGHT -SWINGING_ARM_FACE_HEIGHT)/2)])
                cylinder(SWINGING_ARM_FACE_HEIGHT, SWINGING_ARM_FACE_RADIUS, SWINGING_ARM_FACE_RADIUS, center=true);
            translate([0, 0, ((SPROCKET_CARRIER_SPACER_HEIGHT - CAPTIVE_LIP_HEIGHT)/2)])
                cylinder(CAPTIVE_LIP_HEIGHT, CAPTIVE_LIP_RADIUS, CAPTIVE_LIP_RADIUS, center=true);
        }
        cylinder(SPROCKET_CARRIER_SPACER_HEIGHT + INTERFERENCE_FIT, SPINDLE_RADIUS + SLIDE_FIT, SPINDLE_RADIUS + SLIDE_FIT, center=true);
    }
}