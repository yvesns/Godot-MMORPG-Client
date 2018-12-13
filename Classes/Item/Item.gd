extends Node

enum State {IN_INVENTORY, ON_GROUND, ON_CURSOR}

var texture
var state

#Database attributes
var item_id
var item_name
var item_class
var item_type
var item_rarity
var item_options
var inventory_slot_width = 0
var inventory_slot_height = 0

func _ready():
	pass
	
func is_stackable():
	return false
	
func get_texture():
	return texture
	
func set_texture(texture):
	self.texture = texture
	
func get_id():
	return item_id
	
func set_id(item_id):
	self.item_id = item_id
	
func get_name():
	return item_name
	
func set_name(item_name):
	self.item_name = item_name
	
func get_class():
	return item_class
	
func set_class(item_class):
	self.item_class = item_class
	
func get_type():
	return item_type
	
func set_type(item_type):
	self.item_type = item_type
	
func get_rarity():
	return item_rarity
	
func set_rarity(item_rarity):
	self.item_rarity = item_rarity
	
func get_inventory_width():
	return inventory_slot_width
	
func set_inventory_width(inventory_slot_width):
	self.inventory_slot_width = inventory_slot_width
	
func get_inventory_height():
	return inventory_slot_height
	
func set_inventory_height(inventory_slot_height):
	self.inventory_slot_height = inventory_slot_height
	
func get_width():
	return Global.inventory_slot_size * inventory_slot_width
	
func get_height():
	return Global.inventory_slot_size * inventory_slot_height
	
func get_slot_count():
	return inventory_slot_width * inventory_slot_height