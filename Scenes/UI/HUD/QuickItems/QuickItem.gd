extends CenterContainer

func _ready():
	pass
	
func init(key, item):
	find_node("KeyLabel").text = key
	
	