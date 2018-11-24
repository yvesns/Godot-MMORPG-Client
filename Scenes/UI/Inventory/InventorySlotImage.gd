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

func _on_TextureRect_gui_input(event):
	if item == null:
		return
		
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && !event.pressed:
			InputHandler._on_inventory_item_clicked(item)