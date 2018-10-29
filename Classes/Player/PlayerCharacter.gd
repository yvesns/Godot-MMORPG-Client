extends "res://Classes/Character.gd"

var character_class
var character_race
var respawn_map

func _ready():
	pass
	
func init_from_database(database_character):
	set_name(database_character.name)
	set_race(database_character.race_fk)
	set_class(database_character.class_fk)
	set_respawn_map(database_character.respawn_map_fk)
	
func get_class():
	return character_class
	
func set_class(character_class):
	self.character_class = character_class
	
func get_race():
	return character_race
	
func set_race(character_race):
	self.character_race = character_race
	
func get_respawn_map():
	return respawn_map
	
func set_respawn_map(map):
	respawn_map = map
	
func serialize():
	return {
		character_name = self.character_name,
		character_race = self.character_race,
		character_class = self.character_class,
		respawn_map = self.respawn_map
	}
	
func deserialize(character):
	set_name(character.character_name)
	set_race(character.character_race)
	set_class(character.character_class)
	set_respawn_map(character.respawn_map)