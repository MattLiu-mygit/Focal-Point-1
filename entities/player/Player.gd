extends KinematicBody2D
class_name Player
# The Player scene has everything relating to controlling the character.
# Current mechanics:
# Player can jump over horizontal gaps:
#	4-block = no speed
#	5-block = walking speed
#	10-block (11 barely) = running speed
# Player can jump onto vertical heights:
#	1 to 4-block = depends on how long jump is held

export (int) var ACCELERATION = 640
export (int) var MAX_WALK_SPEED = 128
export (int) var MAX_RUN_SPEED = 192
export (float) var FRICTION = 0.25
export (int) var GRAVITY = 832
export (int) var TERMINAL_SPEED = 1024
export (int) var JUMP_FORCE = 336

var stats : PlayerStats = ResourceLoader.player_stats
var motion := Vector2.ZERO
var jumped := false

onready var jump_delay_timer: Timer = $JumpDelayTimer
onready var gun: Gun = $RingGun
onready var mouse_helper: Sprite = $MouseHelper

func _ready():
	gun.MASK_BIT = gun.HurtboxMaskBit.PLAYER

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("rotate"):
		gun.rotate_gun()
		mouse_helper.rotate_mouse()

func _physics_process(delta: float) -> void:
	jumped = false
	var run_strength := get_run_strength()
	apply_horizontal_force(run_strength, delta)
	apply_friction(run_strength)
	apply_gravity(delta)
	jump_check()
	move()


func get_run_strength() -> float:
	return Input.get_action_strength("right") - Input.get_action_strength("left")


func apply_horizontal_force(run_strength: float, delta: float):
	motion.x += run_strength * ACCELERATION * delta
	if Input.is_action_pressed("run"):
		motion.x = clamp(motion.x, -MAX_RUN_SPEED, MAX_RUN_SPEED)
	else:
		motion.x = clamp(motion.x, -MAX_WALK_SPEED, MAX_WALK_SPEED)


# We chose to apply the same friction in the air because it was annoying to
# keep drifting in the air after letting go of the movement keys.
func apply_friction(run_strength: float) -> void:
	if run_strength == 0:
		motion.x = lerp(motion.x, 0, FRICTION)


# We chose to also have the same up and down terminal speed, but this may change.
func apply_gravity(delta: float) -> void:
	motion.y += GRAVITY * delta
	motion.y = clamp(motion.y, -TERMINAL_SPEED, TERMINAL_SPEED)


func jump_check() -> void:
	if is_on_floor() or jump_delay_timer.time_left > 0:
		if Input.is_action_just_pressed("up"):
			motion.y = -JUMP_FORCE
			jumped = true
	else:
		# Depending on how long the player held "up", jump 1-4 blocks
		if Input.is_action_just_released("up"):
			if motion.y < -JUMP_FORCE / 4:
				motion.y = -JUMP_FORCE / 4
			elif motion.y < -JUMP_FORCE / 3:
				motion.y = -JUMP_FORCE / 3
			elif motion.y < -JUMP_FORCE / 2:
				motion.y = -JUMP_FORCE / 2


func move() -> void:
	var was_on_floor := is_on_floor()
	#var was_in_air := not is_on_floor()
	#var last_motion := motion
	var last_position := position
	
	motion = move_and_slide(motion, Vector2.UP)
	
	# If Player is in the air but hasn't jumped (fell off a platform),
	# allow a small window where the player hovers and can still jump.
	if was_on_floor and not is_on_floor() and not jumped:
		motion.y = 0
		position.y = last_position.y
		jump_delay_timer.start()


func _on_Hurtbox_hit(damage: int) -> void:
	stats.health -= damage
