extends "res://Classes/Item/Item.gd"

func _ready():
	name = "Test item"
	inventory_slot_width = 2
	inventory_slot_height = 3
	
	create_texture(Global.paths["TestItem.png"])