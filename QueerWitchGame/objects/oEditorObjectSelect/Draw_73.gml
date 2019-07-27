/// @description Insert description here
// You can write your code in this editor

var hover_alpha = max(hover, 0.6);
if (selected) {
	draw_set_alpha(0.6);
	draw_rectangle(x - 18, y - 18, x + 17, y + 17, false);
	draw_set_alpha(1);
	hover_alpha = 1;
}
draw_sprite_stretched_ext(button_image, 0, x - 16, y - 16, 32, 32, c_white, hover_alpha);