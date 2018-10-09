extends Node

var scene_args
var paths = {}

func _ready():
	paths["CharacterSelection.tscn"] = "res://Scenes/UI/CharacterSelection/CharacterSelection.tscn"
	
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