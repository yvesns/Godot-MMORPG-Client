extends VBoxContainer

var inventory_scene = null

func _ready():
	pass

func _on_Menu_button_up():
	var menu_button = find_node("Menu")
	var options_container = find_node("OptionsContainer")
	
	if options_container.visible:
		options_container.hide()
		menu_button.text = "/\\ Menu"
	else:
		options_container.show()
		menu_button.text = "V Menu"

func _on_Inventory_button_up():
	if inventory_scene == null:
		var control = Control.new()
		inventory_scene = load(Global.paths["Inventory.tscn"]).instance()
		inventory_scene.hide()
		get_tree().get_root().add_child(control)
		control.add_child(inventory_scene)
		
	inventory_scene.show()