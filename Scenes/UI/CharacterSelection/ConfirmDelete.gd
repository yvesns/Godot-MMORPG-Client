extends Popup

var click_pos = null

func _ready():
	pass

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
	pass