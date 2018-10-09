extends TextureRect

var characters

func _ready():
	var character_scene = load(Global.paths["Character.tscn"])
	var character
	characters = Global.scene_args
	
	print(characters)
	print(characters[0])
	print(characters[1])
	
	for i in range(characters.size()):
		character = character_scene.instance()
		character.init(characters[i])
		find_node("Character" + str(i + 1)).add_child(character)