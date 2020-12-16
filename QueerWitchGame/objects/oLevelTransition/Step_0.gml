/// @description Insert description here
// You can write your code in this editor

if (!transition_active) {
	if (place_meeting(x, y, oUnitSquad)) {
		// Iterate through Squad Units for Player
		var temp_unit_squad_list = ds_list_create();
		var temp_unit_squad_list_num = instance_place_list(x, y, oUnitSquad, temp_unit_squad_list, false);
		for (var i = 0; i < temp_unit_squad_list_num; i++) {
			var temp_squad_unit_inst = ds_list_find_value(temp_unit_squad_list, i);
			if (temp_squad_unit_inst.player_input) {
				transition_active = true;
				transition_timer = transition_duration;
				
				temp_squad_unit_inst.canmove = false;
				temp_squad_unit_inst.player_input = false;
				break;
			}
		}
		ds_list_destroy(temp_unit_squad_list);
	}
}
else {
	if (transition_other_room_active) {
		if (!transition_player_unit_check) {
			// Iterate through Squad Units for Player
			var temp_unit_squad_list = ds_list_create();
			var temp_unit_squad_list_num = instance_place_list(x, y, oUnitSquad, temp_unit_squad_list, false);
			for (var i = 0; i < temp_unit_squad_list_num; i++) {
				var temp_squad_unit_inst = ds_list_find_value(temp_unit_squad_list, i);
				if (temp_squad_unit_inst.player_input) {
					transition_player_unit = temp_squad_unit_inst;
					transition_player_unit_exists = true;
					temp_squad_unit_inst.canmove = false;
					temp_squad_unit_inst.player_input = false;
					break;
				}
			}
			ds_list_destroy(temp_unit_squad_list);
			transition_player_unit_check = true;
		}
		
		transition_timer += transition_spd * global.realdeltatime;
		if (transition_timer >= transition_duration) {
			if (transition_player_unit_exists) {
				transition_player_unit.canmove = false;
				transition_player_unit.player_input = false;
			}
			instance_destroy();
		}
	}
	else {
		transition_timer -= transition_spd * global.realdeltatime;
		if (transition_timer <= 0) {
			persistent = true;
			transition_other_room_active = true;
			room_goto(transition_room_goto);
		}
	}
}

transition_timer = clamp(transition_timer, 0, transition_duration);
transition_alpha = 1 - (transition_timer / transition_duration);