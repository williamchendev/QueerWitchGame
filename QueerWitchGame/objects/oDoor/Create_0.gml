/// @description Insert description here
// You can write your code in this editor

// Interact Settings
interact = instance_create_layer(x, y, layer, oInteract);
interact.interact_obj = self;

// Door Settings
door_open = true;

door_friction = 0.90;
door_slam_delay = 1.2;
door_slam_friction = 0.7;
door_lerp_close_spd = 0.23;

door_kick_velocity = 0.19;

door_collider_value = 0.6;
door_collider_offset = 2;

// Animation Settings
door_color = c_teal;

panel_sprite = sDoorPanel;
end_panel_sprite = sDoorEndPanel;
panel_image_index = 0;

// Door Variables
door_value = 0;

door_velocity = 0;
door_slam_timer = 0;
door_slam_velocity = 0;
door_min = -1;
door_max = 1;

door_touched = false;

// Instance Variables
door_solid_active = true;
door_material_active = true;
door_solid = instance_create_layer(x, y, layer_get_id("Solids"), oSolid);
door_material = instance_create_layer(x, y, layer_get_id("Solids"), oMaterial);
door_solid.sprite_index = end_panel_sprite;
door_solid.visible = false;
door_material.sprite_index = end_panel_sprite;
door_material.material_sprite = end_panel_sprite;
door_material.material_team_id = "unassigned";
//door_material.visible = false;

// Door Solid Fixture
door_solid_fix = physics_fixture_create();
physics_fixture_set_polygon_shape(door_solid_fix);
physics_fixture_add_point(door_solid_fix, sprite_get_width(end_panel_sprite) / 2, 0);
physics_fixture_add_point(door_solid_fix, -sprite_get_width(end_panel_sprite) / 2, 0);
physics_fixture_add_point(door_solid_fix, -sprite_get_width(end_panel_sprite) / 2, -sprite_get_height(end_panel_sprite));
physics_fixture_add_point(door_solid_fix, sprite_get_width(end_panel_sprite) / 2, -sprite_get_height(end_panel_sprite));

physics_fixture_set_density(door_solid_fix, 0);
physics_fixture_set_restitution(door_solid_fix, 0.1);
physics_fixture_set_collision_group(door_solid_fix, 0);
physics_fixture_set_linear_damping(door_solid_fix, 0.1);
physics_fixture_set_angular_damping(door_solid_fix, 0.1);
physics_fixture_set_friction(door_solid_fix, 0.2);
physics_fixture_bind(door_solid_fix, door_solid);
physics_fixture_delete(door_solid_fix);