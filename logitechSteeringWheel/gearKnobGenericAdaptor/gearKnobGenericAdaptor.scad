 /**
 * @file gearKnobGenericAdaptor.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Generic Adaptor to replace the stock gear knob with a generic one for Logitech G25/27/29/920
 */
use <threadlib/threadlib.scad>
use <thread_profile.scad>


INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

/**
 * @brief Creates the gear knob adaptor
 */
module gearKnobGenericAdaptor() {
    connectionLength = 18;
    connectionInternalDiameter = 5.5;
    connectionExternalDiameter = 8;

    m4Radius = 2;
    screwFaceHeight = 3;
    theadOuterRadius = 6;

    union() {
        /* 20mm Long */
        difference() {
            bolt("M12x1.25", turns=14);
            translate([0, 0, -1])
                cylinder(22 + INTERFERENCE_FIT, 4, 4, $fn=50);
        }

        /* Screw Face */
        translate([0, 0, -.625])
            difference() {
                cylinder(screwFaceHeight, theadOuterRadius, theadOuterRadius, $fn=50);
                cylinder(screwFaceHeight + INTERFERENCE_FIT, m4Radius, m4Radius, $fn=50);
            }

        /* Knob Connection Shaft */
        translate([0, 0, -18])
            difference() {
                cylinder(connectionLength, connectionExternalDiameter, connectionExternalDiameter, $fn=50);
                cylinder(connectionLength + SLIDE_FIT, connectionInternalDiameter + SLIDE_FIT, connectionInternalDiameter + SLIDE_FIT, $fn=50);
            }

            /* Flat Edge of Connection */
            translate([-5.8, -4, -18])
                cube([2, 8.5, connectionLength]);
    }
}

gearKnobGenericAdaptor();