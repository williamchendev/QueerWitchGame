/// @description Editor Start Menu Init
// Initializes all the variables and properties of the level editor start menu

// Settings
menu_name = "Queer Witch Level Editor v0.24";

// Variables
x = oGameManager.camera_x;
y = oGameManager.camera_y;

menu_pause = false;

// Buttons
buttons = noone;

play_demo = instance_create_layer(x + 14, y + 34, layer, oEditorStartMenuButton);
play_demo.button_name = "Play Demo";
buttons[0] = play_demo;

new_level = instance_create_layer(x + 14, y + 52, layer, oEditorStartMenuButton);
new_level.button_name = "New Level";
buttons[1] = new_level;

open_level = instance_create_layer(x + 14, y + 70, layer, oEditorStartMenuButton);
open_level.button_name = "Open Level";
buttons[2] = open_level;

new_block = instance_create_layer(x + 14, y + 88, layer, oEditorStartMenuButton);
new_block.button_name = "New Block";
buttons[3] = new_block;

open_block = instance_create_layer(x + 14, y + 106, layer, oEditorStartMenuButton);
open_block.button_name = "Open Block";
buttons[4] = open_block;

// Debug
sprite_index = noone;