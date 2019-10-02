/// createEmptyInventory(width,height);
/// @description Creates an empty inventory from the given width and height and returns the object id
/// @param {integer} width The given width of the Inventory Array
/// @param {integer} height The given height of the Inventory Array
/// @returns {real} id of the empty inventory object

// Creates Inventory Game Object
var temp_inventory_obj = instance_create_layer(0, 0, layer_get_id("Foreground_Instances"), oUnitInventory);

// Creates Inventory Array
var inven_width = argument0;
var inven_height = argument1;

var temp_inventory;
var temp_inventory_stacks;
for (var h = 0; h < inven_height; h++) {
	for (var w = 0; w < inven_width; w++) {
		temp_inventory[w, h] = 0;
		temp_inventory_stacks[w, h] = 0;
	}
}

// Assigns inventory data to inventory object
temp_inventory_obj.inventory = temp_inventory;
temp_inventory_obj.inventory_stacks = temp_inventory_stacks;
temp_inventory_obj.inventory_width = inven_width;
temp_inventory_obj.inventory_height = inven_height;

// Returns empty inventory game object
return temp_inventory_obj;