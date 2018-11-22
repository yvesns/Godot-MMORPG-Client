extends PanelContainer

var slot_area
var original_color
var row
var column

var item = null
var is_item_over = false
var has_item = false
var is_root = false

var SlotImage = load(Global.paths["InventorySlotImage.tscn"])
var slot_image_node

func _ready():
	slot_area = find_node("Area2D")
	original_color = modulate
	slot_image_node = SlotImage.instance()

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if area == slot_image_node.get_area():
		return
	
	modulate = ColorN("Blue")
	is_item_over = true

func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	if area == slot_image_node.get_area():
		return
	
	modulate = original_color
	is_item_over = false

func init(row, column):
	self.row = row
	self.column = column
	
func set_item(item, is_root):
	self.item = item
	self.is_root = is_root
	has_item = true
	
	if is_root:
		slot_image_node.set_item(item)
		
func get_slot_image_node():
	return slot_image_node