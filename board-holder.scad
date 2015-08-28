board_dims = [30.5, 17.9, 1];
$fs = 0.1;

module holder() {
difference() {
	union() {
		cube([30.5+3,17.9+3,6]);
		translate([30.5+3-0.01,0,0]) cube([8, 17.9+3, 2]);
	}
	translate([3/2,3/2, 4])
		cube(board_dims);
	translate([3/2, 3/2+0.5/2, 1])
		cube(board_dims + [0,-0.5,10]);

	for (i = [10,25, 37.5])
	translate([i,(17.9+3)/2, -1])
		cylinder(d = 2.2, h = 5);

}
}
module splitter() {
translate([30.5 + 1.5-0.05,-1,-1])
		cube(50);
}

rotate([0,-90,0])
difference() {
	holder();
	splitter();
}
translate([-25,0,0])
intersection() {
	holder();
	splitter();
}