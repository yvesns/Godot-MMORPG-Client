extends TextureRect

# TODO
# 1. Add character preview
# 2. Add stats preview
# 3. Add character customization
# 4. Add gui theme

var character_info = {
	character_name = "",
	character_race = "",
	character_class =  "Common"
}
var race_button_group = ButtonGroup.new()

func _ready():
	find_node("HumanCheckbox").group = race_button_group
	find_node("VampireCheckbox").group = race_button_group
	
	character_info.character_race = "Human"
	
	Network.connect_character_creation_success_signal(self, "_on_character_creation_success")
	Network.connect_character_creation_failure_signal(self, "_on_character_creation_failure")
	
	find_node("AcceptDialog").show()
	find_node("AcceptDialog").popup_exclusive = true

func _on_LineEdit_text_changed(new_name):
	character_info.character_name = new_name
	
func _on_HumanCheckbox_button_up():
	character_info.character_race = "Human"

func _on_VampireCheckbox_button_up():
	character_info.character_race = "Vampire"

func _on_Create_button_up():
	if (character_info.character_name == "" ||
	    character_info.character_race == ""):
		return
	
	character_info.character_class += character_info.character_race
	
	print("Sending request to network")
	Network.create_character(character_info)

func _on_Cancel_button_up():
	get_tree().change_scene(Global.paths["CharacterSelection.tscn"])
	
func _on_character_creation_success(characters):
	Global.scene_args = characters
	get_tree().change_scene(Global.paths["CharacterSelection.tscn"])
	
func _on_character_creation_failure(message):
	print(message)
