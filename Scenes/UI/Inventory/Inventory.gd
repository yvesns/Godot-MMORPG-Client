extends PanelContainer

var row_count = 5
var row_size = 10
var slots = {}

func _ready():
	var slot_container = find_node("SlotGrid")
	var slot_image_container = find_node("SlotImageGrid")
	var InventorySlot = load(Global.paths["InventorySlot.tscn"])
	var intentory_slot
		
	for i in range(row_count):
		slots[i] = {}
		
		for j in range(row_size):
			slots[i][j] = InventorySlot.instance()
			slots[i][j].init(i, j)
			#slot_container.add_child(slots[i][j])
			
	InputHandler.set_inventory_node(self)
	
func is_item_over():
	for i in range(row_count):
		for j in range(row_size):
			if slots[i][j].is_item_over:
				return true
				
	return false
	
func get_hovering_item_top_left_slot():
	for i in range(row_count):
		for j in range(row_size):
			if slots[i][j].is_item_over:
				return slots[i][j]
				
	return null
	
func has_enough_space(item, slot):
	for i in range(item.inventory_slot_height):
		for j in range(item.inventory_slot_width):
			if slot.row + i > row_count - 1:
				return false
				
			if slot.column + j > row_size - 1:
				return false
			
			if slots[slot.row + i][slot.column + j].has_item:
				return false
	
	return true
	
func insert_item(item, slot):
	var is_root_slot = false
	
	for i in range(item.inventory_slot_height):
		for j in range(item.inventory_slot_width):
			if i == 0 && j == 0:
				is_root_slot = true
			else:
				is_root_slot = false
				
			slots[slot.row + i][slot.column + j].set_item(item, is_root_slot)
	
func handle_item_insertion(item):
	var slot = get_hovering_item_top_left_slot()
	
	if slot == null:
		return false
		
	if has_enough_space(item, slot):
		insert_item(item, slot)
		return true
		
	return false