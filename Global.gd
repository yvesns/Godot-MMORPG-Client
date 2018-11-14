extends Node

var scene_args
var paths = {}

var player_node

var inventory_slot_size = 50

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
	paths["ItemScene.tscn"] = "res://Scenes/Items/ItemScene.tscn"
	
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