extends TextureRect

var item

func _ready():
	pass
	
func init(item):
	self.item = item
	rect_size = Vector2(item.get_width(), item.get_height())
	texture = item.get_texture()