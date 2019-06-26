/// mouse_room_x();
/// @description Returns the x coordinate of the mouse cursor within the room
/// @returns {real} Returns the x coordinate of the mouse within the room

var camera = view_camera[0];
var cam_width = camera_get_view_width(camera);
var cam_x = camera_get_view_x(camera);
return (cam_x + device_mouse_raw_x(0) * (cam_width / window_get_width()));