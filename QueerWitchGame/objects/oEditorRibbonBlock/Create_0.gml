/// @description Editor Ribbon Block Init
// Initializes the variables of the Block Editor Ribbon

// Inherit the parent variables
event_inherited();

// Ribbon Titles
ribbon_names[0] = "File";
ribbon_names[1] = "Block";
ribbon_names[2] = "Level";
ribbon_names[3] = "Demo";
ribbon_names[4] = "Settings";
ribbon_names[5] = "Help";

// Ribbon Options
ribbon_options[0, 0] = "New File";
ribbon_options[0, 1] = "Open File";
ribbon_options[0, 2] = "Save File   [Ctrl+S]";
ribbon_options[0, 3] = "Save As File   [Ctrl+Shft+S]";
ribbon_options[0, 4] = "Return to Editor Menu";

ribbon_options[1, 0] = "You're outta touch";
ribbon_options[1, 1] = "But I'm";
ribbon_options[1, 2] = "Outta";
ribbon_options[1, 3] = "My Head";
ribbon_options[1, 4] = "when";
ribbon_options[1, 5] = "you're";
ribbon_options[1, 6] = "not";
ribbon_options[1, 7] = "around";

ribbon_options[2, 0] = "Paint";

ribbon_options[3, 0] = "Paint";
ribbon_options[3, 1] = "It";
ribbon_options[3, 2] = "Black";

// Ribbon Actions
ribbon_actions[0, 0] = oEditorNewBlockWindow;
ribbon_actions[0, 1] = noone;
ribbon_actions[0, 2] = oEditorSaveBlockWindow;
ribbon_actions[0, 3] = noone;
ribbon_actions[0, 4] = oEditorStartMenuWindow;