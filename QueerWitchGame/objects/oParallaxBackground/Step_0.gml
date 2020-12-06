/// @description Parallax Background Update
// Calculates the Parallax Background Behaviour


// Check Player
var temp_reset_player_follow = false;
if (player_follow == noone) {
	temp_reset_player_follow = true;
}
else if (!instance_exists(player_follow)) {
	temp_reset_player_follow = true;
}

if (temp_reset_player_follow) {
	if (instance_number(oUnitSquad) > 0) {
		for (var i = 0; i < instance_number(oUnitSquad); i++) {
			var temp_inst = instance_find(oUnitSquad, i);
			if (temp_inst.camera_follow) {
				player_follow = temp_inst;
				break;
			}
		}
	}
}

// Find Target
var temp_target_x = game_manager.camera_x + (game_manager.game_width / 2);
var temp_target_y = game_manager.camera_y + game_manager.game_height;

for (var i = 0; i < array_length_1d(background_sprite); i++) {
	background_scroll_value[i] += global.deltatime * background_scroll_spd[i];
	while (background_scroll_value[i] >= 1) {
		background_scroll_value[i]--;
	}
	background_x_offset[i] = (background_move_spd[i] * temp_target_x) + (background_scroll_value[i] * sprite_get_width(background_sprite[i]));
}
background_y_offset = clamp((temp_target_y - game_manager.game_height) * -background_move_y_spd, 0, sprite_get_height(background_sprite[0]) - game_manager.game_height) + background_y;

// Move Background
x = temp_target_x;
y = temp_target_y;