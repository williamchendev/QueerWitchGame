/// raycast_line(x,y,angle,length,damage,ignore_id);
/// @description Raycasts a line for unit objects to apply damage to
/// @param {real} x The x position of the raycast to check
/// @param {real} y The y position of the raycast to check
/// @param {real} angle The direction/angle of the raycast to check
/// @param {real} length The range/length of the raycast to check
/// @param {real} damage The damage of the raycast to deal to units
/// @returns {real} The length of the raycast before the raycast touched an object

// Establish Variables
var temp_x = argument[0];
var temp_y = argument[1];
var temp_angle = argument[2];
var temp_length = argument[3];
var temp_damage = argument[4];
var temp_ignore_id = argument[5];

// Raycast for Objects
var temp_check_x = temp_x;
var temp_check_y = temp_y;

var temp_ignore_material = collision_point(temp_check_x, temp_check_y, oMaterial, false, true);

var temp_interpolation = 1;
for (var i = 0; i <= temp_length; i += temp_interpolation) {
	// Check for Solids
	var temp_solid = collision_point(temp_check_x, temp_check_y, oSolid, false, true);
	if (temp_solid != noone) {
		return i;
	}
	
	// Check for Material
	var temp_material = collision_point(temp_check_x, temp_check_y, oMaterial, false, true);
	if (temp_material != noone) {
		if (temp_material != temp_ignore_material) {
			return i;
		}
	}
	
	// Check for Unit
	var temp_unit = collision_point(temp_check_x, temp_check_y, oUnit, false, true);
	if (temp_unit != noone) {
		if (temp_unit.team_id != temp_ignore_id) {
			temp_unit.health_points -= temp_damage;
			temp_unit.health_points = clamp(temp_unit.health_points, 0, temp_unit.max_health_points);
			
			if (temp_unit.health_points == 0) {
				temp_unit.force_applied = true;
				temp_unit.force_x = temp_check_x;
				temp_unit.force_y = temp_check_y;
				temp_unit.force_xvector = cos(degtorad(temp_angle)) * 15;
				temp_unit.force_yvector = sin(degtorad(temp_angle)) * 15;
			}
			
			return i;
		}
	}
	
	temp_check_x += lengthdir_x(temp_interpolation, temp_angle);
	temp_check_y += lengthdir_y(temp_interpolation, temp_angle);
}

return temp_length;