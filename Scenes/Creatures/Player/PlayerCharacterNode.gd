extends KinematicBody2D

var character_info
var move_to = null
var moving = false
var movement_speed = 160
var position_tolerance = 2

func _ready():
	pass
	
func init(character_info):
	self.character_info = character_info
	z_index += 1
		
func get_motion():
	var x
	var y
	
	if position.x < move_to.x:
		x = 1
	elif position.x > move_to.x:
		x = -1
	else:
		x = 0
		
	if position.y < move_to.y:
		y = 1
	elif position.y > move_to.y:
		y = -1
	else:
		y = 0
		
	return Vector2(x, y)
	
func destination_reached():
	return ( 
		abs(self.position.x - move_to.x) < position_tolerance && 
		abs(self.position.y - move_to.y) < position_tolerance
	)
	
func get_character_info():
	return character_info
	
func _input(event):
	if event is InputEventMouseButton:
		move_to = event.position
		moving = true
	
func _physics_process(delta):
	if !moving || move_to == null:
		return
		
	if destination_reached():
		moving = false
		return
		
	var motion = get_motion()
	
	motion = motion.normalized() * character_info.get_movement_speed()

	move_and_slide(motion)