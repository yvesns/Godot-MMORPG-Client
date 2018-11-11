extends VBoxContainer

func _ready():
	pass

func _on_Menu_button_up():
	var menu_button = find_node("Menu")
	var options_container = find_node("OptionsContainer")
	
	if options_container.visible:
		options_container.hide()
		menu_button.text = "/\\ Menu"
	else:
		options_container.show()
		menu_button.text = "V Menu"
