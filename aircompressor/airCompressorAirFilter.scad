/**
 * @file airCompressorAirFilter.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Air compressor air filter for SGS Engineering Compressor
 */
use <threadlib/threadlib.scad>

$fa = 0.01;

INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

module airCompressorAdaptor() {
    airFilterJoiningRubberHeight = 15;
    airFilterJoiningRubberInnerRadius = 19.5;

    wallThickness = 3;

    m16BaseThreadRadius = 8;
    m16StandOffHeight = 6;

    union() {

        /* Air Filter Joiner */
        difference() {
            cylinder(airFilterJoiningRubberHeight, airFilterJoiningRubberInnerRadius, airFilterJoiningRubberInnerRadius, center=true);
            cylinder(airFilterJoiningRubberHeight, airFilterJoiningRubberInnerRadius - wallThickness, airFilterJoiningRubberInnerRadius - wallThickness, center=true);
        }

        /* Air Filter base Plate */
        translate([0, 0, ((airFilterJoiningRubberHeight+wallThickness)/2)])
            difference() {
                cylinder(wallThickness, airFilterJoiningRubberInnerRadius, airFilterJoiningRubberInnerRadius, center=true);
                cylinder(wallThickness, m16BaseThreadRadius, m16BaseThreadRadius, center=true);
            }

        /* M16 Stand Off */
        translate([0, 0, ((airFilterJoiningRubberHeight + m16StandOffHeight)/2)])
            difference() {
                cylinder(m16StandOffHeight, m16BaseThreadRadius, m16BaseThreadRadius, center=true);
                cylinder(m16StandOffHeight, m16BaseThreadRadius-wallThickness, m16BaseThreadRadius-wallThickness, center=true);
            }

        /* M16x1.25 Threaded Section */
        translate([0, 0, ((airFilterJoiningRubberHeight+ m16StandOffHeight + 7.5)/2)])
            difference() {
                bolt("M16x1.5", turns=9, higbee_arc=60);
                translate([0, 0, -2])
                    cylinder(17, 5, 5);
            }
    }
}

airCompressorAdaptor();