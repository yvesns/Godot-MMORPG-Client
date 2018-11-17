extends Sprite

var item

func _ready():
	pass
	
func init(item):
	var extents = Vector2(item.get_width() * 0.665 / 2, item.get_height() * 0.8 / 2)
	
	self.item = item
	texture = item.get_texture()
	
	find_node("CollisionShape2D").shape.extents = extents