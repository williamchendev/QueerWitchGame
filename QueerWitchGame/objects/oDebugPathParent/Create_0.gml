/// @description Debug Path Parent Init Event
// Creates the Pathfinding System from the Path Nodes in the Room

// Instantiate DS Map
var pathnodes = ds_map_create();
var pathnode_index = ds_map_create();
var pathedge_index = noone;
var delete_nodes = noone;

var temp_pathfinder = instance_create_layer(0, 0, layer_get_id("Solids"), oPathfinder);

// Iterate Through All Nodes
for (var q = 0; q < instance_number(oDebugPath); q++) {
	// Find Node
	var temp_dpath = instance_find(oDebugPath, q);
	delete_nodes[q] = temp_dpath;
	
	// Index Edges
	for (var j = 0; j < array_length_1d(temp_dpath.edges); j++) {
		var temp_edge_index = temp_dpath.edges[j];
		
		// Check if Edge ID exists already
		var temp_index_exists = false;
		for (var i = 0; i < array_length_1d(pathedge_index); i++) {
			if (temp_edge_index == pathedge_index[i]) {
				temp_index_exists = true;
				break;
			}
		}
	
		// Add Edges
		if (temp_index_exists) {
			ds_map_add(pathnode_index, temp_edge_index + "_b", temp_dpath);
		}
		else {
			pathedge_index[array_length_1d(pathedge_index)] = temp_edge_index;
			ds_map_add(pathnode_index, temp_edge_index + "_a", temp_dpath);
		}
	}
}

for (var l = 0; l < array_length_1d(pathedge_index); l++) {
	// Find if Nodes Exist
	var temp_edge_index = pathedge_index[l];
	if (is_undefined(ds_map_find_value(pathnode_index, temp_edge_index + "_a"))) {
		show_debug_message("Missing Node at " + temp_edge_index + "_a");
		continue;
	}
	if (is_undefined(ds_map_find_value(pathnode_index, temp_edge_index + "_b"))) {
		show_debug_message("Missing Node at " + temp_edge_index + "_b");
		continue;
	}
	
	// Get Debug Nodes
	var temp_dnode_a = ds_map_find_value(pathnode_index, temp_edge_index + "_a");
	var temp_dnode_b = ds_map_find_value(pathnode_index, temp_edge_index + "_b");
	
	// Check if Nodes Exist in Room
	if (is_undefined(ds_map_find_value(pathnodes, temp_dnode_a))) {
		var temp_node = instance_create_layer(temp_dnode_a.x, temp_dnode_a.y, layer_get_id("Solids"), oPathNode);
		temp_pathfinder.nodes[array_length_1d(temp_pathfinder.nodes)] = temp_node;
		ds_map_add(pathnodes, temp_dnode_a, temp_node);
	}
	if (is_undefined(ds_map_find_value(pathnodes, temp_dnode_b))) {
		var temp_node = instance_create_layer(temp_dnode_b.x, temp_dnode_b.y, layer_get_id("Solids"), oPathNode);
		temp_pathfinder.nodes[array_length_1d(temp_pathfinder.nodes)] = temp_node;
		ds_map_add(pathnodes, temp_dnode_b, temp_node);
	}
	
	// Check for Debug Node Jump Variables
	var temp_edge_jump = false;
	for (var k = 0; k < array_length_1d(temp_dnode_a.jump_edges); k++) {
		if (temp_dnode_a.jump_edges[k] == temp_edge_index) {
			temp_edge_jump = true;
			break;
		}
	}
	if (!temp_edge_jump) {
		for (var k = 0; k < array_length_1d(temp_dnode_b.jump_edges); k++) {
			if (temp_dnode_b.jump_edges[k] == temp_edge_index) {
				temp_edge_jump = true;
				break;
			}
		}
	}
	
	// Check for Debug Node Teleport Variables
	var temp_edge_teleport = false;
	for (var k = 0; k < array_length_1d(temp_dnode_a.teleport_edges); k++) {
		if (temp_dnode_a.teleport_edges[k] == temp_edge_index) {
			temp_edge_teleport = true;
			break;
		}
	}
	if (!temp_edge_teleport) {
		for (var k = 0; k < array_length_1d(temp_dnode_b.teleport_edges); k++) {
			if (temp_dnode_b.teleport_edges[k] == temp_edge_index) {
				temp_edge_teleport = true;
				break;
			}
		}
	}
	
	// Establish Nodes & Edge
	var temp_node_a = ds_map_find_value(pathnodes, temp_dnode_a);
	var temp_node_b = ds_map_find_value(pathnodes, temp_dnode_b);
	var temp_edge = instance_create_layer(lerp(temp_node_a.x, temp_node_b.x, 0.5), lerp(temp_node_a.y, temp_node_b.y, 0.5), layer_get_id("Solids"), oPathEdge);
	temp_node_a.edges[array_length_1d(temp_node_a.edges)] = temp_edge;
	temp_node_b.edges[array_length_1d(temp_node_b.edges)] = temp_edge;
	temp_edge.nodes[0] = temp_node_a;
	temp_edge.nodes[1] = temp_node_b;
	temp_edge.jump = temp_edge_jump;
	temp_edge.teleport = temp_edge_teleport;
	temp_edge.distance = point_distance(temp_node_a.x, temp_node_a.y, temp_node_b.x, temp_node_b.y);
}

// Destroy Debug Nodes
for (var q = array_length_1d(delete_nodes) - 1; q >= 0; q--) {
	instance_destroy(delete_nodes[q]);
}

// Destroy Data Structures
ds_map_destroy(pathnodes);
ds_map_destroy(pathnode_index);

pathnodes = -1;
pathnode_index = -1;

instance_destroy();