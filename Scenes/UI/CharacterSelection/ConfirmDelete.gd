extends Popup

# TODO
# Maybe use some other way to communicate a error instead of using a popup

signal delete_character(character)

var click_pos = null
var character_name = ""
var character

func _ready():
	pass
	
func set_character(character):
	self.character = character
	
func build_name_mismatch_dialog():
	var dialog = find_node("AcceptDialog")
	
	dialog.window_title = "Character deletion"
	dialog.dialog_text = "Name mismatch"
	
	return dialog
	
func connect_delete_character(node, method_name):
	connect("delete_character", node, method_name)
	
func _on_TitleContainer_gui_input(event):
	if (event is InputEventMouseButton && 
	    event.button_index == BUTTON_LEFT):
		if event.pressed:
			click_pos = get_global_mouse_position() - get_position()
		else:
			click_pos = null
	elif (event is InputEventMouseMotion &&
	      click_pos != null):
		set_position(get_global_mouse_position() - click_pos)

func _on_Confirm_button_up():
	if character_name != character.get_name():
		build_name_mismatch_dialog().popup_centered()
		return
		
	emit_signal("delete_character", character)

func _on_DeleteCancel_button_up():
	hide()

func _on_LineEdit_text_changed(character_name):
	self.character_name = character_name