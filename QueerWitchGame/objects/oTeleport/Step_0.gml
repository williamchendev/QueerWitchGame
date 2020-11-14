/// @description Insert description here
// You can write your code in this editor

// Door Interact Behaviour
if (interact.interact_action) {
	// Teleport Interact Unit
	if (teleport_obj != noone) {
		interact.interact_unit.x = teleport_obj.x;
		interact.interact_unit.y = teleport_obj.y;
	}
	
	// Reset Interact Behaviour
	interact.interact_action = false;
	interact.interact_unit = noone;
}