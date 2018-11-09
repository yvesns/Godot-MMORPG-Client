extends PanelContainer

var SkillSlot
var NullSkill
var mouse_hotkeys = ["M1", "M2", "M3"]
var keyboard_hotkeys = ["Q", "W", "E", "R", "T"]

func _ready():
	SkillSlot = load(Global.paths["SkillSlot.tscn"])
	NullSkill = load(Global.paths["NullItem.gd"])
	
	create_mouse_slots()
	create_keyboard_slots()
	
func create_mouse_slots():
	var mouse_skills = find_node("MouseSkills")
	var skill_slot
	
	for hotkey in mouse_hotkeys:
		skill_slot = SkillSlot.instance()
		skill_slot.init(hotkey, NullSkill.new())
		mouse_skills.add_child(skill_slot)
	
func create_keyboard_slots():
	var keyboard_skills = find_node("KeyboardSkills")
	var skill_slot
	
	for hotkey in keyboard_hotkeys:
		skill_slot = SkillSlot.instance()
		skill_slot.init(hotkey, NullSkill.new())
		keyboard_skills.add_child(skill_slot)