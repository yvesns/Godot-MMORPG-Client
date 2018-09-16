extends Control

func _ready():
	pass

func _on_CloseButton_button_up():
	visible = false

func _on_LoginButton_button_up():
	#get_tree().change_scene("res://Scenes/Maps/TestMap.tscn")
	Main.connect_to_server()

func _on_RegisterButton_button_up():
	visible = false
	get_parent().get_node("RegisterPrompt").visible = true
