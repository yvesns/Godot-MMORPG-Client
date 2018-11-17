extends PanelContainer

var slot_area
var original_color
var row
var row_position
var is_item_over = false

func _ready():
	slot_area = find_node("Area2D")
	original_color = modulate

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	modulate = ColorN("Blue")
	is_item_over = true

func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	modulate = original_color
	is_item_over = false

func init(row, position):
	self.row = row
	self.row_position = row_position