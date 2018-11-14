extends Node

var item_name
var texture = ImageTexture.new()
var inventory_slot_width = 0
var inventory_slot_height = 0

func _ready():
	pass
	
func is_stackable():
	return false
	
func get_texture():
	return texture
	
func get_width():
	return Global.inventory_slot_size * inventory_slot_width
	
func get_height():
	return Global.inventory_slot_size * inventory_slot_height
	
func create_texture(image_path):
	var image = Image.new()
	image.load(image_path)
	
	texture.create_from_image(image)