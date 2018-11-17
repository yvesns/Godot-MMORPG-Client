extends PanelContainer

var row_count = 5
var row_size = 10
var slots = {}

func _ready():
	var slot_container = find_node("GridContainer")
	var InventorySlot = load(Global.paths["InventorySlot.tscn"])
	var intentory_slot
		
	for i in range(row_count):
		for j in range(row_size):
			slots[i] = {}
			slots[i][j] = InventorySlot.instance()
			slot_container.add_child(slots[i][j])
			
	InputHandler.set_inventory_node(self)
	
func is_item_over():
	for i in range(row_count):
		for j in range(row_size):
			if slots[i][j].is_item_over:
				return true
				
	return false
