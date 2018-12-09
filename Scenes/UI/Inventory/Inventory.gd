extends PanelContainer

var row_count = 5
var row_size = 10
var slots = {}

var InventorySlot
var InventoryItem

var click_pos = null

#Just for debugging, remove later.
var inventory = []

func _ready():
	var viewport_size = get_viewport().size
	var slot_container = find_node("SlotGrid")
	var slot_image_container = find_node("SlotImageGrid")
	InventorySlot = load(Global.paths["InventorySlot.tscn"])
	InventoryItem = load(Global.paths["InventoryItem.tscn"])
		
	for i in range(row_count):
		slots[i] = {}
		
		for j in range(row_size):
			slots[i][j] = InventorySlot.instance()
			slots[i][j].init(i, j)
			slot_container.add_child(slots[i][j])
			
	set_position(Vector2(viewport_size.x/4, viewport_size.y/2))
	
	InputHandler.set_inventory_node(self)
	
	#Remove later
	run_test()
	
func run_test():
	var test_item = load(Global.paths["TestItem.gd"]).new()
	test_item.init()
	
	insert_item(test_item, slots[0][0])
	
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
	
func get_overlapped_slots():
	var overlapped_slots = []
	
	for i in range(row_count):
		for j in range(row_size):
			if slots[i][j].is_item_over:
				overlapped_slots.append(slots[i][j])
	
	return overlapped_slots
	
func get_overlapped_items(item):
	var overlapped_items = []
	var overlapped_slots = get_overlapped_slots()
	
	if overlapped_slots.size() < item.get_slot_count():
		return null
	
	for slot in overlapped_slots:
		if slot.get_item() != null && !overlapped_items.has(slot.get_item()):
			overlapped_items.append(slot.get_item())
				
	return overlapped_items
	
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
	#if Global.player_data.has_item(item):
	#	return
		
	#Global.player_data.add_item(item)
	
	# Just for debugging, remove later.
	if inventory.has(item):
		return
	
	inventory.append(item)
	
	var is_root_slot = false
	var inventory_item = InventoryItem.instance()
	inventory_item.init(item, slot)
	
	for i in range(item.inventory_slot_height):
		for j in range(item.inventory_slot_width):
			if i == 0 && j == 0:
				is_root_slot = true
			else:
				is_root_slot = false
				
			slots[slot.row + i][slot.column + j].set_item(inventory_item, is_root_slot)
			inventory_item.add_slot(slots[slot.row + i][slot.column + j])
	
	find_node("InventoryItemContainer").add_child(inventory_item)
	inventory_item.margin_left = slot.get_column() * Global.inventory_slot_size + (3.7 * (slot.get_column() + 1))
	inventory_item.margin_top = slot.get_row() * Global.inventory_slot_size + (3.7 * (slot.get_row() + 1))
	
func remove_item(inventory_item):
	for i in range(inventory.size()):
		if inventory[i] == inventory_item.get_item():
			inventory.remove(i)
			break

	for slot in inventory_item.get_slots():
		slot.remove_item()
	
	inventory_item.set_destroyed()
	inventory_item.queue_free()
		
func swap_items(cursor_item_data, inventory_item):
	if get_overlapped_slots().size() < cursor_item_data.get_slot_count():
		return false
		
	var root_slot = get_hovering_item_top_left_slot()
	
	InputHandler.remove_item_on_cursor()
	InputHandler.set_item_on_cursor(inventory_item.get_item())
	remove_item(inventory_item)
	insert_item(cursor_item_data, root_slot)
	
	return false
	
func handle_item_insertion(item):
	var slot = get_hovering_item_top_left_slot()
	var overlapped_items
	
	if slot == null:
		return false
		
	overlapped_items = get_overlapped_items(item)
	
	if overlapped_items == null:
		return false
		
	if overlapped_items.size() == 1:
		return swap_items(item, overlapped_items[0])
		
	if has_enough_space(item, slot):
		insert_item(item, slot)
		return true
	
	return false

func _on_CloseButton_button_up():
	hide()

func _on_TopBarContainer_gui_input(event):
	if (event is InputEventMouseButton && 
	    event.button_index == BUTTON_LEFT):
		if event.pressed:
			click_pos = get_global_mouse_position() - get_position()
		else:
			click_pos = null
	elif (event is InputEventMouseMotion &&
	      click_pos != null):
		set_position(get_global_mouse_position() - click_pos)
