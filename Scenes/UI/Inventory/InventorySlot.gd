extends PanelContainer

var slot_area
var original_color
var row
var column

var item = null
var is_item_over = false
var has_item = false
var is_root = false

func _ready():
	slot_area = find_node("Area2D")
	original_color = modulate

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	modulate = ColorN("Blue")
	is_item_over = true

func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	modulate = original_color
	is_item_over = false

func init(row, column):
	self.row = row
	self.column = column
	
func set_item(item, is_root):
	self.item = item
	self.is_root = is_root
	has_item = true
	
func get_row():
	return row
	
func get_column():
	return column
