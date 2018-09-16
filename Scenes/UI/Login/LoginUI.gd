extends TextureRect

func _ready():
	pass

func is_options_gui_open():
	return false

func _on_ConnectButton_button_up():
	if is_options_gui_open():
		return
	
	get_node("LoginPrompt").visible = true
