/// @description Wind Movement Update

// Move Wind
x += wind_spd * global.deltatime;

if (sign(wind_spd) == 1) {
	if (x > width + offset) {
		instance_destroy(physics_object);
		instance_destroy();
	}
}
else if (sign(wind_spd) == -1) {
	if (x < -offset) {
		instance_destroy(physics_object);
		instance_destroy();
	}
}
else {
	instance_destroy(physics_object);
	instance_destroy();
}