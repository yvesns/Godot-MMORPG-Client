extends TextureRect

var item = null
var root_slot = null
var slots = []
var destroyed = false

func _ready():
	pass
	
func init(item, root_slot):
	self.item = item
	self.root_slot = root_slot
	
	texture = item.get_texture()
	
func get_area():
	return find_node("Area2D")
	
func get_area_shape():
	return find_node("CollisionShape2D").get_shape()
	
func get_item():
	return item
	
func _input(event):
	if item == null:
		return
		
	if event is InputEventMouseButton:
		if (event.button_index == BUTTON_LEFT &&
			!event.pressed &&
			!destroyed &&
			Global.is_mouse_over(
				get_rect().position, 
				get_global_mouse_position(), 
				texture.get_size()
			)):
			InputHandler._on_inventory_item_clicked(self, root_slot)
			
func add_slot(slot):
	slots.append(slot)
	
func get_slots():
	return slots
	
func set_destroyed():
	destroyed = true