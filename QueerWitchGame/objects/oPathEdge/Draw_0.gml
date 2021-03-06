/// @description Debug Edge Draw Event
// Draws Debug info on the Edge Object

if (!global.debug) {
	return;
}

if (nodes[0] != noone and nodes[1] != noone) {
	draw_line(nodes[0].x, nodes[0].y, nodes[1].x, nodes[1].y);
	drawTextOutline(x, y, c_white, c_black, string(distance));
	if (jump) {
		drawTextOutline(x, y + 11, c_white, c_black, "[Jump]");
		draw_rectangle(nodes[0].x - 5, nodes[0].y - 5, nodes[0].x + 5, nodes[0].y + 5, false);
		draw_rectangle(nodes[1].x - 5, nodes[1].y - 5, nodes[1].x + 5, nodes[1].y + 5, false);
	}
	if (teleport) {
		drawTextOutline(x, y + 11, c_white, c_black, "[Teleport]");
		draw_rectangle(nodes[0].x - 5, nodes[0].y - 5, nodes[0].x + 5, nodes[0].y + 5, false);
		draw_rectangle(nodes[1].x - 5, nodes[1].y - 5, nodes[1].x + 5, nodes[1].y + 5, false);
	}
}