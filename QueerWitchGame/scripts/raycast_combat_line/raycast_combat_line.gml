/// raycast_combat_line(x,y,angle,length,collision_array,ignore_id);
/// @description Raycasts a line for unit objects to apply damage to
/// @param {real} x The x position of the raycast to check
/// @param {real} y The y position of the raycast to check
/// @param {real} angle The direction/angle of the raycast to check
/// @param {real} length The range/length of the raycast to check
/// @param {array} collision_array The array of objects to check for
/// @param {string} ignore_id The optional overload string id to ignore units with this raycast
/// @returns {real} The length of the raycast before the raycast touched an object

// Establish Variables
var temp_x = argument[0];
var temp_y = argument[1];
var temp_angle = argument[2];
var temp_length = argument[3];

var temp_arg_collision_array = argument[4];
var temp_unit_check = false;
var temp_material_check = false;
var temp_collision_array = noone;
var temp_collision_array_index = 0;
for (var q = array_length_1d(temp_arg_collision_array) - 1; q >= 0; q--) {
	// Check for Unique Checks
	if (temp_arg_collision_array[q] == oUnit) {
		temp_unit_check = true;
		continue;
	}
	if (temp_arg_collision_array[q] == oMaterial) {
		temp_material_check = true;
		continue;
	}
	
	// Index and increment the collision array
	temp_collision_array[temp_collision_array_index] = temp_arg_collision_array[q];
	temp_collision_array_index++;
}

var temp_ignore_id = "unassigned";
if (argument_count > 5) {
	temp_ignore_id = argument[5];
}

// Raycast for Objects
var temp_line_length = 0;
var temp_collider_object_type = noone;
var temp_collider_object = noone;

var temp_check_x = temp_x;
var temp_check_y = temp_y;

var temp_ignore_material = collision_point(temp_check_x, temp_check_y, oMaterial, false, true);
if (temp_ignore_material != noone) {
	if (!material_check_position(temp_ignore_material, temp_check_x, temp_check_y)) {
		temp_ignore_material = noone;
	}
}

var temp_interpolation = 1;
for (var i = 0; i <= temp_length; i += temp_interpolation) {
	// Check for Solids
	var temp_solid = collision_point(temp_check_x, temp_check_y, oSolid, false, true);
	if (temp_solid != noone) {
		temp_line_length = i;
		temp_collider_object_type = oSolid;
		temp_collider_object = temp_solid;
		break;
	}
	
	// Check for Material
	if (temp_material_check) {
		var temp_material = collision_point(temp_check_x, temp_check_y, oMaterial, false, true);
		if (temp_material != noone) {
			if (temp_material != temp_ignore_material) {
				// Iterate through Material team_ids
				var temp_material_valid_team = false;
				for (var k = 0; k < ds_list_size(temp_material.material_units); k++) {
					if (ds_list_find_value(temp_material.material_units, k) != temp_ignore_id) {
						temp_material_valid_team = true;
						break;
					}
				}
				
				// Check for Material
				if (temp_material_valid_team) {
					if (material_check_position(temp_material, temp_check_x, temp_check_y)) {
						temp_line_length = i;
						temp_collider_object_type = oMaterial;
						temp_collider_object = temp_material;
						break;
					}
				}
			}
		}
	}
	
	// Check for Unit
	if (temp_unit_check) {
		var temp_unit = collision_point(temp_check_x, temp_check_y, oUnit, false, true);
		if (temp_unit != noone) {
			if (temp_unit.team_id != temp_ignore_id) {
				temp_line_length = i;
				temp_collider_object_type = oUnit;
				temp_collider_object = temp_unit;
				break;
			}
		}
	}
	
	// Check for Collision Array
	for (var l = 0; l < array_length_1d(temp_collision_array); l++) {
		var temp_collider = collision_point(temp_check_x, temp_check_y, temp_collision_array[l], false, true);
		if (temp_collider != noone) {
			temp_line_length = i;
			temp_collider_object_type = temp_collision_array[l];
			temp_collider_object = temp_collider;
			break;
		}
	}
	
	// Move Raycast Check
	temp_check_x += lengthdir_x(temp_interpolation, temp_angle);
	temp_check_y += lengthdir_y(temp_interpolation, temp_angle);
}

// Return Array
if (temp_collider_object == noone) {
	temp_line_length = temp_length;
}

var temp_return_array = noone;
temp_return_array[0] = temp_line_length;
temp_return_array[1] = temp_check_x;
temp_return_array[2] = temp_check_y;
temp_return_array[3] = temp_collider_object_type;
temp_return_array[4] = temp_collider_object;

return temp_return_array;