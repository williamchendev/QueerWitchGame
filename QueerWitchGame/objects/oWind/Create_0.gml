/// @description Wind Physics Initialization

// Create Physics Object
physics_object = instance_create_layer(x, y, layer, oPhysics);
physics_object.base_object = self;
physics_object.physics_weight = 0.2;

// Room data
width = room_width;
offset = 64;