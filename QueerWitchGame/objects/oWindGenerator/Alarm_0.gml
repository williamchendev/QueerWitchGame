/// @description Wind Object Creation

// Create Wind
var wind_obj = instance_create_layer(x, y, layer, oWind);
wind_obj.wind_spd = wind_spd;
wind_obj.image_angle = wind_angle;
wind_obj.image_xscale = wind_xscale;
wind_obj.image_yscale = wind_yscale;

alarm[0] = wind_time + random_range(-wind_time_random_delay, wind_time_random_delay);