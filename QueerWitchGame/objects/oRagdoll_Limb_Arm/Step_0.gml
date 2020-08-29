/// @description Ragdoll Arm Update Event
// Ragdoll Arm Positioning Freeze Timer Behaviour

// Inherit the parent event
event_inherited();

// Timer Behaviour
if (timer > 0) {
	timer -= global.deltatime;
	if (timer <= 0) {
		phy_fixed_rotation = false;
	}
}