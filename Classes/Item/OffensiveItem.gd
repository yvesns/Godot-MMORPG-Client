extends "res://Classes/Item/Item.gd"

#Database attributes
var min_damage
var max_damage

func _ready():
	pass
	
func get_min_damage():
	return min_damage

func set_min_damage(min_damage):
	self.min_damage = min_damage
	
func get_max_damage():
	return max_damage
	
func set_max_damage(max_damage):
	self.max_damage = max_damage
	
func serialize():
	var serialized_item = .serialize()
	serialized_item.min_damage = self.min_damage
	serialized_item.max_damage = self.max_damadge
	
	return serialized_item
	
func deserialize(item):
	.deserialize(item)
	
	min_damage = item.min_damage
	max_damage = item.max_damage