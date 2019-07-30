/// @description Main Object Menu Init
// Manages all the sub menus that contain objects to select for the Level Editor

// Settings
expanded = false;

scroll_spd = 16;

// Variables
scroll = 0;

selected = false;
selected_menu = -1;
selected_index = -1;
selected_text = noone;

// Sub Menus
sub_menus = noone;
sub_menus[0] = instance_create_layer(x, y, layer, oEditorSolidsBracket);
sub_menus[0].visible = expanded;

sub_menus[1] = instance_create_layer(x, y, layer, oEditorTileSetBracket);
sub_menus[1].visible = expanded;

sub_menus[2] = instance_create_layer(x, y, layer, oEditorObjectBracket2);
sub_menus[2].visible = expanded;

// Background
backing = instance_create_layer(x, y, layer, oEditorObjectMenuBacking);