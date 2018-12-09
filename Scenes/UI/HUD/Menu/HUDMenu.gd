extends VBoxContainer

var inventory_node = null

func _ready():
	pass
	
func create_inventory():
	var control = Control.new()
	inventory_node = load(Global.paths["Inventory.tscn"]).instance()
	inventory_node.hide()
	get_tree().get_root().add_child(control)
	control.add_child(inventory_node)
	
func toggle_inventory():
	if inventory_node.visible:
		inventory_node.hide()
	else:
		inventory_node.show()

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
	if inventory_node == null:
		create_inventory()
		
	toggle_inventory()
	
func _input(event):
	if Input.is_action_just_pressed("inventory"):
		_on_Inventory_button_up()