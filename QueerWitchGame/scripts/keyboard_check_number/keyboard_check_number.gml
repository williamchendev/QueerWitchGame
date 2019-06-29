/// keyboard_check_number();
/// @description Returns the number pressed by the User's keyboard, if the backspace was pressed it returns -2, if no number was pressed it returns -1
/// @returns {real} Returns the number pressed by the User's keyboard,  if the backspace was pressed it returns -2, otherwise returns -1

for (var i = 0; i <= 9; i++) {
	if (keyboard_check_pressed(ord(string(i)))) {
		return i;
	}
}

if (keyboard_check_pressed(vk_backspace)) {
	return -2;
}

return -1;