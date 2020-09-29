/// @description Insert description here
// You can write your code in this editor

// Draw Variables
var temp_door_x = round(x);
var temp_door_y = round(y);
var temp_door_width = max(door_close_width, abs(door_value * door_open_width)) * sign(door_value);
var temp_door_height = door_height / 2;

// Debug
draw_set_color(c_white);
draw_rectangle(temp_door_x, temp_door_y - temp_door_height, temp_door_x + temp_door_width, temp_door_y + temp_door_height, false);