extends TextureRect

func _ready():
	pass
	
func init(item_texture, width, height):
	rect_size = Vector2(width, height)
	texture = item_texture