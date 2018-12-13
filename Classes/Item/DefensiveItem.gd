extends "res://Classes/Item/Item.gd"

#Database attribute
var armour

func _ready():
	pass
	
func serialize():
	return {
		texture = self.texture,
		state = self.state,
		item_id = self.item_id,
		item_name = self.item_name,
		item_class = self.item_class,
		item_type = self.item_type,
		item_rarity = self.item_rarity,
		item_options = JSON.print(self.item_options, "", true),
		inventory_slot_width = self.inventory_slot_width,
		inventory_slot_height = self.inventory_slot_height,
		armour = self.armour
	}
	
func deserialize(json_item):
	pass