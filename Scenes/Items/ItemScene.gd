extends Sprite

var item
var is_mouse_over = false

func _ready():
	pass
	
func init(item):
	var extents = Vector2(item.get_width() * 0.665 / 2, item.get_height() * 0.8 / 2)
	
	self.item = item
	texture = item.get_texture()
	
	find_node("CollisionShape2D").shape.extents = extents

# Bugs and not fires at all when over the inventory box.
# Input.is_action_just_pressed seems to fire multiple times sometimes.
func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("mouse_left"):
		InputHandler._on_item_scene_clicked(item)

# Going the long way because _on_Area2D_input_event is not working properly.
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && !event.pressed && is_mouse_over:
			InputHandler._on_item_scene_clicked(item)

func _on_Area2D_mouse_entered():
	is_mouse_over = true
	
func _on_Area2D_mouse_exited():
	is_mouse_over = false