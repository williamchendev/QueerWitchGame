/// @description Game Manager Initialization

// Singleton Function
if (instance_number(object_index) > 1) {
	instance_destroy();
	exit;
}
persistent = true;

// System Settings
data_directory = string(program_directory +"\Data\\");

// Level Generation Data
generate = false;
blocks = noone;

// Global Item Data
itemData();
consumableData();
weaponData();

// Debug Settings
global.debug = false;
sprite_index = noone;

debug_x_offset = 4;
debug_y_offset = 0;

// Player Input Management
up_check = vk_up;
down_check = vk_down;
left_check = vk_left;
right_check = vk_right;

select_check = ord("Z");
cancel_check = ord("X");
menu_check = ord("C");

// Time Settings
time_spd = 1;
global.deltatime = 0;

stop_time = false; //DEBUG

// Camera Variables
camera_width = 480;
camera_height = 270;
camera_x = 0;
camera_y = 0;