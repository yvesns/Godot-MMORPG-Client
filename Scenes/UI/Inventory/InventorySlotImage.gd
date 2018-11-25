extends Control

var item = null

func _ready():
	find_node("TextureRect").rect_size = Vector2(Global.inventory_slot_size, Global.inventory_slot_size)
	
func set_item(item):
	self.item = item
	find_node("TextureRect").texture = item.get_texture()
	
func get_area():
	return find_node("Area2D")
	
func get_area_shape():
	return find_node("CollisionShape2D").get_shape()
	
func _gui_input(event):
	if item == null:
		return
		
	if event is InputEventMouseButton:
		if (event.button_index == BUTTON_LEFT && 
			!event.pressed && 
			Global.is_mouse_over(
				get_rect().position, 
				get_global_mouse_position(), 
				find_node("TextureRect").texture.get_size()
			)):
			InputHandler._on_inventory_item_clicked(item)