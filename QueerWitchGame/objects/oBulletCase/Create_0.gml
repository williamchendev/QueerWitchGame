/// @description Insert description here
// You can write your code in this editor

var temp_case_rotation_sign = 1;
if (random(1) < 0.5) {
	temp_case_rotation_sign = -1;
}
case_rotation = temp_case_rotation_sign * random_range(4, 10);
case_direction = random_range(45, 15) + 90;
case_spd = 3;
gravity_spd = 0.13;
spd = 0;

decay = random_range(1000, 4000);
decay_max = decay;