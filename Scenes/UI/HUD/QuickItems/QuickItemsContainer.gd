extends HBoxContainer

func _ready():
	var QuickItem = load(Global.paths["QuickItem.tscn"])
	var NullItem = load(Global.paths["NullItem.gd"])
	var quick_item
	
	for i in range(1, 10):
		quick_item = QuickItem.instance()
		quick_item.init(i, NullItem.new())
		
		add_child(quick_item)
		
	quick_item = QuickItem.instance()
	quick_item.init(0, NullItem.new())
		
	add_child(quick_item)