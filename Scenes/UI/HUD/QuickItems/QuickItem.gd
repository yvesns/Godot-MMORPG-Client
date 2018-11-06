extends TextureRect

func _ready():
	find_node("QuantityLabel").text = ""
	
func init(key, item):
	find_node("KeyLabel").text = key
	texture = item.get_texture()
	
	if item.is_stackable():
		find_node("QuantityLabel").text = item.quantity