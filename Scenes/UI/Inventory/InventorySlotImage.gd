extends Control

func _ready():
	find_node("TextureRect").rect_size = Vector2(Global.inventory_slot_size, Global.inventory_slot_size)
	
func set_texture(texture):
	find_node("TextureRect").texture = texture