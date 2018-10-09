extends CenterContainer

var character

func _ready():
	pass
	
func init(character):
	#Build character based on his equipment
	
	character = character
	
	find_node("TextureRect").texture = load(Global.paths["CharacterPlaceholder"])

func _on_TextureRect_gui_input(ev):
	#Handle character selected case if event is double click
	
	if (ev.type == InputEvent.MOUSE_BUTTON &&
		ev.button_index == 1 &&
	    ev.is_pressed() && 
		ev.doubleclick):
			#Connect with this char
			pass
		
	pass
