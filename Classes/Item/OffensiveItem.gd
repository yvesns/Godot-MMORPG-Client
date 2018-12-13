extends "res://Classes/Item/Item.gd"

#Database attributes
var min_damage
var max_damage

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
		min_damage = self.min_damage,
		max_damage = self.max_damage
	}
	
func deserialize(json_item):
	pass