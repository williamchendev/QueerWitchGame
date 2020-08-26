/// @description Insert description here
// You can write your code in this editor

if (mouse_check_button(mb_left)) {
	var temp_node = instance_nearest(mouse_x, mouse_y, oPathNode);
	if (path_rand_start < 0) {
		path_rand_start = irandom(array_length_1d(nodes) - 1);
	}
	path = pathfind_get_path(noone, temp_node, nodes[path_rand_start]);
}