extends Node

var item_name
var texture
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