extends PanelContainer

signal character_selected(character, character_container)

var character = null
var original_color

func _ready():
	original_color = modulate
	
func init(database_character):
	#Build character based on his equipment
	character = load(Global.paths["PlayerCharacter.gd"]).new()
	character.init_from_database(database_character)
	
	#There seems to be a bug with HBoxContainers not taking into consideration
	#the size of labels when calculating the size of each child.
	find_node("Label").text = character.get_name()
	find_node("TextureRect").texture = load(Global.paths["CharacterPlaceholder.png"])
	
func connect_character_selected_signal(node, method_name):
	connect("character_selected", node, method_name)
	
func select():
	modulate = ColorN("lightgray")
	
func deselect():
	modulate = original_color
	
func remove_character():
	character = null
	find_node("Label").text = ""
	find_node("TextureRect").texture = null
	
	deselect()

func _on_CenterContainer2_gui_input(ev):
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
