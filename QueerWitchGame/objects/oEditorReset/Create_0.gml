/// @description Editor Reset Init
// Resets the Editor to a blank slate

// Delete Objects
if (instance_exists(oEditorObjectSelectMenu)) {
	with (oEditorObjectSelectMenu) {
		instance_destroy();
	}
	with (oEditorObjectMenuBacking) {
		instance_destroy();
	}
	with (oEditorObjectBracket) {
		instance_destroy();
	}
	with (oEditorObjectSelect) {
		instance_destroy();
	}
}

if (instance_exists(oEditorUtilBar)) {
	with (oEditorUtilBar) {
		instance_destroy();
	}
	with (oEditorButton) {
		instance_destroy();
	}
}

if (instance_exists(oEditorRibbon)) {
	with (oEditorRibbon) {
		instance_destroy();
	}
}

if (instance_exists(oTileset)) {
	with (oTileset) {
		instance_destroy();
	}
}

if (instance_exists(oEditorObject)) {
	with (oEditorObject) {
		instance_destroy();
	}
}

// Reset Editor
if (instance_exists(oEditor)) {
	oEditor.editor_mode = editortypes.start;

	oEditor.editor_click = true;
	oEditor.editor_delete = false;
	oEditor.editor_tools = noone;
	oEditor.editor_ribbon = noone;
	oEditor.editor_objects = noone;
	oEditor.editor_cursor = -1;
	
	oEditor.block_tileset_index = 0;
	oEditor.block_tileset = noone;
	
	oEditor.x = 0;
	oEditor.y = 0;
	
	event_perform_object(oEditor, ev_step_begin, 0);
}

// Delete Self
instance_destroy();