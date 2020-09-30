/// @description Weapon Update
// Calculates the behaviour of the weapon object

// Click Check
if (click) {
	var temp_attack = attack;
	if (click_old) {
		attack = false;
	}
	click_old = temp_attack;
}