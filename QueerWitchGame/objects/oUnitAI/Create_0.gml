/// @description Unit AI Initialization
// The variable and settings initialization for the Unit AI

// Inherit the parent event
event_inherited();

// Ai Behaviour Settings
ai_hunt = true;
ai_command = false;
ai_follow = false;

// AI Inspect Settings
ai_inspect_radius = 48;

// Ai Follow Settings
ai_follow_start_radius = 72;
ai_follow_stop_radius = 64;

ai_follow_combat_endure_time = 40;

// Ai Follow Variables
ai_follow_unit = noone;
ai_follow_active = false;
ai_follow_combat_timer = 0;

// Ai Path Variables
ai_pathing_delay = 10;
ai_pathing_timer = 0;