/// @description Universal Physics Event
// calculates physical velocity and movement

// Update positions
x = base_object.x;
y = base_object.y;
old_xposition = new_xposition;
old_yposition = new_yposition;
new_xposition = base_object.x;
new_yposition = base_object.y;

// Calculate velocities
hspd = new_xposition - old_xposition;
vspd = new_yposition - old_yposition;

// Change Mask Index
sprite_index = base_object.sprite_index;
image_index = base_object.image_index;
image_xscale = base_object.image_xscale;
image_yscale = base_object.image_yscale;