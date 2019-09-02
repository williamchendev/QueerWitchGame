/// editorData();
/// @description Establishes the global variables for all Editor GameObject Values

global.editor_data_categories = 9;
global.editor_data_categories_length = 1000;

global.editor_data = noone;
for (var i = 0; i < (global.editor_data_categories * global.editor_data_categories_length); i++) {
	global.editor_data[i, 0] = noone;
}

/********************/
/* Solids [0 - 999] */
/********************/
global.editor_data[0, 0] = oSolid;
global.editor_data[0, 1] = sDebugSolid;
global.editor_data[0, 2] = "An invisible physics collider";

global.editor_data[1, 0] = oSolidRotation;
global.editor_data[1, 1] = sDebugSolidRotation;
global.editor_data[1, 2] = "An invisible collider with a precise rotatable collider";

global.editor_data[2, 0] = oPlatform;
global.editor_data[2, 1] = sDebugPlatform;
global.editor_data[2, 2] = "An invisible platform that entities can drop down from";

/**************************/
/* Tilesets [1000 - 1999] */
/**************************/
i = global.editor_data_categories_length;
global.editor_data[i, 0] = sDebugTileSet;

global.editor_data[i + 1, 0] = sDebugTileSet;

/*************************/
/* Objects [2000 - 2999] */
/*************************/
i = global.editor_data_categories_length * 2;
global.editor_data[i, 0] = oDebugUnit;
global.editor_data[i, 1] = sCathIdle;
global.editor_data[i, 2] = "A Player Character Entity made for debugging";
global.editor_data[i, 3] = 24;
global.editor_data[i, 4] = 48;

global.editor_data[i + 1, 0] = oSolidRotation;
global.editor_data[i + 1, 1] = sDebugSolidRotation;
global.editor_data[i + 1, 2] = "";

global.editor_data[i + 2, 0] = oPlatform;
global.editor_data[i + 2, 1] = sDebugPlatform;
global.editor_data[i + 2, 2] = "";

global.editor_data[i + 3, 0] = oPlatform;
global.editor_data[i + 3, 1] = sDebugPlatform;
global.editor_data[i + 3, 2] = "";

global.editor_data[i + 4, 0] = oPlatform;
global.editor_data[i + 4, 1] = sDebugPlatform;
global.editor_data[i + 4, 2] = "";

global.editor_data[i + 5, 0] = oPlatform;
global.editor_data[i + 5, 1] = sDebugPlatform;
global.editor_data[i + 5, 2] = "";

global.editor_data[i + 6, 0] = oPlatform;
global.editor_data[i + 6, 1] = sDebugPlatform;
global.editor_data[i + 6, 2] = "";

global.editor_data[i + 7, 0] = oPlatform;
global.editor_data[i + 7, 1] = sDebugPlatform;
global.editor_data[i + 7, 2] = "";

global.editor_data[i + 8, 0] = oPlatform;
global.editor_data[i + 8, 1] = sDebugPlatform;
global.editor_data[i + 8, 2] = "";

global.editor_data[i + 9, 0] = oPlatform;
global.editor_data[i + 9, 1] = sDebugPlatform;
global.editor_data[i + 9, 2] = "";