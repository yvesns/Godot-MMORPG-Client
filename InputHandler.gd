extends Node2D

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
	
	var item_scene = ItemScene.instance()
	item_scene.init(test_item)
	item_on_cursor = item_scene
	
	get_tree().get_root().call_deferred("add_child", item_scene)
	
func _input(event):
	if event is InputEventMouseMotion && item_on_cursor != null:
		move_item_on_cursor()
	
func move_item_on_cursor():
	item_on_cursor.position = get_global_mouse_position()
		
func set_inventory_node(inventory_node):
	self.inventory_node = inventory_node
	
func set_item_on_cursor(item):
	var item_scene = ItemScene.instance()
	item_scene.init(item)
	item_on_cursor = item_scene
	
	item_scene.hide()
	get_tree().get_root().add_child(item_scene)
	item_scene.position = get_global_mouse_position()
	item_scene.show()
	
func remove_item_on_cursor():
	if item_on_cursor == null:
		return
	
	item_on_cursor.queue_free()
	item_on_cursor = null
	
func _on_item_scene_clicked(item):
	if (inventory_node != null &&
		inventory_node.visible &&
		inventory_node.is_item_over()):
			
		if inventory_node.handle_item_insertion(item):
			remove_item_on_cursor()
			
func _on_inventory_item_clicked(inventory_item, root_slot):
	set_item_on_cursor(inventory_item.get_item())
	inventory_node.remove_item(inventory_item)