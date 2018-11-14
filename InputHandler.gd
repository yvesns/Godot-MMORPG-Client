extends Node

var item_on_cursor = null

func _ready():
	#Remove later
	run_test()
	
func run_test():
	var test_item = load(Global.paths["TestItem.gd"]).new()
	var item_scene = load(Global.paths["ItemScene.tscn"]).instance()
	
	item_scene.init(test_item)
	item_on_cursor = item_scene
	
	#get_tree().get_root().call_deferred("add_child", item_scene)
	get_tree().get_root().add_child(item_scene)
	
func move_item_on_cursor():
	item_on_cursor.get_rect().position = item_on_cursor.get_global_mouse_position()
	
func _input(event):
	if event is InputEventMouseMotion && item_on_cursor != null:
		move_item_on_cursor()