extends Popup

var dragging = false

func _ready():
	pass

func _on_TitleContainer_gui_input(event):
	if (event == InputEventMouseButton && 
	    event.button_index == BUTTON_LEFT):
		if event.pressed:
			print("Setting flag")
			dragging = true
		else:
			print("Resetting flag")
			dragging = false
	elif (event == InputEventMouseMotion &&
	      dragging):
		print("Dragging")
		self.position = get_viewport().get_mouse_position()
