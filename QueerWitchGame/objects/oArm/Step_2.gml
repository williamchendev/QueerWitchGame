/// @description Arm Update
// Calculates the Arm Effect (Movement and Positional Variables)

// Calculate Limb Movement
var temp_distance = point_distance(limb_anchor_x, limb_anchor_y, limb_target_x, limb_target_y);
var temp_direction = point_direction(limb_anchor_x, limb_anchor_y, limb_target_x, limb_target_y);

var temp_extension_percent = clamp(clamp(temp_distance, 0, limb_length) / limb_length, 1 / limb_length, limb_length);
var temp_extension_angle1 = (-90 * limb_direction) * (1 - temp_extension_percent);
var temp_extension_angle2 = (90 * limb_direction) * (1 - temp_extension_percent);

var temp_limb_angle1 = temp_direction + temp_extension_angle1;
var temp_limb_angle2 = temp_direction + temp_extension_angle2;
angle_1 = temp_limb_angle1;
angle_2 = temp_limb_angle2;

var temp_limb_length = (limb_length / 2) - ((1 - temp_extension_percent) * (limb_compress * limb_length));

// Calculate Limb Position
point1_x = limb_anchor_x + lengthdir_x(temp_limb_length, temp_limb_angle1);
point1_y = limb_anchor_y + lengthdir_y(temp_limb_length, temp_limb_angle1);

point2_x = point1_x + lengthdir_x(temp_limb_length, temp_limb_angle2);
point2_y = point1_y + lengthdir_y(temp_limb_length, temp_limb_angle2);