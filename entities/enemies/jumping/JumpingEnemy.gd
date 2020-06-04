extends Enemy
# Jumping slime

export (int) var GRAVITY = 832
export (int) var TERMINAL_SPEED = 1024
export (Array) var JUMP_FORCES = [144, 208, 336]

onready var jump_delay_timer: Timer = $JumpDelayTimer


func _process(_delta: float) -> void:
	if Input.is_action_pressed("fire"):
		jump_check()


func _physics_process(delta: float) -> void:
	motion = move_and_slide(motion, Vector2.UP)
	# Prevent sliding
	if is_on_floor():
		motion.x = 0
	apply_gravity(delta)


func get_jump_direction() -> int:
	return int(sign(get_local_mouse_position().x))


func apply_gravity(delta: float) -> void:
	motion.y += GRAVITY * delta
	motion.y = clamp(motion.y, -TERMINAL_SPEED, TERMINAL_SPEED)


func jump_check() -> void:
	if is_on_floor():
		motion.x = get_jump_direction() * SPEED
		# Randomize jump height
		motion.y = -JUMP_FORCES[randi() % JUMP_FORCES.size()]


func _on_JumpDelayTimer_timeout() -> void:
	jump_check()
