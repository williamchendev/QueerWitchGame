/// @description Insert description here
// You can write your code in this editor

// Debug Key Checks
if (game_manager != noone) {
	key_left = keyboard_check(game_manager.left_check);
	key_right = keyboard_check(game_manager.right_check);
	key_up = keyboard_check(game_manager.up_check);
	key_down = keyboard_check(game_manager.down_check);

	key_left_press = keyboard_check_pressed(game_manager.left_check);
	key_right_press = keyboard_check_pressed(game_manager.right_check);
	key_up_press = keyboard_check_pressed(game_manager.up_check);
	key_down_press = keyboard_check_pressed(game_manager.down_check);
		
	key_interact_press = keyboard_check_pressed(game_manager.interact_check);
	key_inventory_press = keyboard_check_pressed(game_manager.inventory_check);
		
	key_fire_press = mouse_check_button(mb_left);
	key_aim_press = mouse_check_button(mb_right);
	key_reload_press = keyboard_check_pressed(game_manager.reload_check);
		
	key_command = keyboard_check(game_manager.command_check);
		
	cursor_x = mouse_x;
	cursor_y = mouse_y;
}

// Inherit the parent event
event_inherited();

// Draw Val
leg_draw_val += global.deltatime * leg_spd * sign(x_velocity) * sign(image_xscale);
while (leg_draw_val >= 1) {
	leg_draw_val--;
}
while (leg_draw_val < 0) {
	leg_draw_val++;
}

// Calculate Leg Behaviour
for (var i = 0; i < array_height_2d(leg_anchor); i++) {
	// Leg Direction
	var temp_leg_draw_val = leg_draw_val + leg_draw_val_offset[i];
	leg_direction[i] = 360 * temp_leg_draw_val * -sign(image_xscale);

	if (!leg_grounded[i]) {
		if (abs(angle_difference(leg_direction[i], 270 + (leg_ground_check_angle_offset * sign(image_xscale)))) < leg_ground_check_angle_range) {
			// Find Leg Anchors
			var temp_leg_anchor_distance = point_distance(0, 0, leg_anchor[i, 0] * sign(image_xscale), leg_anchor[i, 1]);
			var temp_leg_anchor_direction = point_direction(0, 0, leg_anchor[i, 0] * sign(image_xscale), leg_anchor[i, 1]);
			var temp_leg_anchor_x = x + lengthdir_x(temp_leg_anchor_distance, temp_leg_anchor_direction + draw_angle);
			var temp_leg_anchor_y = y + lengthdir_y(temp_leg_anchor_distance, temp_leg_anchor_direction + draw_angle);
	
			// Find Leg Check Position
			var temp_leg_ground_check_x = temp_leg_anchor_x + lengthdir_x(leg_ground_check_radius, leg_direction[i]);
			var temp_leg_ground_check_y = temp_leg_anchor_y + lengthdir_y(leg_ground_check_radius, leg_direction[i]);
			temp_leg_ground_check_y = raycast_ground(temp_leg_ground_check_x, temp_leg_ground_check_y, max(1, (bbox_bottom - temp_leg_ground_check_y) + 2));
	
			// Set Leg End
			if (temp_leg_ground_check_y != noone) {
				leg_grounded[i] = true;
				leg_end[i, 0] = temp_leg_ground_check_x;
				leg_end[i, 1] = temp_leg_ground_check_y;
			}
		}
	}
	else {
		if (abs(angle_difference(leg_direction[i], 270 + (leg_ground_check_angle_offset * sign(image_xscale)))) >= leg_ground_check_angle_range) {
			leg_grounded[i] = false;
		}
	}
}

// Draw Legs
for (var i = 0; i < array_height_2d(leg_anchor); i++) {
	// Find Leg Anchors
	var temp_leg_anchor_distance = point_distance(0, 0, leg_anchor[i, 0] * sign(image_xscale), leg_anchor[i, 1]);
	var temp_leg_anchor_direction = point_direction(0, 0, leg_anchor[i, 0] * sign(image_xscale), leg_anchor[i, 1]);
	var temp_leg_anchor_x = x + lengthdir_x(temp_leg_anchor_distance, temp_leg_anchor_direction + draw_angle);
	var temp_leg_anchor_y = y + lengthdir_y(temp_leg_anchor_distance, temp_leg_anchor_direction + draw_angle);
	
	// Find Leg End
	var temp_leg_end_x = leg_end[i, 0];
	var temp_leg_end_y = leg_end[i, 1];
	
	// Check For Point
	leg_limb[i].limb_direction = sign(image_xscale);
	leg_limb[i].limb_anchor_x = temp_leg_anchor_x;
	leg_limb[i].limb_anchor_y = temp_leg_anchor_y;
	if (leg_grounded[i]) {
		leg_lerp[i, 0] = lerp(leg_lerp[i, 0], temp_leg_end_x, global.deltatime * leg_lerp_spd);
		leg_lerp[i, 1] = lerp(leg_lerp[i, 1], temp_leg_end_y, global.deltatime * leg_lerp_spd);
	}
	else {
		leg_lerp[i, 0] = lerp(leg_lerp[i, 0], temp_leg_anchor_x + (4 * sign(image_xscale)), global.deltatime * leg_lerp_spd);
		leg_lerp[i, 1] = lerp(leg_lerp[i, 1], temp_leg_anchor_y + 5, global.deltatime * leg_lerp_spd);
	}
	
	leg_limb[i].limb_target_x = leg_lerp[i, 0];
	leg_limb[i].limb_target_y = leg_lerp[i, 1];
}