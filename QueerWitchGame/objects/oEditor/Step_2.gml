/// @description Level Editor Late Update Event
// Places Tiles and Objects from the selected Menu in the Level Editor

// Editor Mode Behaviours
if (editor_mode == editortypes.block) {
	// Check if Editor was clicked and viable
	if (editor_click) {
		// Check if Editor Options was selected
		if (editor_objects.expanded) {
			if (mouse_room_x() < oGameManager.camera_x + 117) {
				return;
			}
		}
		
		// Snap Variables
		var temp_snap_x = floor(mouse_room_x() / 48);
		var temp_snap_y = floor(mouse_room_y() / 48);
		
		// Editor Tool Type Behaviour
		if (editor_tools.util_type == 0) {
			// Selection Tool Selected
			var temp_select_obj = noone;
			if (mouse_check_button_pressed(mb_left)) {
				// Set Editor Object Selected
				var temp_object_list = ds_list_create();
				var temp_editor_object_num = instance_position_list(mouse_room_x(), mouse_room_y(), oEditorObject, temp_object_list, true);
				if (temp_editor_object_num == 1) {
					// Select Single OEditorObject
					temp_select_obj = ds_list_find_value(temp_object_list, 0);
				}
				else if (temp_editor_object_num > 0) {
					// Go through selected
					var temp_select_index = -1;
					for (var i = 0; i < temp_editor_object_num; i++) {
						var temp_object_single = ds_list_find_value(temp_object_list, i);
						if (temp_object_single.selected) {
							temp_select_index = i;
							break;
						}
					}
					
					// Make sure the selected index is not out of range
					if (temp_select_index == temp_editor_object_num - 1) {
						temp_select_index = -1;
					}
					
					// Set new Selected Object
					temp_select_obj = ds_list_find_value(temp_object_list, temp_select_index + 1);
				}
				ds_list_destroy(temp_object_list);
				
				// Reset all Editor Object Selection
				with (oEditorObject) {
					selected = false;
				}
				// Set new Selected Object
				if (temp_select_obj != noone) {
					temp_select_obj.selected = true;
				}
			}
		}
		else {
			if (editor_tools.util_type == 1) {
				// Move Tool Selected
				
				// Skip Resetting Editor Objects
				return;
			}
			else if (editor_tools.util_type == 2) {
				// Draw Tool Selected
				if (editor_objects.selected_menu == 1) {
					// Tileset Selected
					if (mouse_check_button(mb_left)) {
						// Check if within bounds of the editor block
						if (mouse_room_x() >= 0 and mouse_room_x() < (block_width * 48)) {
							if (mouse_room_y() >= 0 and mouse_room_y() < (block_height * 48)) {
								// Set the Tile
								tilesetSet(block_tileset, temp_snap_x, temp_snap_y, editor_objects.selected_index - 1);
							}
						}
					}
				}
				else if (editor_objects.selected_menu != -1) {
					// Objects Selected
					var temp_obj_x = 0;
					var temp_obj_y = 0;
				
					// Check if Object has offset from Editor Data
					var temp_obj_x_offset = 0;
					var temp_obj_y_offset = 0;
					if (array_length_2d(global.editor_data, (editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index) >= 4) {
						temp_obj_x_offset = global.editor_data[(editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index, 2];
						temp_obj_y_offset = global.editor_data[(editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index, 3];
					}
				
					// Check if Editor is in the Draw Snap mode
					if (editor_snap) {
						temp_obj_x = temp_obj_x_offset + (temp_snap_x * 48);
						temp_obj_y = temp_obj_y_offset + (temp_snap_y * 48);
					}
					else {
						temp_obj_x = mouse_room_x();
						temp_obj_y = mouse_room_y();
					}
				
					// Draw Object
					if (mouse_check_button_pressed(mb_left)) {
						// Check if Object Already Exists at Cursor
						if (editor_snap) {
							var temp_can_place = true;
							mask_index = global.editor_data[(editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index, 1];
					
							var temp_object_list = ds_list_create();
							var temp_object_num = instance_place_list(temp_obj_x, temp_obj_y, oEditorObject, temp_object_list, false);
							if (temp_object_num > 0) { 
								for (var i = 0; i < temp_object_num; i++) {
									var temp_object_single = ds_list_find_value(temp_object_list, i);
									if (temp_object_single.object_editor_id == (editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index) {
										temp_can_place = false;
										break;
									}
								}
							}
					
							mask_index = sDebugSolid;
							ds_list_destroy(temp_object_list);
							if (!temp_can_place) {
								return;
							}
						}
					
						// Create Object
						var temp_object = instance_create_layer(temp_obj_x, temp_obj_y, layer_get_id("Instances"), oEditorObject);
						temp_object.mask_index = global.editor_data[(editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index, 1];
						temp_object.sprite_index = global.editor_data[(editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index, 1];
						temp_object.object_editor_id = (editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index;
						
						temp_object.object_ui = instance_create_layer(temp_obj_x, temp_obj_y, layer_get_id("Object_UI"), oEditorObjectUI);
						temp_object.object_ui.editor_object = temp_object;
					
						// Check which Object Type to set new Object
						var temp_object_type = "Object";
						if (editor_objects.selected_menu == 0) {
							temp_object_type = "Solid";
							temp_object.object_show_name = false;
						}
						temp_object.object_type = temp_object_type;
					}
				}
			}
			else if (editor_tools.util_type == 3) {
				// Erase Tool Selected
				if (editor_delete) {
					if (!mouse_check_button(mb_left)) {
						editor_delete = false;
					}
					else {
						return;
					}
				}
			
				// Erase Object
				if (mouse_check_button_pressed(mb_left)) {
					var temp_object_list = ds_list_create();
					var temp_object_num = instance_position_list(mouse_room_x(), mouse_room_y(), oEditorObject, temp_object_list, true);
					if (temp_object_num > 0) { 
						var temp_object_single = ds_list_find_value(temp_object_list, 0);
						instance_destroy(temp_object_single);
						ds_list_destroy(temp_object_list);
						editor_delete = true;
						return;
					}
					ds_list_destroy(temp_object_list);
				}
			
				// Erase Tileset
				if (mouse_check_button(mb_left)) {
					// Check if within bounds of the editor block
					if (mouse_room_x() >= 0 and mouse_room_x() < (block_width * 48)) {
						if (mouse_room_y() >= 0 and mouse_room_y() < (block_height * 48)) {
							// Reset the Tile
							tilesetSet(block_tileset, temp_snap_x, temp_snap_y, -1);
						}
					}
				}
			}
		
			// Reset all Editor Object Selection
			with (oEditorObject) {
				selected = false;
			}
		}
	}
}