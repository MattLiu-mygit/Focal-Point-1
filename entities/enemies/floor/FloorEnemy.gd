extends Enemy

export(int) var SLOW_PERCENT = 0.25

onready var sprite: Sprite = $Sprite
onready var floor_cast: RayCast2D = $FloorCast


func _physics_process(_delta: float) -> void:
	var facing_direction = int(sign(get_local_mouse_position().x))
	floor_cast.position.x *= facing_direction
	
	# Prevents jumping off cliffs
	if not floor_cast.is_colliding():
		motion.x = 0
	elif facing_direction != 0: # and not attached_to_player:
		floor_cast.position.x = facing_direction
		motion.x = SPEED * facing_direction
	
	motion = move_and_slide(motion, Vector2.UP)
