extends Enemy

export (int) var GRAVITY = 832
export (int) var TERMINAL_SPEED = 1024
export (int) var JUMP_FORCE = 336

export(bool) var jumped := false
var motion_x

onready var floor_left: RayCast2D = $FloorLeft
onready var floor_right: RayCast2D = $FloorRight
onready var jump_delay_timer: Timer = $JumpDelayTimer


func _physics_process(delta: float) -> void:
	jumped = false
	motion.x = 0
	var jump_direction := get_jump_direction()
	apply_horizontal_force(jump_direction, delta)
	apply_gravity(delta)
	motion = move_and_slide(motion, Vector2.UP)


# Compares whether going left or right will bring it closer to the mouse position.
func get_jump_direction() -> float:
	var mouse_x = get_global_mouse_position().x
	var distance_from_mouse = position.x - mouse_x
	var left_difference = abs(distance_from_mouse - 1)
	var right_difference = abs(distance_from_mouse + 1)
		
	if left_difference < right_difference:
		return -1.0
	else:
		return 1.0


func apply_horizontal_force(jump_direction: float, delta: float) -> void:
	if not floor_left.is_colliding() or not floor_right.is_colliding():
		motion.x += jump_direction * SPEED * delta


# We chose to also have the same up and down terminal speed, but this may change.
func apply_gravity(delta: float) -> void:
	motion.y += GRAVITY * delta
	motion.y = clamp(motion.y, -TERMINAL_SPEED, TERMINAL_SPEED)


func jump_check() -> void:
	if floor_left.is_colliding() or floor_right.is_colliding() and jump_delay_timer.time_left == 0:
		motion.y = -JUMP_FORCE


func check_death():
	if stats.health == 0:
		queue_free()


func _on_JumpDelayTimer_timeout() -> void:
	jump_check()
