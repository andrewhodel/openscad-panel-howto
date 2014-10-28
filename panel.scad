// this sets the quality of rounded edges
// higher is better, more than 200 isn't needed
$fn = 60;

// this is the thickness of each plate
// it is set as a variable to be used later
thickness = 2;

// it looks like there are 4 total faces for that part
// let's also add the other side and back

// first lets create the forwardmost plate as 2 parts
// partHeight needs to be adjusted matching the angle of
// the face of the panel, you could create a formula for this
partHeight = 31;
cube([5,thickness,partHeight]); // left part
cube([45,thickness,5]); // bottom part

// then lets create the left inside wall
// we have to move it over 5-thickness on the x axis
translate([5-thickness,0,0]) cube([thickness,20,partHeight]);

// now the right wall
// we can use difference here to map it to the faceplate
difference() {
	// difference just removes the portions of objects 2+
	// from the first object
	// http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#difference
	translate([45,0,0]) cube([thickness,20,partHeight]);
	// next we create a slightly taller cube to use to cut the first
	// but we move it backward on the y axis manually
	// then rotate it the same degrees as the face plate
	translate([45,-25.99,0]) rotate([-30,0,0]) cube([thickness,20,partHeight+20]);
}

// then lets create the top plate
// it's a cube the same dimensions (-5 on x) as the bottom forwardmost plate
// but laid on it's side
// so we move it over 5 on x then up to where it needs to be with translate
// the translate y value is adjusted manually
translate([5,15,partHeight-thickness]) cube([40,5,thickness]);

// the face we have created as a module so we can rotate
// and move it as one object (explained below)
// we translate it 5,0,5 as x,y,z to put it into position
// then rotate it the -30 degrees needed in x
translate([5,0,5]) rotate([-30,0,0]) face();

// this block represents an object for the face
// we create it as a module so we can rotate and translate
// it as a single object
module face() {

	// difference subtract objects 2+ from the first object
	// inside the {} block
	difference() {
		// this is the base plate for the face
		// you just define cube with the x,y,z dimensions
		// remember that inside the module face() it's base
		// dimensions are 0,0,0 without rotation
		cube([40,thickness,30]);

		// this is the square lcd cutout
		// the translate part means move it to that x,y,z position
		// and the cube means create a cube using those x,y,z positions
		// just like the base plate for the face above
		// we add 2 to the cube thickness and translate the y
		// axis with -1 to ensure it cuts the prior cube (face plate)
		translate([5,-1,10]) cube([20,thickness+2,10]);

		// this could be a hole cutout
		// we have to translate it to where we want it relative
		// to the face plate and -1deg on y to cut through the face
		// then we must rotate it first as cylinders are created
		// vertically, we rotate it -90 deg on the X axis
		// the cylinder r value is radius
		// and h is height, it must be greater than the plate thickness
		translate([35,-1,20]) rotate([-90,0,0]) cylinder(r=1, h=thickness+2);

		// here we create another circle for a button under the
		// one above
		translate([35,-1,10]) rotate([-90,0,0]) cylinder(r=1, h=thickness+2);

		// that's the whole face plate module, simple to add buttons/etc

	}

}

