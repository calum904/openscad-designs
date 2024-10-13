/**
 * @file logitechGearAssemblyRearScrewMount.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Logitech G25/27/29 Gear Assembly Rear Screw Mount
 */
use <threadlib/threadlib.scad>
use <thread_profile.scad>

$fa = 0.01;

INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

// Logitech G25/27/29 Rear Gear Knob Screw Thread (estimated from OEM thread dims)
function logtechRearScrew_nut_thread_major()   = 15.8; 
function logtechRearScrew_nut_thread_pitch()   = 4;
function logtechRearScrew_nut_thread_height()  = 2;
function logtechRearScrew_nut_thread_profile() = [
    [0, 0],
    [-logtechRearScrew_nut_thread_height(), 0.32],
    [-logtechRearScrew_nut_thread_height(), 2],
    [0, 2]
];

module knurledGrips() {
    headHeight = 10;
    knurledRadius = 3;
    
    for (i = [0: 17]) {
        rotateAmount = 20 * i;
        
        rotate([0, 0, rotateAmount])
            translate([12.5, 0, 0])
                cylinder(headHeight, knurledRadius, knurledRadius, $fn=25);
    }
}

/**
 * @brief Creates the head of the screw with a knurled section
 */
module headScrewCap() {
    headHeight = 10;
    headRadius = 15;
    
    knurledRadis = 3;
    
    union() {
        cylinder(headHeight, headRadius, headRadius);
        knurledGrips();
    }
}

/**
 * @brief Creates the rear screw mount
 */
module logitechGearAssemblyRearScrewMount() {
    overallScrewLength = 80;
    screwInnerRadius = 6.375;
    
    union() {
        /* Head Screw Cap */
        translate([0, 0, -5])
            headScrewCap();
        
        /* Inner Bolt */
        cylinder(overallScrewLength, screwInnerRadius, screwInnerRadius);
        /* Thread */
        straight_thread(logtechRearScrew_nut_thread_profile(), turns=19.2, pitch=logtechRearScrew_nut_thread_pitch(), r=8);
    }
}

logitechGearAssemblyRearScrewMount();