extends PanelContainer

var inventory_slots = 50

func _ready():
	var slot_container = find_node("GridContainer")
	var InventorySlot = load(Global.paths["InventorySlot.tscn"])
	
	for i in range(inventory_slots):
		slot_container.add_child(InventorySlot.instance())
