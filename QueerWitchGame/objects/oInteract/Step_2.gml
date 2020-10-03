/// @description Insert description here
// You can write your code in this editor

// Interact Behaviour
var temp_interact_behaviour_active = false
if (instance_exists(interact_obj) or interact_obj != noone) {
	// Check if Interact Unit is Active
	if (interact_unit != noone) {
		if (instance_exists(interact_unit)) {
			// Interact Behaviour
			temp_interact_behaviour_active = true;
		}
		else {
			// Remove Unit
			interact_unit = noone;
		}
	}
}
else {
	// Destroy Object
	instance_destroy();
	active = false;
	interact_select = false;
	return;
}

interact_action = temp_interact_behaviour_active;

// Mirror Interact Object Properties
x = interact_obj.x;
y = interact_obj.y;
sprite_index = interact_obj.sprite_index;
image_index = interact_obj.image_index;
image_xscale = interact_obj.image_xscale;
image_yscale = interact_obj.image_yscale;
image_angle = interact_obj.image_angle;

// Interact Selection
if (interact_select) {
	interact_select_draw_value = lerp(interact_select_draw_value, 1, global.realdeltatime * interact_select_draw_spd);
}
else {
	interact_select_draw_value = lerp(interact_select_draw_value, 0, global.realdeltatime * interact_select_draw_spd);
}

if (interact_select_draw_value > 0) {
	if (is_undefined(ds_map_find_value(game_manager.surface_manager.interacts_outline, self))) {
		ds_map_add(game_manager.surface_manager.interacts_outline, self, interact_select_outline_color);
	}
}

interact_select_draw_value = clamp(interact_select_draw_value, 0, 1);