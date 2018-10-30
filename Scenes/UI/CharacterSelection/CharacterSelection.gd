extends TextureRect

var characters
var selected_character = null
var character_container = null
var minimum_character_slots = 3

func _ready():
	var character_slot_scene = load(Global.paths["CharacterSlot.tscn"])
	var character_slot
	characters = Global.scene_args
	
	for i in range(minimum_character_slots):
		character_slot = character_slot_scene.instance()
		character_slot.connect_character_selected_signal(self, "_on_character_selected")
		
		if i < characters.size():
			character_slot.init(characters[i])
		
		find_node("CharactersHBox").add_child(character_slot)
		
	Network.connect_character_connection_success(self, "_on_character_connection_success")
	Network.connect_character_deletion_success(self, "_on_character_deletion_success")
	Network.connect_character_deletion_failure(self, "_on_character_deletion_failure")
	
	find_node("Popup").connect_delete_character(self, "_on_character_delete")
		
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

func _on_character_connection_success(map):
	var map_path = Global.paths[map + ".tscn"]
	var self_instance = Global.self_instance
	
	self_instance = load(Global.paths["Fighter.tscn"]).instance()
	self_instance.set_info(selected_character)
	self_instance.hide()
	self_instance.z_index += 1
	
	get_tree().change_scene(map_path)
	get_tree().get_root().add_child(self_instance)
	
	#self_instance.position = self_info.position
	self_instance.show()

func _on_Create_button_up():
	if characters.size() >= 3:
		return
	
	get_tree().change_scene(Global.paths["CharacterCreation.tscn"])

func _on_Delete_button_up():
	if selected_character == null:
		return
	
	var popup = find_node("Popup")
	popup.set_character(selected_character)
	popup.popup_centered()
	
func _on_character_delete(character):
	Network.delete_character(character)
	
func _on_character_deletion_success():
	var character = load(Global.paths["PlayerCharacter.gd"]).new()
	
	for i in range(characters.size()):
		character.init_from_database(characters[i])
		
		if selected_character.get_name() == character.get_name():
			characters.remove(i)
	
	character_container.remove_character()
	find_node("Popup").hide()

func _on_character_deletion_failure(message):
	var dialog = find_node("AcceptDialog")
	dialog.window_title = "Character deletion failed"
	dialog.dialog_text = message
	dialog.popup_centered()