extends Sprite

var item

func _ready():
	pass
	
func init(item):
	var extents = Vector2(item.get_width() * 0.665 / 2, item.get_height() * 0.8 / 2)
	
	self.item = item
	texture = item.get_texture()
	
	find_node("CollisionShape2D").shape.extents = extents

# Going the long way because _on_Area2D_input_event is not working properly.
func _input(event):
	if event is InputEventMouseButton:
		if (event.button_index == BUTTON_LEFT && 
			!event.pressed && 
			Global.is_mouse_over(position, get_global_mouse_position(), texture.get_size())):
			InputHandler._on_item_scene_clicked(item)