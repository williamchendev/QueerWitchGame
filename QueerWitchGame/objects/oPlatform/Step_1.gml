/// @description Platform Update Event
// performs all the calculations for the platform update event

// Unit Collision Check
var unit_list = ds_list_create();
var unit_num = collision_rectangle_list(x, y - 10, x + sprite_width, y, oDebugUnit, false, true, unit_list, false);
if (unit_num > 0) {
	// Adds Units that are not apart of the list of indexed units if they touch the platform
	for (var i = 0; i < ds_list_size(unit_list); i++) {
		var temp_unit = ds_list_find_value(unit_list, i);
		if (ds_list_find_index(units, temp_unit) == -1) {
			if (temp_unit.y <= y and temp_unit.y_velocity >= 0) {
				ds_list_add(temp_unit.platform_list, id);
				ds_list_add(units, temp_unit);
			}
		}
	}
}
ds_list_destroy(unit_list);

// Update Unit List
for (var i = 0; i < ds_list_size(units); i++) {
	var temp_unit = ds_list_find_value(units, i);
	
	if (!instance_exists(temp_unit)) {
		ds_list_delete(units, ds_list_find_index(units, temp_unit));
	}
	else if (temp_unit.y > y + 1) {
		ds_list_delete(temp_unit.platform_list, ds_list_find_index(temp_unit.platform_list, id));
		ds_list_delete(units, ds_list_find_index(units, temp_unit));
	}
}

// Enemy Collision Check
var enemy_list = ds_list_create();
var enemy_num = collision_rectangle_list(x, y - 10, x + sprite_width, y, oEnemy, false, true, enemy_list, false);
if (enemy_num > 0) {
	// Adds Units that are not apart of the list of indexed units if they touch the platform
	for (var i = 0; i < ds_list_size(enemy_list); i++) {
		var temp_enemy = ds_list_find_value(enemy_list, i);
		if (ds_list_find_index(enemies, temp_enemy) == -1) {
			if (temp_enemy.y <= y and temp_enemy.y_velocity >= 0) {
				ds_list_add(temp_enemy.platform_list, id);
				ds_list_add(enemies, temp_enemy);
			}
		}
	}
}
ds_list_destroy(enemy_list);

// Update Enemy List
for (var i = 0; i < ds_list_size(enemies); i++) {
	var temp_enemy = ds_list_find_value(enemies, i);
	
	if (!instance_exists(temp_enemy)) {
		ds_list_delete(enemies, ds_list_find_index(enemies, temp_enemy));
	}
	else if (temp_enemy.y > y + 1) {
		ds_list_delete(temp_enemy.platform_list, ds_list_find_index(temp_enemy.platform_list, id));
		ds_list_delete(enemies, ds_list_find_index(enemies, temp_enemy));
	}
}