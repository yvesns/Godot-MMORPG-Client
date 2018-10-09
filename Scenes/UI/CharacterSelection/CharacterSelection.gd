extends TextureRect

var characters

func _ready():
	characters = Global.scene_args
	
	print(characters)
	print(characters[0])
	print(characters[1])
	
	for i in range(characters.size()):
		pass