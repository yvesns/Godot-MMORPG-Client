extends "res://Classes/Item/Item.gd"

func _ready():
	pass
	
func init():
	name = "Test item"
	inventory_slot_width = 2
	inventory_slot_height = 3
	texture = load(Global.paths["TestItem.png"])