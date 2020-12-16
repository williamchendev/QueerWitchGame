/// @description Unit Update Event
// Performs calculations necessary for the Unit's behaviour

// Teleport Behaviour
if (teleport) {
	x += teleport_x;
	y += teleport_y;
	teleport = false;
}

// Movement (Player Input)
if (canmove) {
	// Horizontal Movement
	var temp_spd = spd;
	if (key_aim_press or reload) {
		temp_spd = walk_spd;
	}
	
	if (key_left) {
		x_velocity = -temp_spd;
	}
	else if (key_right) {
		x_velocity = temp_spd;
	}
	else {
		x_velocity = 0;
	}
	
	// Vertical Movement (Jumping)
	if (key_jump) {
		if (!platform_free(x, y + 1, platform_list)) {
			// First Jump
			y_velocity = 0;
			y_velocity -= jump_spd;
			jump_velocity = hold_jump_spd;
			double_jump = true;
			
			// Squash and Stretch
			draw_xscale = 1 - squash_stretch;
			draw_yscale = 1 + squash_stretch;
		}
		else if (key_jump_press) {
			// Second Jump
			if (double_jump) {
				y_velocity = 0;
				y_velocity -= double_jump_spd;
				jump_velocity = hold_jump_spd;
				double_jump = false;
				
				// Squash and Stretch
				draw_xscale -= squash_stretch;
				draw_yscale += squash_stretch;
			}
		}
		else if (y_velocity < 0) {
			// Variable Jump Height
			y_velocity -= jump_velocity * global.deltatime;
			jump_velocity *= power(jump_decay, global.deltatime);
		}
	}
	
	// Jumping Down (Platforms)
	if (key_down_press) {
		if (place_free(x, y + 1) and !platform_free(x, y + 1, platform_list)) {
			y += 1;
			y_velocity += 0.05;
		}
	}
}

// Physics
if (platform_free(x, y + 1, platform_list)) {
	//Gravity
	grav_velocity += (grav_spd * global.deltatime);
	grav_velocity *= power(grav_multiplier, global.deltatime);
	grav_velocity = min(grav_velocity, max_grav_spd);
	y_velocity += (grav_velocity * global.deltatime);
}
else {
	grav_velocity = 0;
}
	
// Delta Time
var temp_x_velocity = x_velocity * global.deltatime;
var temp_y_velocity = y_velocity * global.deltatime;

var hspd = 0
if (temp_x_velocity != 0) {
	// Horizontal Collisions
	if (place_free(x + temp_x_velocity, y)) {
		// Move Unit with horizontal velocity
		hspd += temp_x_velocity;
		
		// Downward Slope collision check
		if (temp_y_velocity == 0) {
			if (!place_free(x + temp_x_velocity, y + slope_tolerance)) {
				var prev_slope_y = 0;
				for (var i = 0.5; i <= abs(slope_tolerance); i += 0.5) {
					if (!place_free(x + temp_x_velocity, y + (sign(slope_tolerance) * i))) {
						y += sign(slope_tolerance) * prev_slope_y;
						action_target_y += sign(slope_tolerance) * prev_slope_y;
						break;
					}
					prev_slope_y = i;
				}
			}
		}
	}
	else {
		// Upward Slope collision check
		if (!place_free(x, y + 1) && place_free(x + temp_x_velocity, y - slope_tolerance)) {
			for (var i = 0; i <= abs(slope_tolerance); i += 0.5) {
				if (place_free(x + temp_x_velocity, y - (sign(slope_tolerance) * i))) {
					hspd += temp_x_velocity;
					y -= sign(slope_tolerance) * i;
					action_target_y -= sign(slope_tolerance) * i;
					break;
				}
			}
		}
		else {
			// Stop Unit momentum with Collision
			for (var i = abs(temp_x_velocity); i > 0; i -= 0.5) {
				if (place_free(x + (i * sign(x_velocity)), y)) {
					hspd += i * sign(x_velocity);
					break;
				}
			}
			x_velocity = 0;
		}
	}
}

var vspd = 0;
if (temp_y_velocity != 0) {
	// Vertical Collisions
	if (platform_free(x, y + temp_y_velocity, platform_list)) {
		vspd += temp_y_velocity;
	}
	else {
		for (var i = abs(temp_y_velocity); i > 0; i -= 0.5) {
			if (platform_free(x, y + (i * sign(y_velocity)), platform_list)) {
				vspd += i * sign(y_velocity);
				break;
			}
		}
		
		// Squash and Stretch
		if (y_velocity > 0) {
			draw_xscale = 1 + squash_stretch;
			draw_yscale = 1 - squash_stretch;
		}

		y_velocity = 0;
	}
}

x += hspd;
y += vspd;
if (action != noone) {
	action_target_x += hspd;
	action_target_y += vspd;
}

// Animation
var anim_spd_sign = 1;
draw_xscale = lerp(draw_xscale, 1, scale_reset_spd * global.deltatime);
draw_yscale = lerp(draw_yscale, 1, scale_reset_spd * global.deltatime);

if (x_velocity != 0) {
	if (!draw_set_xscale_manual) {
		// Set Sprite facing direction
		image_xscale = sign(x_velocity);
	}
}
draw_set_xscale_manual = false;

if (!platform_free(x, y + 1, platform_list)) {
	// Set Unit ground Animation
	if (x_velocity != 0) {
		if (!key_aim_press and !reload) {
			sprite_index = walk_animation;
		}
		else if (canmove) {
			sprite_index = aim_walk_animation;
			if (!reload) {
				if (image_xscale != sign(x_velocity)) {
					anim_spd_sign = -1;
				}
			}
		}
	}
	else {
		if (key_aim_press and canmove and !reload) {
			sprite_index = aim_animation;
		}
		else {
			sprite_index = idle_animation;
		}
	}
	
	// Set Unit Image Index
	draw_index += (animation_spd * anim_spd_sign) * global.deltatime;
	while (draw_index > sprite_get_number(sprite_index)) {
		draw_index -= sprite_get_number(sprite_index);
	}
	while (draw_index < 0) {
		draw_index += sprite_get_number(sprite_index);
	}
	image_index = clamp(floor(draw_index), 0, sprite_get_number(sprite_index) - 1);
	
	// Slope Angles
	var slope_solid_obj = collision_line(x, y, x, y + 5, oSolid, false, false);
	if (slope_solid_obj != noone) {
		slope_angle = lerp(slope_angle, slope_solid_obj.image_angle, slope_angle_lerp_spd * global.deltatime);
		slope_offset = 0;
		if (slope_solid_obj.image_angle != 0) {
			slope_offset = slope_tolerance;
		}
	}
	else {
		slope_angle = lerp(slope_angle, 0, slope_angle_lerp_spd * global.deltatime);
		slope_offset = 0;
	}
	draw_angle = slope_angle;
}
else {
	// Set Jump Animation
	sprite_index = jump_animation;
	if (y_velocity < -jump_peak_threshold) {
		image_index = 0;
	}
	else if (y_velocity > jump_peak_threshold) {
		image_index = 2;
	}
	else {
		image_index = 1;
	}
	
	// Slope Angles
	slope_angle = lerp(slope_angle, 0, slope_angle_lerp_spd * global.deltatime);
	slope_offset = 0;
	draw_angle = slope_angle;
}

// Hitbox
var temp_sprite_index = sprite_index;
var temp_object_x_scale = draw_xscale * image_xscale;
var temp_object_y_scale = draw_yscale * image_yscale;

var temp_bbox_left = sprite_get_bbox_left(temp_sprite_index) * temp_object_x_scale;
var temp_bbox_right = sprite_get_bbox_right(temp_sprite_index) * temp_object_x_scale;
var temp_bbox_top = sprite_get_bbox_top(temp_sprite_index) * temp_object_y_scale;
var temp_bbox_bottom = sprite_get_bbox_bottom(temp_sprite_index) * temp_object_y_scale;
	
temp_bbox_left -= sprite_get_xoffset(temp_sprite_index) * temp_object_x_scale;
temp_bbox_bottom -= sprite_get_yoffset(temp_sprite_index) * temp_object_y_scale;
temp_bbox_right -= sprite_get_xoffset(temp_sprite_index) * temp_object_x_scale;
temp_bbox_top -= sprite_get_yoffset(temp_sprite_index) * temp_object_y_scale;
	
var temp_point1_dis = point_distance(0, 0, temp_bbox_left, temp_bbox_top);
var temp_point1_angle = point_direction(0, 0, temp_bbox_left, temp_bbox_top);
var temp_point2_dis = point_distance(0, 0, temp_bbox_right, temp_bbox_top);
var temp_point2_angle = point_direction(0, 0, temp_bbox_right, temp_bbox_top);
var temp_point3_dis = point_distance(0, 0, temp_bbox_right, temp_bbox_bottom);
var temp_point3_angle = point_direction(0, 0, temp_bbox_right, temp_bbox_bottom);
var temp_point4_dis = point_distance(0, 0, temp_bbox_left, temp_bbox_bottom);
var temp_point4_angle = point_direction(0, 0, temp_bbox_left, temp_bbox_bottom);
	
var temp_left_top_x_offset = lengthdir_x(temp_point1_dis, temp_point1_angle + draw_angle);
var temp_left_top_y_offset = lengthdir_y(temp_point1_dis, temp_point1_angle + draw_angle);
var temp_right_top_x_offset = lengthdir_x(temp_point2_dis, temp_point2_angle + draw_angle);
var temp_right_top_y_offset = lengthdir_y(temp_point2_dis, temp_point2_angle + draw_angle);
var temp_right_bottom_x_offset = lengthdir_x(temp_point3_dis, temp_point3_angle + draw_angle);
var temp_right_bottom_y_offset = lengthdir_y(temp_point3_dis, temp_point3_angle + draw_angle);
var temp_left_bottom_x_offset = lengthdir_x(temp_point4_dis, temp_point4_angle + draw_angle);
var temp_left_bottom_y_offset = lengthdir_y(temp_point4_dis, temp_point4_angle + draw_angle);
				
hitbox_left_top_x_offset = min(temp_left_top_x_offset, temp_right_top_x_offset, temp_right_bottom_x_offset, temp_left_bottom_x_offset);
hitbox_right_bottom_x_offset = max(temp_left_top_x_offset, temp_right_top_x_offset, temp_right_bottom_x_offset, temp_left_bottom_x_offset);
hitbox_left_top_y_offset = min(temp_left_top_y_offset, temp_right_top_y_offset, temp_right_bottom_y_offset, temp_left_bottom_y_offset);
hitbox_right_bottom_y_offset = max(temp_left_top_y_offset, temp_right_top_y_offset, temp_right_bottom_y_offset, temp_left_bottom_y_offset);	

// Interact Behaviour
interact_collision_list = noone;
if (canmove and interact_active) {
	var temp_interact_list = ds_list_create();
	var temp_interact_number = collision_rectangle_list(x + hitbox_left_top_x_offset - interact_reach, y + hitbox_left_top_y_offset - interact_reach, x + hitbox_right_bottom_x_offset + interact_reach, y + hitbox_right_bottom_y_offset + interact_reach, oInteract, false, true, temp_interact_list, true);
	for (var i = 0; i < temp_interact_number; i++) {
		var temp_interact_object = ds_list_find_value(temp_interact_list, i);
		if (temp_interact_object.active and temp_interact_object.interact_unit == noone) {
			interact_collision_list[i] = temp_interact_object;
		}
	}
	ds_list_destroy(temp_interact_list);
}

// Death & Ragdoll
if (health_points <= 0) {
	sprite_index = hurt_animation;
	
	// Ragdoll
	if (ragdoll) {
		// Establish Ragdoll Sprite Array
		var temp_ragdoll_sprites = noone;
		temp_ragdoll_sprites[0] = ragdoll_head_sprite;
		temp_ragdoll_sprites[1] = ragdoll_arm_left_sprite;
		temp_ragdoll_sprites[2] = ragdoll_arm_right_sprite;
		temp_ragdoll_sprites[3] = ragdoll_chest_top_sprite;
		temp_ragdoll_sprites[4] = ragdoll_chest_bot_sprite;
		temp_ragdoll_sprites[5] = ragdoll_leg_left_sprite;
		temp_ragdoll_sprites[6] = ragdoll_leg_right_sprite;
	
		// Instantiate Ragdoll and the Ragdoll Limbs Array
		var temp_ragdoll_limbs = create_ragdoll(x, y, image_xscale, layer_get_id("Instances"), temp_ragdoll_sprites);
	
		// Move Arms
		with (temp_ragdoll_limbs[2]) {
			phy_fixed_rotation = true;
			phy_rotation = -90 - other.arm_left_angle_1;
		}
		with (temp_ragdoll_limbs[1]) {
			phy_fixed_rotation = true;
			phy_rotation = -90 - other.arm_left_angle_2;
		}
		
		with (temp_ragdoll_limbs[6]) {
			phy_fixed_rotation = true;
			phy_rotation = -90 - other.arm_right_angle_1;
		}
		with (temp_ragdoll_limbs[5]) {
			phy_fixed_rotation = true;
			phy_rotation = -90 - other.arm_right_angle_2;
		}
	
		// Apply Ragdoll Forces
		if (force_applied) {
			for (var i = 0; i < array_length_1d(temp_ragdoll_limbs); i++) {
				if (collision_circle(force_x, force_y, 3, temp_ragdoll_limbs[i], false, true)) {
					with(temp_ragdoll_limbs[i]) {
						physics_apply_impulse(other.force_x, other.force_y, other.force_xvector, -other.force_yvector);
					}
				}
			}
		}
		
		ragdoll = false;
	}
	
	// Death Dialogue
	if (death_dialogue) {
		// Check Dialogue Exists
		var temp_death_dialogue_exists = false;
		for (var l = 0; l < instance_number(oTextBox); l++) {
			var temp_textbox_inst = instance_find(oTextBox, l);
			if (temp_textbox_inst.unit == self) {
				temp_death_dialogue_exists = true;
				if (death_dialogue_text != noone) {
					temp_textbox_inst.destroy = true;
					temp_death_dialogue_exists = false;
				}
				break;
			}
		}
		
		// Create Death Dialogue
		if ((!temp_death_dialogue_exists) and ((random(1) < death_dialogue_chance) or (death_dialogue_text != noone))) {
			var temp_death_dialogue = instance_create_layer(x, y, layer_get_id("Instances"), oTextBox);
			
			if (death_dialogue_text != noone) {
				temp_death_dialogue.text = death_dialogue_text;
				temp_death_dialogue.unit = self;
				temp_death_dialogue.interrupt_text_active = false;
			}
			else {
				temp_death_dialogue.text = "...";
				temp_death_dialogue.unit = self;
			}
			
			with (temp_death_dialogue) {
				unit_draw_x = unit.x - (sin(degtorad(unit.draw_angle)) * (unit.hitbox_right_bottom_y_offset - unit.hitbox_left_top_y_offset));
				unit_draw_y = unit.y - (unit.hitbox_right_bottom_y_offset - unit.hitbox_left_top_y_offset) - (unit.stats_y_offset * unit.draw_yscale);
				x = unit_draw_x;
				y = unit_draw_y;
			}
		}
	}
}

// Reset Force Applied
force_applied = false;