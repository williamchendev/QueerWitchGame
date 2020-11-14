/// @description Insert description here
// You can write your code in this editor

// Iterate Through All Teleport Objects
for (var q = instance_number(oDebugTeleport) - 1; q >= 0; q--) {
	// Find This Teleport
	var temp_dteleport = instance_find(oDebugTeleport, q);
	
	// Compare against all other Teleport Objects
	for (var j = 0; j < instance_number(oDebugTeleport); j++) {
		// Find Compare Teleport
		var temp_dteleportcompare = instance_find(oDebugTeleport, j);
		
		// Check against each other
		if (instance_exists(temp_dteleportcompare)) {
			if (temp_dteleport != temp_dteleportcompare) {
				if (temp_dteleport.teleport_id == temp_dteleportcompare.teleport_id) {
					// Create Teleport Objects
					var temp_teleport_a = instance_create_layer(temp_dteleport.x, temp_dteleport.y, temp_dteleport.layer, temp_dteleport.teleport_obj);
					var temp_teleport_b = instance_create_layer(temp_dteleportcompare.x, temp_dteleportcompare.y, temp_dteleportcompare.layer, temp_dteleportcompare.teleport_obj);
				
					// Set Teleport Objects
					temp_teleport_a.teleport_obj = temp_teleport_b;
					temp_teleport_b.teleport_obj = temp_teleport_a;
				
					// Delete Teleport Object
					instance_destroy(temp_dteleport);
					
					break;
				}
			}
		}
	}
}

// Garbage Collection
with (oDebugTeleport) {
	instance_destroy();
}
instance_destroy();