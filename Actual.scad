
/*
  Parametric Ergonomic Mouse
  Units: millimeters
  Editable OpenSCAD source
*/

$fn = 48;

// ---------- Main dimensions ----------
body_length = 90;
body_width  = 60;
body_height = 31;

button_gap = 2.0;
button_length = 53;
button_width = 25;
button_height = 3;

wheel_radius = 3.5;
wheel_width = 9;

// ---------- Rounded body ----------
module mouse_body() {
    intersection() {
        hull() {
            translate([0, -36, 12])
                scale([0.30, 0.15, 0.50])
                    sphere(r=body_width);

            translate([0, -20, 14])
                scale([0.43, 0.25, 0.58])
                    sphere(r=body_width);

            translate([0, 8, 14])
                scale([0.50, 0.38, 0.58])
                    sphere(r=body_width);

            translate([0, 32, 12])
                scale([0.40, 0.25, 0.48])
                    sphere(r=body_width);
        }

        // Flat underside
        translate([-50, -55, 0])
            cube([100, 110, body_height]);
    }
}

// ---------- Rounded click buttons ----------
module click_button(xpos) {
    translate([xpos, -19, 28])
        hull() {
            translate([0, -button_length/2 + 4, 0])
                cylinder(h=button_height, r=button_width/2);

            translate([0, button_length/2 - 4, 0])
                cylinder(h=button_height, r=button_width/2);
        }
}

// ---------- Scroll wheel ----------
module scroll_wheel() {
    // Wheel axis runs from left to right
    rotate([0, 90, 0])
        translate([0, 0, -wheel_width/2])
            cylinder(
                h=wheel_width,
                r=wheel_radius,
                center=false
            );
}

// ---------- Wheel support ----------
module wheel_support() {
    translate([-2, -24, 25])
        cube([4, 13, 5]);
}

// ---------- Thumb rest ----------
module thumb_rest() {
    hull() {
        translate([-32, -15, 5])
            scale([0.65, 1.0, 0.45])
                sphere(r=10);

        translate([-38, 10, 5])
            scale([0.60, 1.25, 0.50])
                sphere(r=10);
    }
}

// ---------- Complete assembly ----------
module ergonomic_mouse() {
    color([0.18, 0.19, 0.22])
        mouse_body();

    // Separate left and right click paddles
    color([0.30, 0.32, 0.36]) {
        click_button(-14);
        click_button(14);
    }

    // Wheel positioned between the buttons
    color([0.08, 0.08, 0.08])
        translate([0, -24, 30])
            scroll_wheel();

    color([0.18, 0.19, 0.22])
        wheel_support();

    color([0.25, 0.27, 0.30])
        thumb_rest();
}

// Display model
ergonomic_mouse();
