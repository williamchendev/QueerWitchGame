/// @description Insert description here
// You can write your code in this editor

// Cutscene Trigger Behaviour
if (!cutscene_enabled) {
	if (place_meeting(x, y, oUnitPlayer)) {
		cutscene_enabled = true;
	}
}

// Inherit the parent event
event_inherited();