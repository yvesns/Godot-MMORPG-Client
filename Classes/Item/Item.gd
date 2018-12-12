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
	
func get_width():
	return Global.inventory_slot_size * inventory_slot_width
	
func get_height():
	return Global.inventory_slot_size * inventory_slot_height
	
func get_slot_count():
	return inventory_slot_width * inventory_slot_height
	
func serialize():
	return JSON.print(self, "", true)
	
func deserialize(json_item):
	pass