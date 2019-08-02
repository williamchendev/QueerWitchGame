/// keyboard_check_letter();
/// @description Returns the letter pressed by the User's keyboard, if the backspace was pressed it returns -1, if no letter was pressed it returns noone
/// @returns {real} Returns the letter pressed by the User's keyboard,  if the backspace was pressed it returns -1, otherwise returns noone

var temp_check_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
var temp_shift = false;

var temp_number = keyboard_check_number();
if (temp_number == -2) {
	return -1;
}
else if (temp_number >= 0) {
	return string(temp_number);
}

if (keyboard_check(vk_shift)) {
	temp_shift = true;
	
	if (keyboard_check_pressed(189)){
		return "_";	
	}
}

for (var i = 1; i <= string_length(temp_check_chars); i++) {
	var temp_char = string_ord_at(temp_check_chars, i);
	if (keyboard_check_pressed(temp_char)) {
		if (temp_shift) {
			return string(chr(temp_char));
		}
		else {
			return string_lower(string(chr(temp_char)));
		}
	}
}

return noone;