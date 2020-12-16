/// @description Insert description here
// You can write your code in this editor

event_inherited();

door_color = c_white;

panel_sprite = sCornfields_Construct_DoorPanel;
end_panel_sprite = sCornfields_Construct_DoorEndPanel;

door_solid.sprite_index = end_panel_sprite;
door_material.sprite_index = end_panel_sprite;
door_material.material_sprite = end_panel_sprite;