extends CenterContainer

signal character_selected(character)

var character

func _ready():
	pass
	
func init(character):
	#Build character based on his equipment
	
	character = character
	
	find_node("TextureRect").texture = load(Global.paths["CharacterPlaceholder"])

func _on_TextureRect_gui_input(ev):
	if (ev is InputEventMouseButton &&
		ev.button_index == BUTTON_LEFT &&
	    ev.is_pressed() && 
		ev.doubleclick):
			if ev.doubleclick:
				Network.connect_character(character)
			else:
				emit_signal("character_selected", character)
				
func connect_character_selected_signal(node, method_name):
	connect("character_selected", node, method_name)