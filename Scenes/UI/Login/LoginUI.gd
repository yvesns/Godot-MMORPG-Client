extends TextureRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func is_options_gui_open():
	return false

func _on_ConnectButton_button_up():
	if is_options_gui_open():
		return
	
	get_node("LoginPrompt").visible = true
