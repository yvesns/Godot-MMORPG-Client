extends Node

var scene_args
var paths = {}

var player_node = null
var player_data = null

var inventory_slot_size = 50

var is_map_loaded = false

func _ready():
	#Scenes
	paths["LoginUI.tscn"] = "res://Scenes/UI/Login/LoginUI.tscn"
	paths["CharacterCreation.tscn"] = "res://Scenes/UI/CharacterCreation/CharacterCreation.tscn"
	paths["CharacterSelection.tscn"] = "res://Scenes/UI/CharacterSelection/CharacterSelection.tscn"
	paths["CharacterSlot.tscn"] = "res://Scenes/UI/CharacterSelection/CharacterSlot.tscn"
	paths["Fighter.tscn"] = "res://Scenes/Creatures/Player/Human/Fighter.tscn"
	paths["TestMap.tscn"] = "res://Scenes/Maps/TestMap.tscn"
	paths["QuickItem.tscn"] = "res://Scenes/UI/HUD/QuickItems/QuickItem.tscn"
	paths["SkillSlot.tscn"] = "res://Scenes/UI/HUD/Skills/SkillSlot.tscn"
	paths["InventorySlot.tscn"] = "res://Scenes/UI/Inventory/InventorySlot.tscn"
	paths["InventoryItem.tscn"] = "res://Scenes/UI/Inventory/InventoryItem.tscn"
	paths["ItemScene.tscn"] = "res://Scenes/Items/ItemScene.tscn"
	paths["Inventory.tscn"] = "res://Scenes/UI/Inventory/Inventory.tscn"
	
	#Scripts
	paths["PlayerCharacter.gd"] = "res://Classes/Player/PlayerCharacter.gd"
	paths["Item.gd"] = "res://Classes/Item/Item.gd"
	paths["NullItem.gd"] = "res://Classes/Item/NullItem.gd"
	paths["TestItem.gd"] = "res://Classes/Item/TestItem.gd"
	paths["NullSkill.gd"] = "res://Classes/Skill/NullSkill.gd"
	
	#Data
	paths["CharacterPlaceholder.png"] = "res://Data/Images/Creatures/Player/PLAYER.png"
	paths["TestItem.png"] = "res://Data/Images/Items/TestItem.png"
	
func get_file_path(file_name):
	if paths.has(file_name):
		return paths[file_name]
	
	var file_path = find_file(file_name)
	
	if !file_path:
		return false
	
	paths[file_name] = file_path
	
	return file_path
	
func set_player_node(player_node):
	self.player_node = player_node
	
func get_player_node():
	return player_node
	
func get_player_data():
	return player_node.get_character_info()
	
func find_file(file_name):
	var dir = Directory.new()
	var current_dir_path
	var next_dirs = []
	var path = false
	var next_element
	
	dir.open("res://")
	dir.list_dir_begin()
	current_dir_path = dir.get_current_dir()
	
	while (current_dir_path == "res://" || next_dirs.size() > 0):
		next_element = dir.get_next()
		
		while(next_element != ""):
			if dir.current_is_dir():
				next_dirs.append(current_dir_path + "/" + next_element)
			elif next_element == file_name:
				dir.list_dir_end()
				return current_dir_path + "/" + next_element
			
			next_element = dir.get_next()
			
		if next_dirs.size() > 0:
			dir.open(next_dirs.pop_front())
			dir.list_dir_begin()
			current_dir_path = dir.get_current_dir()
	
	return false
	
func is_mouse_over(node_position, mouse_position, size):
	var max_x = node_position.x + size.x
	var max_y = node_position.y + size.y
	
	return (
		mouse_position.x >= node_position.x &&
		mouse_position.x <= max_x &&
		mouse_position.y >= node_position.y &&
		mouse_position.y <= max_y
	)
	
func load_map(map_path):
	is_map_loaded = false
	
	get_tree().change_scene(map_path)
	get_tree().get_root().add_child(player_node)
	
	#Global.player_node.position = Vector2(character_position.x, character_position.y)
	player_node.show()
	
	is_map_loaded = true