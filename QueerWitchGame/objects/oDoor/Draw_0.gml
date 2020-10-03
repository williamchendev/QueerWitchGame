/// @description Insert description here
// You can write your code in this editor

// Draw Variables

draw_sprite_ext(end_panel_sprite, panel_image_index, x, y, -1, 1, 0, door_color, 1);
draw_sprite_ext(panel_sprite, panel_image_index, x, y, door_value, 1, 0, door_color, 1);
draw_sprite_ext(end_panel_sprite, panel_image_index, x + (door_value * sprite_get_width(panel_sprite)), y, 1, 1, 0, door_color, 1);