extends TextureRect

func _ready():
	pass
	
func init(hotkey, skill):
	texture = skill.get_texture()
	
	find_node("HotkeyLabel").text = hotkey