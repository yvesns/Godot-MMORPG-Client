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
	
	character_info.character_class += character_race
	
	Network.create_character(character_info)