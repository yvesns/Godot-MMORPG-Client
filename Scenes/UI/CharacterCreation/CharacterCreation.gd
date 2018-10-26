extends TextureRect

# TODO
# 1. Add character preview
# 2. Add stats preview
# 3. Add character customization
# 4. Add gui theme

var character
var race_button_group = ButtonGroup.new()
var creating_character = false

func _ready():
	character = load(Global.paths["PlayerCharacter.gd"]).new()
	
	find_node("HumanCheckbox").group = race_button_group
	find_node("VampireCheckbox").group = race_button_group
	
	character.set_race("Human")
	character.set_class("Common")
	
	Network.connect_character_creation_success(self, "_on_character_creation_success")
	Network.connect_character_creation_failure(self, "_on_character_creation_failure")

func _on_LineEdit_text_changed(new_name):
	character.set_name(new_name)
	
func _on_HumanCheckbox_button_up():
	character.set_race("Human")

func _on_VampireCheckbox_button_up():
	character.set_race("Vampire")

func _on_Create_button_up():
	if (character.get_name() == "" ||
	    character.get_race() == ""):
		return
	
	creating_character = true
	
	character.set_class(character.get_class() + character.get_race())
	
	Network.create_character(character)

func _on_Cancel_button_up():
	if creating_character:
		return
	
	get_tree().change_scene(Global.paths["CharacterSelection.tscn"])
	
func _on_character_creation_success(characters):
	Global.scene_args = characters
	
	get_tree().change_scene(Global.paths["CharacterSelection.tscn"])
	
func _on_character_creation_failure(message):
	creating_character = false
	character.set_class("Common")
	
	var dialog = find_node("AcceptDialog")
	dialog.window_title = "Character creation error"
	dialog.dialog_text = message
	dialog.popup_centered()
