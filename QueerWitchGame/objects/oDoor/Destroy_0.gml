/// @description Insert description here
// You can write your code in this editor

// Destroy Instances
instance_destroy(door_solid);
if (instance_exists(door_material)) {
	instance_destroy(door_material);
}