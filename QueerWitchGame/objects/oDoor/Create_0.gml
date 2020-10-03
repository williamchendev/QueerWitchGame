/// @description Insert description here
// You can write your code in this editor

// Interact Settings
interact = instance_create_layer(x, y, layer, oInteract);
interact.interact_obj = self;

// Door Settings
door_open = false;

// Animation Settings
door_color = c_teal;

panel_sprite = sDoorPanel;
end_panel_sprite = sDoorEndPanel;
panel_image_index = 0;

// Door Variables
door_value = 1;

door_solid = noone;
door_material = noone;

// Debug
door_timer = 0;