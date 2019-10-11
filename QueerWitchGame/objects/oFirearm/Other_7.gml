/// @description Reset Animation
// Resets the reload animation

if (weapon_sprite == reload_sprite) {
	weapon_sprite = regular_sprite;
	image_index = 0;
	image_speed = sprite_get_speed(regular_sprite);
}