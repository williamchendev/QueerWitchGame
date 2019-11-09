/// @description Insert description here
// You can write your code in this editor

if (command or command_lerp_time) {
	// Draw Transparent Layer
	draw_set_alpha(0.4 * (1 - ((game_manager.time_spd - 0.2) / 0.8)));
	draw_set_color(make_color_rgb(50, 50, 50));
	draw_rectangle(game_manager.camera_x - 50, game_manager.camera_y - 50, game_manager.camera_x + game_manager.camera_width + 50, game_manager.camera_y + game_manager.camera_height + 50, false);
	
	// Draw Character Overlay
	for (var l = 0; l < array_length_1d(layers); l++) {
		// Find Layer Elements
		var temp_layer_elements = layer_get_all_elements(layers[l]);
		for (var i = 0; i < array_length_1d(temp_layer_elements); i++) {
			// Check if Element is an Instance
		    if (layer_get_element_type(temp_layer_elements[i]) == layerelementtype_instance) {
				// Draw Instance
			    var temp_inst = layer_instance_get_instance(temp_layer_elements[i]);
			    with (temp_inst) {
					event_perform(ev_draw, 0);
				}
		    }
		}
	}
}