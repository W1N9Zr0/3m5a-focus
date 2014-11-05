use <MCAD/involute_gears.scad>
use <servo_arm.scad>

lens_r = 80 / 2;
lens_r_minor = 79.75 / 2;
grip_tooth_w = 1;
grip_tooth_d = 0.05;

function pitch_radius(n, dp) = n * (1 / dp) / 2;

pitch = 1.04;
lens_teeth = 90;
motor_teeth = 38;

clamp_size = 12;
clamp_gap = 5;
clamp_l = 11;

* difference() {
	union() {
		gear(
			number_of_teeth = lens_teeth,
			diametral_pitch = pitch,
			gear_thickness = 15,
			rim_thickness = 15,
			bore_diameter = 5);

		translate([0,-clamp_size/2,0]) cube([lens_r + clamp_l, clamp_size,15 ]);
	}

	cylinder(r = lens_r_minor, h = 22, $fa = 2);
	rotate(10)
	translate([0,0,-1]) intersection() {
		union() for(i=[0:7]) rotate(360/8*i) translate([0,-6,0]) cube([lens_r*1.1, 12, 22]);
		cylinder(r = lens_r, h = 22, $fa = 2);
	}

	translate([0,-clamp_gap/2,-1]) cube([lens_r + clamp_l+1, clamp_gap, 22]);

	translate([lens_r + clamp_l /3*2, -clamp_size/2 - 1,15/2])
		rotate([-90,0,0]) cylinder(d = 3, h = clamp_size + 2, $fs=0.1);
}

distance = pitch_radius(lens_teeth, pitch) + pitch_radius(motor_teeth, pitch);

//translate([distance,0,0])

translate([0,0,6])
rotate([0,180,0])
difference() {
gear(
	$fs = 0.1, $fa=8,
	number_of_teeth = motor_teeth,
	diametral_pitch = pitch,
	gear_thickness = 3,
	rim_thickness = 6,
	rim_width = 1,
	hub_thickness = 6,
	hub_diameter = 10,
	bore_diameter = 2,
	circles = 5);

translate([0,0,6+.01]) rotate([0,180,0]) servo_head();	
}