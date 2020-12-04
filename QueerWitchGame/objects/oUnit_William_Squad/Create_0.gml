/// @description Insert description here
// You can write your code in this editor

event_inherited();

// Animation Settings
idle_animation = sWilliam_Idle;
walk_animation = sWilliam_Run;
jump_animation = sWilliam_Jump;
aim_animation = sWilliam_Aim;
aim_walk_animation = sWilliam_Aim_Walk;
hurt_animation = sWilliam_Hurt;

limb_sprite[0] = sWilliam_Arms;
limb_sprite[1] = sWilliam_Arms;

// Ragdoll Settings
ragdoll = true;
ragdoll_head_sprite = sWilliam_Head;
ragdoll_arm_left_sprite = sWilliam_Arms;
ragdoll_arm_right_sprite = sWilliam_Arms;
ragdoll_chest_top_sprite = sWilliamDS_ChestTop;
ragdoll_chest_bot_sprite = sWilliamDS_ChestBot;
ragdoll_leg_left_sprite = sWilliamDS_LeftLeg;
ragdoll_leg_right_sprite = sWilliamDS_RightLeg;