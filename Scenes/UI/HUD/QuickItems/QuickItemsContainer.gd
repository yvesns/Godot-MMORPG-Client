extends HBoxContainer

func _ready():
	var QuickItem = load(Global.paths["QuickItem.tscn"])
	var quick_item
	
	for i in range(1, 10):
		quick_item = QuickItem.instance()
		quick_item.init(i)