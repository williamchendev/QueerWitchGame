/// @description Editor Start Menu Destroy
// Destroys the start menu and all the buttons within it

for (var i = 0; i < array_length_1d(buttons); i++) {
	instance_destroy(buttons[i]);
}