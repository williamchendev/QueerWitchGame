/// create_ragdoll(x,y,image_xscale,layer,limb_sprites, head_offset, arm_offset, leg_offset);
/// @description Creates a Ragdoll Physics Object from given variables
/// @param {real} x The x position of the ragdoll to create (center bottom of ragdoll)
/// @param {real} y The y position of the ragdoll to create (center bottom of ragdoll)
/// @param {real} image_xscale The xscale direction of the ragdoll (1 facing right, -1 facing left)
/// @param {real} temp_layer The temp_layer to create the ragdoll
/// @param {array} limb_sprites An array of the limb sprites
/// @param {real} head_offset How far to place the head relative to the bounding box on the chest (Y axis)
/// @param {real} arm_offset How far to place the arms relative to the top corners of the chest bounding box (X axis)
/// @param {real} leg_offset How far to place the legs relative to the bottom corners of the chest bounding box (X axis)
/// @returns {array} An array of the limb objects in the ragdoll object

// Establish Variables
var temp_x = argument[0];
var temp_y = argument[1];
var temp_image_xscale = argument[2];
var temp_layer = argument[3];

var temp_sprites = argument[4];
var head_sprite = temp_sprites[0];
var arms_left_sprite = temp_sprites[1];
var arms_right_sprite = temp_sprites[2];
var chest_top_sprite = temp_sprites[3];
var chest_bot_sprite = temp_sprites[4];
var legs_left_sprite = temp_sprites[5];
var legs_right_sprite = temp_sprites[6];

var head_offset = -4;
var arm_offset = 5;
var leg_offset = 3;
if (argument_count > 5) {
	head_offset = argument[5];
	arm_offset = argument[6];
	leg_offset = argument[7];
}

// Instantiate Limb Variables
var arm_bbox_height = (sprite_get_bbox_bottom(arms_left_sprite) - sprite_get_yoffset(arms_left_sprite));
var leg_bbox_height = (sprite_get_bbox_bottom(legs_left_sprite) - sprite_get_yoffset(legs_left_sprite));
var chest_bbox_top_height = (sprite_get_yoffset(chest_top_sprite) - sprite_get_bbox_top(chest_top_sprite));
var chest_bbox_center_height = (sprite_get_bbox_bottom(chest_top_sprite) - sprite_get_yoffset(chest_top_sprite)) + (sprite_get_yoffset(chest_bot_sprite) - sprite_get_bbox_top(chest_bot_sprite));
var chest_bbox_bot_height = (sprite_get_bbox_bottom(chest_bot_sprite) - sprite_get_yoffset(chest_bot_sprite));

var chest_top_height = (leg_bbox_height * 2) + chest_bbox_bot_height + chest_bbox_center_height + chest_bbox_top_height;

var temp_leg_rotate_forward = 90;
var temp_leg_rotate_back = -45;
if (temp_image_xscale == -1) {
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
var temp_limbs = noone;

var ragdoll_head_obj = instance_create_layer(temp_x, temp_y - chest_top_height + head_offset, temp_layer, oRagdoll_Limb_Head);
ragdoll_head_obj.sprite_index = head_sprite;
ragdoll_head_obj.image_xscale = temp_image_xscale;
temp_limbs[0] = ragdoll_head_obj;

var ragdoll_arm1bot_obj = instance_create_layer(temp_x - (arm_offset * temp_image_xscale), temp_y - chest_top_height + arm_bbox_height, temp_layer, oRagdoll_Limb_Arm);
ragdoll_arm1bot_obj.sprite_index = arms_left_sprite;
ragdoll_arm1bot_obj.image_index = 1;
ragdoll_arm1bot_obj.image_xscale = -temp_image_xscale;
temp_limbs[1] = ragdoll_arm1bot_obj;

var ragdoll_arm1top_obj = instance_create_layer(temp_x - (arm_offset * temp_image_xscale), temp_y - chest_top_height, temp_layer, oRagdoll_Limb_Arm);
ragdoll_arm1top_obj.sprite_index = arms_left_sprite;
ragdoll_arm1top_obj.image_index = 0;
ragdoll_arm1top_obj.image_xscale = -temp_image_xscale;
temp_limbs[2] = ragdoll_arm1top_obj;

var ragdoll_chest_top_obj = instance_create_layer(temp_x, temp_y - chest_top_height + chest_bbox_top_height, temp_layer, oRagdoll_Limb_Chest);
ragdoll_chest_top_obj.sprite_index = chest_top_sprite;
ragdoll_chest_top_obj.image_xscale = temp_image_xscale;
temp_limbs[3] = ragdoll_chest_top_obj;

var ragdoll_chest_bot_obj = instance_create_layer(temp_x, temp_y - chest_top_height + chest_bbox_top_height + chest_bbox_center_height, temp_layer, oRagdoll_Limb_Chest);
ragdoll_chest_bot_obj.sprite_index = chest_bot_sprite;
ragdoll_chest_bot_obj.image_xscale = temp_image_xscale;
temp_limbs[4] = ragdoll_chest_bot_obj;

var ragdoll_leftleg1_obj = instance_create_layer(temp_x - leg_offset, temp_y - (leg_bbox_height * 2), temp_layer, oRagdoll_Limb_Leg);
ragdoll_leftleg1_obj.sprite_index = legs_left_sprite;
ragdoll_leftleg1_obj.image_index = 0;
ragdoll_leftleg1_obj.image_xscale = temp_image_xscale;
temp_limbs[7] = ragdoll_leftleg1_obj;

var ragdoll_rightleg1_obj = instance_create_layer(temp_x + leg_offset, temp_y - (leg_bbox_height * 2), temp_layer, oRagdoll_Limb_Leg);
ragdoll_rightleg1_obj.sprite_index = legs_right_sprite;
ragdoll_rightleg1_obj.image_index = 0;
ragdoll_rightleg1_obj.image_xscale = temp_image_xscale;
temp_limbs[8] = ragdoll_rightleg1_obj;

var ragdoll_leftleg2_obj = instance_create_layer(temp_x - leg_offset, temp_y - leg_bbox_height, temp_layer, oRagdoll_Limb_Leg);
ragdoll_leftleg2_obj.sprite_index = legs_left_sprite;
ragdoll_leftleg2_obj.image_index = 1;
ragdoll_leftleg2_obj.image_xscale = temp_image_xscale;
temp_limbs[9] = ragdoll_leftleg2_obj;

var ragdoll_rightleg2_obj = instance_create_layer(temp_x + leg_offset, temp_y - leg_bbox_height, temp_layer, oRagdoll_Limb_Leg);
ragdoll_rightleg2_obj.sprite_index = legs_right_sprite;
ragdoll_rightleg2_obj.image_index = 1;
ragdoll_rightleg2_obj.image_xscale = temp_image_xscale;
temp_limbs[10] = ragdoll_rightleg2_obj;

var ragdoll_arm2bot_obj = instance_create_layer(temp_x + (arm_offset * temp_image_xscale), temp_y - chest_top_height + arm_bbox_height, temp_layer, oRagdoll_Limb_Arm);
ragdoll_arm2bot_obj.sprite_index = arms_right_sprite;
ragdoll_arm2bot_obj.image_index = 1;
ragdoll_arm2bot_obj.image_xscale = -temp_image_xscale;
temp_limbs[5] = ragdoll_arm2bot_obj;

var ragdoll_arm2top_obj = instance_create_layer(temp_x + (arm_offset * temp_image_xscale), temp_y - chest_top_height, temp_layer, oRagdoll_Limb_Arm);
ragdoll_arm2top_obj.sprite_index = arms_right_sprite;
ragdoll_arm2top_obj.image_index = 0;
ragdoll_arm2top_obj.image_xscale = -temp_image_xscale;
temp_limbs[6] = ragdoll_arm2top_obj;

// Instantiate Joints between Limbs
physics_joint_revolute_create(ragdoll_head_obj, ragdoll_chest_top_obj, ragdoll_head_obj.x, ragdoll_head_obj.y, -45, 45, 1, 0, 0, 0, 0); 

physics_joint_revolute_create(ragdoll_arm1top_obj, ragdoll_chest_top_obj, ragdoll_arm1top_obj.x, ragdoll_arm1top_obj.y, 0, 0, 0, 0, 0, 0, 0);
physics_joint_revolute_create(ragdoll_arm1bot_obj, ragdoll_arm1top_obj, ragdoll_arm1bot_obj.x, ragdoll_arm1bot_obj.y, -(75 + (-temp_image_xscale * 75)), (75 + (temp_image_xscale * 75)), 1, 0, 0, 0, 0);

physics_joint_revolute_create(ragdoll_arm2top_obj, ragdoll_chest_top_obj, ragdoll_arm2top_obj.x, ragdoll_arm2top_obj.y, 0, 0, 0, 0, 0, 0, 0);
physics_joint_revolute_create(ragdoll_arm2bot_obj, ragdoll_arm2top_obj, ragdoll_arm2bot_obj.x, ragdoll_arm2bot_obj.y, -(75 + (-temp_image_xscale * 75)), (75 + (temp_image_xscale * 75)), 1, 0, 0, 0, 0);

physics_joint_revolute_create(ragdoll_chest_top_obj, ragdoll_chest_bot_obj, ragdoll_chest_top_obj.x, ragdoll_chest_top_obj.y + (chest_bbox_center_height / 2), -20, 20, 1, 0, 0, 0, 0);

physics_joint_revolute_create(ragdoll_leftleg1_obj, ragdoll_chest_bot_obj, ragdoll_leftleg1_obj.x, ragdoll_leftleg1_obj.y, temp_leg_rotate_back, temp_leg_rotate_forward, 1, 0, 0, 0, 0);
physics_joint_revolute_create(ragdoll_rightleg1_obj, ragdoll_chest_bot_obj, ragdoll_rightleg1_obj.x, ragdoll_rightleg1_obj.y, temp_leg_rotate_back, temp_leg_rotate_forward, 1, 0, 0, 0, 0);

physics_joint_revolute_create(ragdoll_leftleg2_obj, ragdoll_leftleg1_obj, ragdoll_leftleg2_obj.x, ragdoll_leftleg2_obj.y, -(75 + (temp_image_xscale * 75)), (75 + (temp_image_xscale * -75)), 1, 0, 0, 0, 0);
physics_joint_revolute_create(ragdoll_rightleg2_obj, ragdoll_rightleg1_obj, ragdoll_rightleg2_obj.x, ragdoll_rightleg2_obj.y, -(75 + (temp_image_xscale * 75)), (75 + (temp_image_xscale * -75)), 1, 0, 0, 0, 0);

// Return Limb Array
return temp_limbs;
