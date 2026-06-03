/**
 * @file tabWasher.scad
 *
 * @version 1.0
 *
 * @author Calum Judd Anderson
 *
 * @brief Tab washer for the Cagiva Mito engine
 */

$fa = 0.01;
INTERFERENCE_FIT = 0.001;
SLIDE_FIT = 0.05;

TAB_WASHER_THICKNESS = 1.50;
TAB_WASHER_SVG_PATH = "./images/tabWasher.svg";

module tabWasherSvg(washerThickness) {
        import(TAB_WASHER_SVG_PATH);
}

tabWasherSvg(TAB_WASHER_THICKNESS);