/// @description Ragdoll Parent Instantiation Event
// Creates all variables necessary for the ragdoll parent object

// Instantiate Limb Variables
facing_direction = 1;

head_offset = 4;
arm_offset = 5;
leg_offset = 3;
arm_ground_dis = (sprite_get_bbox_bottom(arms_left_sprite) - sprite_get_yoffset(arms_left_sprite));
chest_ground_dis = (sprite_get_bbox_bottom(chest_sprite) - sprite_get_yoffset(chest_sprite));
leg_ground_dis = (sprite_get_bbox_bottom(legs_left_sprite) - sprite_get_yoffset(legs_left_sprite));
chest_top_dis = (sprite_get_yoffset(chest_sprite) - sprite_get_bbox_top(chest_sprite)) + chest_ground_dis + (leg_ground_dis * 2);

var temp_leg_rotate_forward = 90;
var temp_leg_rotate_back = -45;
if (facing_direction == -1) {
	var temp_leg_rotate_forward = 45;
	var temp_leg_rotate_back = -90;

	var temp_leg_sprite = legs_right_sprite;
	legs_right_sprite = legs_left_sprite;
	legs_left_sprite = temp_leg_sprite;
	
	var temp_arm_sprite = arms_right_sprite;
	arms_right_sprite = arms_left_sprite;
	arms_left_sprite = temp_arm_sprite;
}

// Instantiate Limbs & Bodyparts
ragdoll_head_obj = instance_create_layer(x, y - chest_top_dis - head_offset, layer, oRagdoll_Limb_Head);
ragdoll_head_obj.sprite_index = head_sprite;
ragdoll_head_obj.image_xscale = facing_direction;

ragdoll_arm1bot_obj = instance_create_layer(x - (arm_offset * facing_direction), y - chest_top_dis + arm_ground_dis, layer, oRagdoll_Limb_Arm);
ragdoll_arm1bot_obj.sprite_index = arms_left_sprite;
ragdoll_arm1bot_obj.image_index = 1;
ragdoll_arm1bot_obj.image_xscale = -facing_direction;

ragdoll_arm1top_obj = instance_create_layer(x - (arm_offset * facing_direction), y - chest_top_dis, layer, oRagdoll_Limb_Arm);
ragdoll_arm1top_obj.sprite_index = arms_left_sprite;
ragdoll_arm1top_obj.image_index = 0;
ragdoll_arm1top_obj.image_xscale = -facing_direction;

ragdoll_chest_obj = instance_create_layer(x, y - (chest_ground_dis + (leg_ground_dis * 2)), layer, oRagdoll_Limb_Chest);
ragdoll_chest_obj.sprite_index = chest_sprite;
ragdoll_chest_obj.image_xscale = facing_direction;

ragdoll_arm2bot_obj = instance_create_layer(x + (arm_offset * facing_direction), y - chest_top_dis + arm_ground_dis, layer, oRagdoll_Limb_Arm);
ragdoll_arm2bot_obj.sprite_index = arms_right_sprite;
ragdoll_arm2bot_obj.image_index = 1;
ragdoll_arm2bot_obj.image_xscale = -facing_direction;

ragdoll_arm2top_obj = instance_create_layer(x + (arm_offset * facing_direction), y - chest_top_dis, layer, oRagdoll_Limb_Arm);
ragdoll_arm2top_obj.sprite_index = arms_right_sprite;
ragdoll_arm2top_obj.image_index = 0;
ragdoll_arm2top_obj.image_xscale = -facing_direction;

ragdoll_leftleg1_obj = instance_create_layer(x - leg_offset, y - (leg_ground_dis * 2), layer, oRagdoll_Limb_Leg);
ragdoll_leftleg1_obj.sprite_index = legs_left_sprite;
ragdoll_leftleg1_obj.image_index = 0;
ragdoll_leftleg1_obj.image_xscale = facing_direction;

ragdoll_rightleg1_obj = instance_create_layer(x + leg_offset, y - (leg_ground_dis * 2), layer, oRagdoll_Limb_Leg);
ragdoll_rightleg1_obj.sprite_index = legs_right_sprite;
ragdoll_rightleg1_obj.image_index = 0;
ragdoll_rightleg1_obj.image_xscale = facing_direction;

ragdoll_leftleg2_obj = instance_create_layer(x - leg_offset, y - leg_ground_dis, layer, oRagdoll_Limb_Leg);
ragdoll_leftleg2_obj.sprite_index = legs_left_sprite;
ragdoll_leftleg2_obj.image_index = 1;
ragdoll_leftleg2_obj.image_xscale = facing_direction;

ragdoll_rightleg2_obj = instance_create_layer(x + leg_offset, y - leg_ground_dis, layer, oRagdoll_Limb_Leg);
ragdoll_rightleg2_obj.sprite_index = legs_right_sprite;
ragdoll_rightleg2_obj.image_index = 1;
ragdoll_rightleg2_obj.image_xscale = facing_direction;


//ragdoll_head_obj = instance_create_layer(x, y, layer, oRagdoll_Limb_Head);
//ragdoll_head_obj.sprite_index = head_sprite;

// Instantiate Joints between Limbs
physics_joint_revolute_create(ragdoll_head_obj, ragdoll_chest_obj, ragdoll_head_obj.x, ragdoll_head_obj.y, -45, 45, 1, 0, 0, 0, 0); 

physics_joint_revolute_create(ragdoll_arm1top_obj, ragdoll_chest_obj, ragdoll_arm1top_obj.x, ragdoll_arm1top_obj.y, 0, 0, 0, 0, 0, 0, 0);
physics_joint_revolute_create(ragdoll_arm1bot_obj, ragdoll_arm1top_obj, ragdoll_arm1bot_obj.x, ragdoll_arm1bot_obj.y, 0, 0, 0, 0, 0, 0, 0);

physics_joint_revolute_create(ragdoll_arm2top_obj, ragdoll_chest_obj, ragdoll_arm2top_obj.x, ragdoll_arm2top_obj.y, 0, 0, 0, 0, 0, 0, 0);
physics_joint_revolute_create(ragdoll_arm2bot_obj, ragdoll_arm2top_obj, ragdoll_arm2bot_obj.x, ragdoll_arm2bot_obj.y, 0, 0, 0, 0, 0, 0, 0);

physics_joint_revolute_create(ragdoll_leftleg1_obj, ragdoll_chest_obj, ragdoll_leftleg1_obj.x, ragdoll_leftleg1_obj.y, temp_leg_rotate_back, temp_leg_rotate_forward, 1, 0, 0, 0, 0);
physics_joint_revolute_create(ragdoll_rightleg1_obj, ragdoll_chest_obj, ragdoll_rightleg1_obj.x, ragdoll_rightleg1_obj.y, temp_leg_rotate_back, temp_leg_rotate_forward, 1, 0, 0, 0, 0);
//show_debug_message(string(-(22.5 + (facing_direction * 22.5))));
//show_debug_message(string((22.5 + (facing_direction * -22.5))));

physics_joint_revolute_create(ragdoll_leftleg2_obj, ragdoll_leftleg1_obj, ragdoll_leftleg2_obj.x, ragdoll_leftleg2_obj.y, -(75 + (facing_direction * 75)), (75 + (facing_direction * -75)), 1, 0, 0, 0, 0);
physics_joint_revolute_create(ragdoll_rightleg2_obj, ragdoll_rightleg1_obj, ragdoll_rightleg2_obj.x, ragdoll_rightleg2_obj.y, -(75 + (facing_direction * 75)), (75 + (facing_direction * -75)), 1, 0, 0, 0, 0);