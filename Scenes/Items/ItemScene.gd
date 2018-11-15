extends Sprite

var item

func _ready():
	pass
	
func init(item):
	self.item = item
	texture = item.get_texture()