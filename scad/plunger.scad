$fn=50;

// bottom of plunger where it engages with the loadcell
LOWER_HOLE_DIAMETER=10;
LOWER_LENGTH=16;

SPRING_REST_HEIGHT=6;

SPRING_OUTER_DIAMETER=24;
SPRING_INNER_DIAMETER=19;

// UPPER_LENGTH=28;

UPPER_LENGTH=5;

module dovetail(offset=0, length=SPRING_INNER_DIAMETER) {

    width=5;
    height=2.5;
    rebate=0.75;
    translate([0, 0, - height - offset])
    intersection() {
        cylinder(d=length, h=width + offset);
        rotate([90, 0, 0])
        linear_extrude(height = length, center = true)
        translate([-width/2, 0, 0])
        polygon([
            [0 - offset, 0],
            [rebate - offset, height + offset],
            [width - rebate + offset, height + offset],
            [width + offset, 0]
        ]);
    }

}

module spacer(height=10) {
    difference() {
        cylinder(d=SPRING_INNER_DIAMETER, h=height);
        translate([0, 0, height + 0.01])
        dovetail(offset=0.2, length = SPRING_OUTER_DIAMETER);
    }

    dovetail();

}

module bottom() {
    cylinder(d=LOWER_HOLE_DIAMETER, h=LOWER_LENGTH);

    translate([0, 0, LOWER_LENGTH])
    cylinder(d=SPRING_OUTER_DIAMETER, h=SPRING_REST_HEIGHT);

    translate([0, 0, LOWER_LENGTH + SPRING_REST_HEIGHT])
    difference() {
        cylinder(d=SPRING_INNER_DIAMETER, h=UPPER_LENGTH);
        translate([0, 0, UPPER_LENGTH + 0.01])
        dovetail(offset=0.2, length = SPRING_OUTER_DIAMETER);
    }
}

module top() {
    union() {
        cylinder(d=SPRING_INNER_DIAMETER, h=2.5);
        dovetail();
    }
}
