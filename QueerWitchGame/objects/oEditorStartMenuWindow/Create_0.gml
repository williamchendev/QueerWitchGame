/// @description Start Menu Window
// Returns the Game to the Editor Start Menu

// Return to Start Menu
event_perform_object(oEditor, ev_create, 0);
room_goto(rLevelEditor);
instance_destroy();