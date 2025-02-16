/**
 * @file coffeeGrinderSettings.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Captures the grind settings for the Hario Mini Mill
 */
INTERFERENCE_FIT = 0.001;
HEART_LOGO = "./heart.svg";

module backingBoard(boardWidth, boardHeight, boardThickness) {
    difference() {
        cube([boardWidth, boardHeight, boardThickness], center=true);
        translate([0, 0, boardThickness/2])
            cube([boardWidth - 2, boardHeight - 2, boardThickness/2], center=true);
    }
}

module coffeeSettings() {
    textThickness = 3;
    textVerticalSpacingDifference = 10;
    
    union() {
        translate([10, 0, 0])
            union() {
                linear_extrude(textThickness)
                    text("Calibration Chart", font="Noto Sans Mono", size = 5);
                translate([34, -2, 0])
                    cube([68, 1, textThickness], center=true);
            }
        
        translate([0, -20, 0])
            linear_extrude(textThickness)
                text("Turkish         1", font="Noto Sans Mono", size = 5);
        
        translate([0, -30, 0])
            linear_extrude(textThickness)
                text("Espresso        1 -  4", font="Noto Sans Mono", size = 5);
        
        translate([0, -40, 0])
            linear_extrude(textThickness)
                text("Aeropress       3 - 13", font="Noto Sans Mono", size = 5);
        
        translate([0, -50, 0])
            linear_extrude(textThickness)
                text("Moka Pot        4 -  8", font="Noto Sans Mono", size = 5);
        
        translate([0, -60, 0])
            linear_extrude(textThickness)
                text("V60             4 -  9", font="Noto Sans Mono", size = 5);

        translate([0, -70, 0])
            linear_extrude(textThickness)
                text("French Press    9 - 18", font="Noto Sans Mono", size = 5);

        translate([0, -80, 0])
            linear_extrude(textThickness)
                text("Cold Brew      11 - 20", font="Noto Sans Mono", size = 5);

        translate([30, -97, 0])
            union() {
                translate([-15, -2, 0])
                    heartLogo();
                linear_extrude(textThickness)
                    text("Melissa", font="Noto Sans Mono", size = 5);
                translate([30, -2, 0])
                    heartLogo();
            }
    }
}

module heartLogo() {
    scale([0.25, 0.25, 1])
        linear_extrude(3)
            import(HEART_LOGO);
}

/**
 * @brief Creates the coffee grinder chart
 */
module grinderSettings() {
    boardWidth = 100;
    boardHeight = 120;
    boardThickness = 5;
    
    union () {
        backingBoard(boardWidth, boardHeight, boardThickness);
        translate([(-boardWidth/2) + 5, (boardHeight/2) - 15, 0])
            coffeeSettings();
    }
}

grinderSettings();