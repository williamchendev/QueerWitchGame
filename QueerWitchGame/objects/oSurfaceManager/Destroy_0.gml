/// @description Surface Manager Destroy
// Surface Manager Destroy Event Behaviour

// Data Structures Garbage Collection
ds_map_destroy(units_outline);

// Clear Surfaces
surface_free(unit_outline_surface);
surface_free(unit_outline_overlay_surface);