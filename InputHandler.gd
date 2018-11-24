extends Node

var item_on_cursor = null
var inventory_node = null
var ItemScene

func _ready():
	ItemScene = load(Global.paths["ItemScene.tscn"])
	
	#Remove later
	run_test()
	
func run_test():
	var test_item = load(Global.paths["TestItem.gd"]).new()
	test_item.init()
	
	set_item_on_cursor(test_item)
	
func _input(event):
	if event is InputEventMouseMotion && item_on_cursor != null:
		move_item_on_cursor()
	
func move_item_on_cursor():
	item_on_cursor.position = item_on_cursor.get_global_mouse_position()
		
func set_inventory_node(inventory_node):
	self.inventory_node = inventory_node
	
func set_item_on_cursor(item):
	var item_scene = ItemScene.instance()
	item_scene.init(item)
	item_on_cursor = item_scene
	
	get_tree().get_root().call_deferred("add_child", item_scene)
	
func _on_item_scene_clicked(item):
	if (inventory_node != null &&
		inventory_node.visible &&
		inventory_node.is_item_over()):
			
		if inventory_node.handle_item_insertion(item):
			item_on_cursor.queue_free()
			item_on_cursor = null
			
func _on_inventory_item_clicked(item):
	set_item_on_cursor(item)