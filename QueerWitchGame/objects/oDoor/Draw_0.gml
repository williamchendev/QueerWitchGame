/// @description Insert description here
// You can write your code in this editor

// Draw Variables
var temp_draw_val_1 = cos(door_value * 0.5 * pi);
var temp_draw_val_2 = sin(door_value * 0.5 * pi);
draw_sprite_ext(panel_sprite, panel_image_index, x - (sign(door_value) * (sprite_get_width(end_panel_sprite) / 2)), y, temp_draw_val_2, 1, 0, door_color, 1);
draw_sprite_ext(end_panel_sprite, panel_image_index, x + (temp_draw_val_2 * sprite_get_width(panel_sprite)) - (door_value * (sprite_get_width(end_panel_sprite) / 2)), y, temp_draw_val_1, 1, 0, door_color, 1);

// Draw Material
event_perform_object(door_material, ev_draw, 0);