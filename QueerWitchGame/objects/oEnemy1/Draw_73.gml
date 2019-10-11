/// @description Draw Enemy UI Event
// Draws the enemy's UI to the screen

// Health Bar
draw_set_font(fNormalFont);
draw_set_halign(fa_center);
drawTextOutline(x, y - 28, c_white, c_black, "HP: " + string(hp) + "/4");

if (hp <= 0) {
	instance_destroy();	
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);