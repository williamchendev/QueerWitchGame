/// @description Ragdoll Knockout Draw Event
// Draws the Ragdoll Knockout Effect

// Draw Knockout Effect
if (instance_exists(oKnockout)) {
	shader_set(shd_black);
	draw_self();
	shader_reset();
}