extends Sprite

var item

func _ready():
	pass
	
func init(item):
	var extents = Vector2(item.get_width() * 0.665 / 2, item.get_height() * 0.8 / 2)
	
	self.item = item
	texture = item.get_texture()
	
	find_node("CollisionShape2D").shape.extents = extents

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("mouse_left"):
		InputHandler._on_item_scene_clicked(item)