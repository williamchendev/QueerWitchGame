/// @description Insert description here
// You can write your code in this editor

// Reset Material Units
ds_list_clear(material_units);

// Collect Material Units team_ids
var temp_material_units = ds_list_create();
var temp_material_units_num = instance_place_list(x, y, oUnit, temp_material_units, false);

for (var i = 0; i < temp_material_units_num; i++) {
	// Material Unit Variable
	var temp_material_unit = ds_list_find_value(temp_material_units, i);
	
	// Interate through Material Units
	var temp_unit_exists = false;
	for (var l = 0; l < ds_list_size(material_units); l++) {
		// Check against Unit Array
		if (temp_material_unit.team_id == ds_list_find_value(material_units, l)) {
			temp_unit_exists = true;
			break;
		}
	}
	
	// Index Material Unit team_ids
	if (!temp_unit_exists) {
		ds_list_add(material_units, temp_material_unit.team_id);
	}
}

// Manually Set Material Team Id
if (material_team_id != noone) {
	ds_list_add(material_units, material_team_id);
}

// Garbage Collection
ds_list_destroy(temp_material_units);
temp_material_units = -1;

