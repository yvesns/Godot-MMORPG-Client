extends TextureRect

var characters
var selected_character = null

# TODO
# 1. Change the character scene to include the character panel container;
# 2. Instance and dynamically add character scenes based on a configurable variable
#    in order to allow future modification;

func _ready():
	var character_scene = load(Global.paths["Character.tscn"])
	var character
	characters = Global.scene_args
	
	for i in range(characters.size()):
		character = character_scene.instance()
		character.init(characters[i])
		character.connect_character_selected_signal(self, "_on_character_selected")
		find_node("Character" + str(i + 1)).add_child(character)
		
	Network.connect_character_connection_success(self, "_on_character_connection_success")
		
func _on_character_selected(character):
	selected_character = character

func _on_GameStart_button_up():
	if selected_character != null:
		Network.connect_character(selected_character)

func _on_Cancel_button_up():
	pass

func _on_character_connection_success():
	print("Character connected")

func _on_Create_button_up():
	if characters.size() >= 3:
		return
