extends TextureRect

var characters
var selected_character = null
var character_container = null
var minimum_character_slots = 3

func _ready():
	var character_scene = load(Global.paths["Character.tscn"])
	var character
	characters = Global.scene_args
	
	for i in range(minimum_character_slots):
		character = character_scene.instance()
		character.connect_character_selected_signal(self, "_on_character_selected")
		
		if i < characters.size():
			character.init(characters[i])
		
		find_node("CharactersHBox").add_child(character)
		
	Network.connect_character_connection_success(self, "_on_character_connection_success")
	
	find_node("Popup").popup_centered()
		
func _on_character_selected(character, character_container):
	selected_character = character
	
	if self.character_container != null:
		self.character_container.deselect()
	
	self.character_container = character_container

func _on_GameStart_button_up():
	if selected_character != null:
		Network.connect_character(selected_character)

func _on_Cancel_button_up():
	get_tree().change_scene(Global.paths["LoginUI.tscn"])

func _on_character_connection_success():
	print("Character connected")

func _on_Create_button_up():
	if characters.size() >= 3:
		return
		
	get_tree().change_scene(Global.paths["CharacterCreation.tscn"])

func _on_Delete_button_up():
	pass # replace with function body
