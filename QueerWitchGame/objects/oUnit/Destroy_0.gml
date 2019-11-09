/// @description Unit Destroy Event
// Cleans up the variables and DS Structures of the Unit on the Unit's Destroy Event

// Clear Platform Indexing List
ds_list_destroy(platform_list);
platform_list = -1;

// Clear Universal Physics Object
instance_destroy(universal_physics_object);

// Clear instance from Game Manager instantiated unit objects
ds_list_delete(game_manager.instantiated_units, ds_list_find_index(game_manager.instantiated_units, self));

// Clear Unit Layers
for (var l = array_length_1d(layers) - 1; l >= 0; l--) {
	layer_destroy(layers[l]);
}