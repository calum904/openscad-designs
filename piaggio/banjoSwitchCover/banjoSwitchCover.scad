/**
 * @file banjoSwitchCover.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief The cover for the rear master cylinder banjo switch.
 */
$fa = 0.01;
INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.5;

module banjoSwitch(banjoSwitchHexDiameter) {
    banjoSwitchTopHeight      =  3.50;
    banjoSwitchBottomHeight   =  1.30;
    banjoSwitchTopDiameter    = 14.00;
    
    banjoSwitchHexHeight      =  8.50;

    banjoSwitchBoltTopHeight    =  2.75;
    banjoSwitchBoltBottomHeight =  12.30;
    banjoSwitchBoltDiameter     =  9.80;

    banjoBleedBoltDiameter      = 8.75;
    banjoBleedBoltHeight        = 2.80;
    banjoBleedHoleDiameter      = 2.00;
    
    union() {
        /* Top */
        translate([0, 0, ((banjoSwitchHexHeight + banjoSwitchTopHeight)/2) - INTERFERENCE_FIT])
            cylinder(banjoSwitchTopHeight, d=banjoSwitchTopDiameter, center=true);
        
        /* Hex Spanner Ring */
        cylinder(banjoSwitchHexHeight, d=banjoSwitchHexDiameter, center=true, $fn=6);
        
        /* Bottom */
        translate([0, 0, (-(banjoSwitchHexHeight + banjoSwitchBottomHeight)/2) + INTERFERENCE_FIT])
            cylinder(banjoSwitchBottomHeight, d=banjoSwitchTopDiameter, center=true);
        
        /* Bolt Top */
        translate([0, 0, (-(banjoSwitchHexHeight + banjoSwitchBottomHeight + banjoSwitchBoltTopHeight)/2) + INTERFERENCE_FIT])
            cylinder(banjoSwitchBoltTopHeight, d=banjoSwitchBoltDiameter, center=true);
        
        /* Bleed */
        translate([0, 0, (-(banjoSwitchHexHeight + banjoSwitchBottomHeight + banjoSwitchBoltTopHeight)/2) + INTERFERENCE_FIT - banjoBleedBoltHeight])
            difference() {
                cylinder(banjoBleedBoltHeight, d=banjoBleedBoltDiameter, center=true);
                rotate([0, 90, 0])
                    cylinder(banjoBleedBoltDiameter + INTERFERENCE_FIT, d=banjoBleedHoleDiameter, center=true);
            }
            
        /* Bolt Bottom */
        translate([0, 0, (-(banjoSwitchHexHeight + banjoSwitchBottomHeight + banjoSwitchBoltTopHeight + banjoBleedBoltHeight)/2) + INTERFERENCE_FIT -banjoSwitchBoltBottomHeight/2 - banjoBleedBoltHeight])
            cylinder(banjoSwitchBoltBottomHeight, d=banjoSwitchBoltDiameter, center=true);
    }
}

module banjoSwitchCover(banjoSwitchHexDiameter) {
    banjoSwitchHexCoverDiameter = banjoSwitchHexDiameter + 1.85;
    banjoSwitchHexHeight        =  8.50 + 3.50 + 1.30 + 5;
    banjoSwitchHexCoverTop      =  3.00;
    
    cableCoverHeight   = 15.00;
    cableCoverDiameter = 15.00;
    
    union() {
        /* Cable Cover */
        translate([0, 0, ((banjoSwitchHexHeight + banjoSwitchHexCoverTop + 1)/2) - INTERFERENCE_FIT + cableCoverHeight])
            difference() {
                cylinder(1, d=cableCoverDiameter + 0.5, center=true, $fn=50);
                cylinder(1 + INTERFERENCE_FIT, d=cableCoverDiameter-4, center=true, $fn=50);
            }
        translate([0, 0, ((banjoSwitchHexHeight + banjoSwitchHexCoverTop + cableCoverHeight)/2) - INTERFERENCE_FIT])
            difference() {
                cylinder(cableCoverHeight, cableCoverDiameter/2, (cableCoverDiameter-1)/2, center=true, $fn=50);
                cylinder(cableCoverHeight + INTERFERENCE_FIT, (cableCoverDiameter-2.5)/2, (cableCoverDiameter-4)/2, center=true, $fn=50);
            }

        /* Top Cover */
        translate([0, 0, ((banjoSwitchHexHeight + banjoSwitchHexCoverTop)/2) - INTERFERENCE_FIT])
            difference() {
                cylinder(banjoSwitchHexCoverTop, d=banjoSwitchHexCoverDiameter, center=true, $fn=50);
                cylinder(banjoSwitchHexCoverTop + INTERFERENCE_FIT, (cableCoverDiameter-3)/2, (cableCoverDiameter-2)/2, center=true, $fn=50);
            }
            
        /* Main Body */
        difference() {
            cylinder(banjoSwitchHexHeight, d=banjoSwitchHexCoverDiameter, center=true, $fn=50);
            cylinder(banjoSwitchHexHeight + INTERFERENCE_FIT, d=(banjoSwitchHexDiameter + SLIDE_FIT), center=true, $fn=6);
        }
        
        /* Bottom Ring */
        translate([0, 0, ((1 - banjoSwitchHexHeight)/2)])
            difference() {
                cylinder(1, d=banjoSwitchHexCoverDiameter + 2, center=true, $fn=50);
                cylinder(banjoSwitchHexHeight + INTERFERENCE_FIT, d=(banjoSwitchHexCoverDiameter - SLIDE_FIT), center=true);
        }
    }
}


//banjoSwitch(16.15);

banjoSwitchCover(19.25);