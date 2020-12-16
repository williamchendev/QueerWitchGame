/// @description Ragdoll Entity Update Event
// Performs calculations for the Ragdoll Entity Object

// Debug
/*
if (held) {
	var px = (mouse_x-x);
	var py = (mouse_y-y);
	phy_speed_x = px;
	phy_speed_y = py;
	
	if (!mouse_check_button(mb_left)) {
		held = false;
	}
}
else {
	if (mouse_check_button_pressed(mb_left)) {
		if (position_meeting(mouse_x, mouse_y, self)) {
			with (oRagdollEntity) {
				held = false;
			}
			held = true;
		}
	}
}
*/

// Deltatime Physics
var temp_speed_change_x = phy_linear_velocity_x - phy_speed_old_x;
var temp_speed_change_y = phy_linear_velocity_y - phy_speed_old_y;
phy_linear_velocity_x = phy_speed_old_x + (temp_speed_change_x * global.deltatime);
phy_linear_velocity_y = phy_speed_old_y + (temp_speed_change_y * global.deltatime);

if (global.deltatime < old_delta_time) {
	var temp_delta_delta_time = old_delta_time - global.deltatime;
	phy_speed_x_bank += temp_delta_delta_time * phy_linear_velocity_x;
	phy_speed_y_bank += temp_delta_delta_time * phy_linear_velocity_y;
	phy_linear_velocity_x -= temp_delta_delta_time * phy_linear_velocity_x;
	phy_linear_velocity_y -= temp_delta_delta_time * phy_linear_velocity_y;
}
else if (global.deltatime > old_delta_time) {
	var temp_bank_return = clamp((global.deltatime - old_delta_time) / (1 - old_delta_time), 0.0, 1.0);
	phy_linear_velocity_x += phy_speed_x_bank * temp_bank_return;
	phy_linear_velocity_y += phy_speed_y_bank * temp_bank_return;
	phy_speed_x_bank -= phy_speed_x_bank * temp_bank_return;
	phy_speed_y_bank -= phy_speed_y_bank * temp_bank_return;
}

phy_speed_old_x = phy_linear_velocity_x;
phy_speed_old_y = phy_linear_velocity_y;
old_delta_time = global.deltatime;