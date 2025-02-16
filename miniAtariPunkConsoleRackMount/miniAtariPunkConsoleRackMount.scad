/**
 * @file miniAtariPunkCosnoleRackMount.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Mini Rack Mount for the Atari Mini Mod Synth
 */
INTERFERENCE_FIT = 0.001;

/**
 * @brief Mocked Mini Atari Punk Console
 */
module atariPunkPcb() {
    atariPunkPcbWidth  = 33.50;
    atariPunkPcbHeight = 50;
    atariPunkPcbThickness = 1.65;
    atariPunkPcbMountingHoleRadius = 1.5;
    atairPunkPcbHoleDistanceFromEdge = 1.75;
    
    atariPunkPotBaseDepth  = 7.5;
    atariPunkPotBaseWidth  = 11.75;
    atariPunkPotBaseHeight = 9.75;
    
    atariPunkPotRadius = 3;
    atariPunkPotHeight = 12.5;
    
    pitchPotDistanceFromTop    = 8.75;
    depthPotDistanceFromBottom = 15.2;
    
    powerSwitchDepth = 6.5;
    powerSwitchWidth = 5.8;
    powerSwitchHeight = 12.3;
    powerSwitchDistanceFromBottom = 9.45;
    
    powerDipSwitchDepth = 4.65;
    powerDipSwitchWidth = 3;
    powerDipSwitchHeight = 6.5;
    
    union() {
        difference() {
            /* PCB Base */
            color("white")
                cube([atariPunkPcbWidth, atariPunkPcbHeight, atariPunkPcbThickness], center=true);
            
            /* Top Right Hole */
            translate([(atariPunkPcbWidth/2) - atariPunkPcbMountingHoleRadius - atairPunkPcbHoleDistanceFromEdge, (atariPunkPcbHeight/2) - atariPunkPcbMountingHoleRadius - atairPunkPcbHoleDistanceFromEdge, 0])
                cylinder(atariPunkPcbThickness + INTERFERENCE_FIT, atariPunkPcbMountingHoleRadius, atariPunkPcbMountingHoleRadius, center=true, $fn=50);
            /* Top Left Hole */
            translate([(-atariPunkPcbWidth/2) + atariPunkPcbMountingHoleRadius + atairPunkPcbHoleDistanceFromEdge, (atariPunkPcbHeight/2) - atariPunkPcbMountingHoleRadius - atairPunkPcbHoleDistanceFromEdge, 0])
                cylinder(atariPunkPcbThickness + INTERFERENCE_FIT, atariPunkPcbMountingHoleRadius, atariPunkPcbMountingHoleRadius, center=true, $fn=50);
            /* Bottom Right Hole */
            translate([(atariPunkPcbWidth/2) - atariPunkPcbMountingHoleRadius - atairPunkPcbHoleDistanceFromEdge, (-atariPunkPcbHeight/2) + atariPunkPcbMountingHoleRadius + atairPunkPcbHoleDistanceFromEdge, 0])
                cylinder(atariPunkPcbThickness + INTERFERENCE_FIT, atariPunkPcbMountingHoleRadius, atariPunkPcbMountingHoleRadius, center=true, $fn=50);
            /* Bottom Left Hole */
            translate([(-atariPunkPcbWidth/2) + atariPunkPcbMountingHoleRadius + atairPunkPcbHoleDistanceFromEdge, (-atariPunkPcbHeight/2) + atariPunkPcbMountingHoleRadius + atairPunkPcbHoleDistanceFromEdge, 0])
                cylinder(atariPunkPcbThickness + INTERFERENCE_FIT, atariPunkPcbMountingHoleRadius, atariPunkPcbMountingHoleRadius, center=true, $fn=50);
        }

        /* Pitch Pot */
        translate([((atariPunkPcbWidth-atariPunkPotBaseWidth)/2), ((atariPunkPcbHeight-atariPunkPotBaseHeight)/2) - pitchPotDistanceFromTop, atariPunkPotBaseDepth/2])
            union() {
                color("silver")
                    cube([atariPunkPotBaseWidth, atariPunkPotBaseHeight, atariPunkPotBaseDepth], center=true);
                color("black")
                    translate([0, 0, atariPunkPotBaseHeight/2])
                        cylinder(atariPunkPotHeight, atariPunkPotRadius, atariPunkPotRadius, center=true);
            }

        /* Depth Pot */
        translate([((atariPunkPcbWidth-atariPunkPotBaseWidth)/2), ((-atariPunkPcbHeight+atariPunkPotBaseHeight)/2) + depthPotDistanceFromBottom, atariPunkPotBaseDepth/2])
            union() {
                color("silver")
                    cube([atariPunkPotBaseWidth, atariPunkPotBaseHeight, atariPunkPotBaseDepth], center=true);
                color("black")
                    translate([0, 0, atariPunkPotBaseHeight/2])
                        cylinder(atariPunkPotHeight, atariPunkPotRadius, atariPunkPotRadius, center=true);
            }

        /* Power Switch */
        translate([((-atariPunkPcbWidth+powerSwitchWidth)/2), ((-atariPunkPcbHeight+powerSwitchHeight)/2) + powerSwitchDistanceFromBottom, atariPunkPotBaseDepth/2])
            union() {
                color("silver")
                    cube([powerSwitchWidth, powerSwitchHeight, powerSwitchDepth], center=true);
                color("black")
                    translate([0, 0, powerSwitchHeight/2])
                        cube([powerDipSwitchWidth, powerDipSwitchHeight, powerDipSwitchDepth], center=true);
            }
    }
}

/**
 * @brief Mini Atari Punk Console PCB Stand Offs
 */
module miniAtariPcbStandOffs(atariPunkPcbStandoffHeight) {
    atariPunkXHoleSeparation = 29;
    atariPunkYHoleSeparation = 45.5;
    
    atariPunkPcbWidth  = 33.50;
    atariPunkPcbHeight = 50;
    atariPunkPcbMountingHoleRadius = 2;
    
    union() {
        /* Top Right Hole */
        translate([(atariPunkXHoleSeparation - atariPunkPcbMountingHoleRadius)/2, (atariPunkYHoleSeparation-atariPunkPcbMountingHoleRadius)/2, 0])
            cylinder(atariPunkPcbStandoffHeight, atariPunkPcbMountingHoleRadius, atariPunkPcbMountingHoleRadius, center=true, $fn=50);
        /* Top Left Hole */
        translate([(-atariPunkXHoleSeparation + atariPunkPcbMountingHoleRadius)/2, (atariPunkYHoleSeparation-atariPunkPcbMountingHoleRadius)/2, 0])
            cylinder(atariPunkPcbStandoffHeight, atariPunkPcbMountingHoleRadius, atariPunkPcbMountingHoleRadius, center=true, $fn=50);
        /* Bottom Right Hole */
        translate([(atariPunkXHoleSeparation - atariPunkPcbMountingHoleRadius)/2, (-atariPunkYHoleSeparation+atariPunkPcbMountingHoleRadius)/2, 0])
            cylinder(atariPunkPcbStandoffHeight, atariPunkPcbMountingHoleRadius, atariPunkPcbMountingHoleRadius, center=true, $fn=50);
        /* Bottom Left Hole */
        translate([(-atariPunkXHoleSeparation + atariPunkPcbMountingHoleRadius)/2, (-atariPunkYHoleSeparation+atariPunkPcbMountingHoleRadius)/2, 0])
            cylinder(atariPunkPcbStandoffHeight, atariPunkPcbMountingHoleRadius, atariPunkPcbMountingHoleRadius, center=true, $fn=50);
    }
}

module mountingHole(mountingHoleThickness) {
    mountingHoleRadius = 2;
    mountingHoleWidth = 5;

    union() {
        translate([(-mountingHoleWidth/2), 0, 0])
            cylinder(mountingHoleThickness, mountingHoleRadius, mountingHoleRadius, center=true, $fn=50);

        cube([mountingHoleWidth, mountingHoleRadius*2, mountingHoleThickness], center=true);

        translate([mountingHoleWidth/2, 0, 0])
            cylinder(mountingHoleThickness, mountingHoleRadius, mountingHoleRadius, center=true, $fn=50);
    }
}

module backingPlate(plateWidth, plateHeight, plateThickness) {
    mountingHoleOffset = 12;
    potentiometerCutoutRadius = 4;
    
    union() {
        difference() {
            color("white")
                cube([plateWidth, plateHeight, plateThickness], center=true);
            
            /* Mounting Holes */
            union() {
                /* Top Left Mounting Hole */
                translate([(-plateWidth/2) + 10, (plateHeight/2) - 2 - mountingHoleOffset, 0])
                    mountingHole(plateThickness+INTERFERENCE_FIT);
                /* Top Right Mounting Hole */
                translate([(plateWidth/2) - 10, (plateHeight/2) - 2 - mountingHoleOffset, 0])
                    mountingHole(plateThickness+INTERFERENCE_FIT);
                /* Bottom Left Mounting Hole */
                translate([(-plateWidth/2) + 10, (-plateHeight/2) + 2 + mountingHoleOffset, 0])
                    mountingHole(plateThickness+INTERFERENCE_FIT);
                /* Bottom Right Mounting Hole */
                translate([(plateWidth/2) - 10, (-plateHeight/2) + 2 + mountingHoleOffset, 0])
                    mountingHole(plateThickness+INTERFERENCE_FIT);
            }
            
            union() {
                /* Pitch Pot Cut Out */
                translate([5.875, 31.375, 0])
                    cylinder(plateThickness + INTERFERENCE_FIT, potentiometerCutoutRadius, potentiometerCutoutRadius, center=true);
                
                /* Depth Pot Cut Out */
                translate([5.875, 16.075, 0])
                    cylinder(plateThickness + INTERFERENCE_FIT, potentiometerCutoutRadius, potentiometerCutoutRadius, center=true);

                /* Stereo Out */
                translate([20.875, 31.375, 0])
                    cylinder(plateThickness + INTERFERENCE_FIT, potentiometerCutoutRadius, potentiometerCutoutRadius, center=true);
                
                /* CV1 Pot Cut Out */
                translate([20.875, 16.075, 0])
                    cylinder(plateThickness + INTERFERENCE_FIT, potentiometerCutoutRadius, potentiometerCutoutRadius, center=true);

                /* CV2 Pot Cut Out */
                translate([20.875, 0.775, 0])
                    cylinder(plateThickness + INTERFERENCE_FIT, potentiometerCutoutRadius, potentiometerCutoutRadius, center=true);

                /* Gate Pot Cut Out */
                translate([20.875, -14.525, 0])
                    cylinder(plateThickness + INTERFERENCE_FIT, potentiometerCutoutRadius, potentiometerCutoutRadius, center=true);

                translate([-5, 20, -7])
                    atariPunkPcb();
            }
        }

        /* Potentiometer Text */
        color("black")
            translate([0, 37, (plateThickness/2)-INTERFERENCE_FIT])
                union() {
                    linear_extrude(1)
                        text("Pitch", font="Noto Sans Mono", size=3);
                    translate([0, -15, 0])
                        linear_extrude(1)
                            text("Depth", font="Noto Sans Mono", size=3);
                    translate([17.5, 0, 0])
                        linear_extrude(1)
                            text("Out", font="Noto Sans Mono", size=3);
                    translate([17.5, -15, 0])
                        linear_extrude(1)
                            text("CV1", font="Noto Sans Mono", size=3);
                    translate([17.5, -30, 0])
                        linear_extrude(1)
                            text("CV2", font="Noto Sans Mono", size=3);
                    translate([16, -45, 0])
                        linear_extrude(1)
                            text("GATE", font="Noto Sans Mono", size=3);
                }

        color("black")
            translate([-20, (plateHeight/2) - 8, plateThickness - INTERFERENCE_FIT])
                union() {
                    linear_extrude(1)
                        text("KY Mini Mod Synth", font="Noto Sans Mono", size=3);
                    translate([21, -1, 0])
                        cube([42, 1, 1], center=true);
                }
    }
}

module atariMiniModSynthMount() {
    mountPlateWidth = 60;
    mountPlateHeight = 140;
    mountPlateThickness = 3;
    mountPcbStandoffHeight = 7;
    
    union() {
        backingPlate(mountPlateWidth, mountPlateHeight, mountPlateThickness);
        translate([-5, 20, (-mountPcbStandoffHeight/2) + INTERFERENCE_FIT])
            miniAtariPcbStandOffs(mountPcbStandoffHeight);
//        translate([-5, 20, -7])
//            atariPunkPcb();
    }
}
 
atariMiniModSynthMount();