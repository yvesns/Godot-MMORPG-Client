extends VBoxContainer

# TODO
# 1. Implement channels
# 2. Send text to peers

var chat_text
var line_edit

func _ready():
	chat_text = find_node("ChatText")
	line_edit = find_node("LineEdit")
	
func _input(event):
	if !line_edit.has_focus() || line_edit.text == "":
		return
	
	if Input.is_key_pressed(KEY_ENTER) || Input.is_key_pressed(KEY_KP_ENTER):
		if chat_text.text != "":
			chat_text.text += "\n"
		
		chat_text.text += line_edit.text
		line_edit.text = ""

func _on_Button_button_up():
	var chat_text = find_node("ChatText")
	var button = find_node("Button")
	
	if chat_text.visible:
		chat_text.hide()
		button.text = "/\\"
	else:
		chat_text.show()
		button.text = "V"
