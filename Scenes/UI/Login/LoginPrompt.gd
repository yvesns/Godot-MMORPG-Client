extends Control

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


func _on_CloseButton_button_up():
	visible = false

func _on_LoginButton_button_up():
	#get_tree().change_scene("res://Scenes/Maps/TestMap.tscn")
	Main.connect_to_server()
