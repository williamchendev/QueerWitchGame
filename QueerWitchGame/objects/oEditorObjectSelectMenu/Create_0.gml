/// @description Insert description here
// You can write your code in this editor

// Settings
expanded = false;

sub_menus = noone;
sub_menus[0] = instance_create_layer(x, y, layer, oEditorSolidsBracket);
sub_menus[0].visible = expanded;

sub_menus[1] = instance_create_layer(x, y + 17, layer, oEditorTileSetBracket);
sub_menus[1].visible = expanded;

sub_menus[2] = instance_create_layer(x, y + 17, layer, oEditorTileSetBracket);
sub_menus[2].visible = expanded;

backing = instance_create_layer(x, y, layer, oEditorObjectMenuBacking);

scroll_spd = 16;

// Variables
scroll = 0;