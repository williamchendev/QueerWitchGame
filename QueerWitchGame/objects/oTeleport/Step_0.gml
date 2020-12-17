/// @description Insert description here
// You can write your code in this editor

// Door Interact Behaviour
if (interact.interact_action) {
	// Teleport Interact Unit
	if (teleport_obj != noone) {
		if (interact.interact_unit != noone) {
			if (instance_exists(interact.interact_unit)) {
				interact.interact_unit.teleport = true;
				interact.interact_unit.teleport_x = teleport_obj.x - interact.interact_unit.x;
				interact.interact_unit.teleport_y = teleport_obj.y - interact.interact_unit.y;
			}
		}
	}
	
	// Reset Interact Behaviour
	interact.interact_action = false;
	interact.interact_unit = noone;
}