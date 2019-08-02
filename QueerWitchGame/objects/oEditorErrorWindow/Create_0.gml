/// @description Error Window Init
// Creates the settings for the Editor Error Window

// Inherit the parent event
event_inherited();

// Settings
window_title = "Error";

width = 200;
height = 40;

camera_x_offset = (oGameManager.camera_width / 2) - (width / 2);
camera_y_offset = (oGameManager.camera_height / 2) - (height / 2);

// Error Text
body_text = "";