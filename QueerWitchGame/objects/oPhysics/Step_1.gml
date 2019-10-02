/// @description Universal Physics Event
// calculates physical velocity and movement

// Check if Object Exists
if (!instance_exists(base_object)) {
	instance_destroy();
	return;
}

// Update positions
x = base_object.x;
y = base_object.y;
old_xposition = new_xposition;
old_yposition = new_yposition;
new_xposition = base_object.x;
new_yposition = base_object.y;

// Calculate velocities
hspd = (new_xposition - old_xposition) * physics_weight;
vspd = (new_yposition - old_yposition) * physics_weight;

// Change Mask Index
sprite_index = base_object.sprite_index;
image_index = base_object.image_index;
image_xscale = base_object.image_xscale;
image_yscale = base_object.image_yscale;
image_angle = base_object.image_angle;