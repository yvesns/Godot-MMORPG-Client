extends PanelContainer

var slot_area
var original_color

func _ready():
	slot_area = find_node("Area2D")
	original_color = modulate

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	modulate = ColorN("Blue")

func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	modulate = original_color
