extends Node

func _ready():
	set_process_input(false)
	
func _input(event):
	if event is InputEventMouseButton:
		#Global.player_node.position = event.position
		pass