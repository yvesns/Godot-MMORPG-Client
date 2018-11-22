extends Control

func _ready():
	find_node("TextureRect").rect_size = Vector2(Global.inventory_slot_size, Global.inventory_slot_size)
	
func set_item(item):
	var width = Global.inventory_slot_size * item.inventory_slot_width
	var height = Global.inventory_slot_size * item.inventory_slot_height
	
	find_node("TextureRect").texture = item.get_texture()
	set_CollisionShape2D_size(Vector2(width, height))
	
func set_CollisionShape2D_size(size):
	find_node("CollisionShape2D").get_shape().set_extents(size)
	
func get_area():
	return find_node("Area2D")