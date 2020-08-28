/// @description Unit Combat Draw Event
// Draws the unit & its knockout effect to the screen

// Knockout
if (instance_exists(oKnockout)) {
	if (health_points > 0) {
		// Draw Layers
		shader_set(shd_black);
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
		shader_reset();
	}
}

// Debug Pathing Event Inhertited
event_inherited();