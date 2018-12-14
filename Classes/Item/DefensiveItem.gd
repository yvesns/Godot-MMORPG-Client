extends "res://Classes/Item/Item.gd"

#Database attribute
var armour

func _ready():
	pass
	
func get_armour():
	return armour
	
func set_armour(armour):
	self.armour = armour
	
func serialize():
	var serialized_item = .serialize()
	serialized_item.armour = self.armour
	
	return serialized_item
	
func deserialize(item):
	.deserialize(item)
	
	armour = item.armour