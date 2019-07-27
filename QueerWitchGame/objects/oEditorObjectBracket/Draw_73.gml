/// @description Insert description here
// You can write your code in this editor

draw_set_font(fHeartBit);
draw_rectangle(x, y, x + 107, y + 10, false);
if (expanded) {
	draw_rectangle(x, y + (height * 36) + 15, x + 107, y + (height * 36) + 17, false);
}
else {
	draw_rectangle(x, y + 15, x + 107, y + 17, false);
}
drawTextOutline(x + 3, y - 3, c_white, c_black, bar_name);

if (hover_text != noone) {
	draw_set_font(fHeartBit);
	drawTextOutline(mouse_room_x() + 6, mouse_room_y() - 16, c_white, c_black, hover_text);
}