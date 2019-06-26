/// mouse_room_y();
/// @description Returns the y coordinate of the mouse cursor within the room
/// @returns {real} Returns the y coordinate of the mouse within the room

var camera = view_camera[0];
var cam_height = camera_get_view_height(camera);
var cam_y = camera_get_view_y(camera);
return cam_y + device_mouse_raw_y(0) * (cam_height/window_get_height());