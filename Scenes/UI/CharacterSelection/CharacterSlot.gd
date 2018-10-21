extends PanelContainer

signal character_selected(character, character_container)

var character = null
var original_color

func _ready():
	original_color = modulate
	
func init(character):
	#Build character based on his equipment
	
	self.character = character
	
	find_node("TextureRect").texture = load(Global.paths["CharacterPlaceholder"])

func _on_TextureRect_gui_input(ev):
	if (ev is InputEventMouseButton &&
		ev.button_index == BUTTON_LEFT &&
	    ev.is_pressed()):
			if ev.doubleclick:
				if character != null:
					Network.connect_character(character)
				else:
					get_tree().change_scene(Global.paths["CharacterCreation.tscn"])
			else:
				select()
				emit_signal("character_selected", character, self)
				
func connect_character_selected_signal(node, method_name):
	connect("character_selected", node, method_name)
	
func select():
	modulate = ColorN("gray")
	
func deselect():
	modulate = original_color