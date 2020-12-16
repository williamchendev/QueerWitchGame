/// @description Wind Object Creation

// Create Wind
wind_time -= global.deltatime;
if (wind_time <= 0) {
	var wind_obj = instance_create_layer(x, y, layer, oWind);
	wind_obj.wind_spd = wind_spd;
	wind_obj.image_angle = wind_angle;
	wind_obj.image_xscale = wind_xscale;
	wind_obj.image_yscale = wind_yscale;

	wind_time = wind_time_delay + random_range(0, wind_time_random_delay);
}