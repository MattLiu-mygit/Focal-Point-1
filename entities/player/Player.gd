extends "res://entities/Entity.gd"
class_name Player
# The Player scene has everything relating to controlling the character.
# Current mechanics:
# Player can jump over horizontal gaps:
#	4-block = no speed
#	5-block = walking speed
#	10-block (11 barely) = running speed
# Player can jump onto vertical heights:
#	1 to 4-block = depends on how long jump is held

const PLAYER_HURTBOX_LAYER_BIT := 3
const TILE_PLATFORM := 1
const PLAYER_XRADIUS := 8

export (int) var ACCELERATION = 640
export (int) var MAX_WALK_SPEED = 128
export (int) var MAX_RUN_SPEED = 192
export (float) var FRICTION = 0.25
export (int) var KNOCKBACK_FORCE = 192
export (int) var GRAVITY = 832
export (int) var TERMINAL_SPEED = 1024
export (int) var JUMP_FORCE = 336

var stats = ResourceLoader.player_stats
var motion := Vector2.ZERO
var jumped := false
var knocked_back := false
var invincible := false setget set_invincible

onready var hurtbox: Area2D = $Hurtbox
onready var guns: Node = $PlayerGuns
onready var jump_delay_timer: Timer = $JumpDelayTimer
onready var mouse_helper: Sprite = $MouseHelper


func _ready() -> void:
	stats.connect("player_died", self, "_on_died")
	stats.connect("player_game_over", self, "_on_game_over")
	ResourceLoader.main_instances.player = self


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("temp_invincible"):
		turn_invincible(5)


func _physics_process(delta: float) -> void:
	jumped = false
	if not knocked_back:
		var run_strength := get_run_strength()
		apply_horizontal_force(run_strength, delta)
		apply_friction(run_strength)
	apply_gravity(delta)
	jump_check()
	drop_check()
	move()


func queue_free() -> void:
	ResourceLoader.main_instances.player = null
	.queue_free()


func get_run_strength() -> float:
	return Input.get_action_strength("right") - Input.get_action_strength("left")


func apply_horizontal_force(run_strength: float, delta: float) -> void:
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
		if Input.is_action_just_released("up"):
			cut_jump()


# If Player releases jump, cut the jump short.
func cut_jump():
	if motion.y < -JUMP_FORCE / 4:
		motion.y = -JUMP_FORCE / 4
	elif motion.y < -JUMP_FORCE / 3:
		motion.y = -JUMP_FORCE / 3
	elif motion.y < -JUMP_FORCE / 2:
		motion.y = -JUMP_FORCE / 2


# If only on a platform, drop a pixel to bypass the one-way-collision
func drop_check() -> void:
	var tile_map: TileMap = ResourceLoader.main_instances.world.room.get_node("TileMap")
	var left_tile := tile_map.get_cellv(tile_map.world_to_map(global_position + Vector2(-PLAYER_XRADIUS, 0)))
	var center_tile := tile_map.get_cellv(tile_map.world_to_map(global_position))
	var right_tile := tile_map.get_cellv(tile_map.world_to_map(global_position + Vector2(PLAYER_XRADIUS, 0)))
	if Input.is_action_pressed("down") and is_on_floor() and only_platforms(left_tile, center_tile, right_tile):
		position.y += 1
		jumped = true
	# ATTENTION: We set jumped to true here because it's pretty much the same


# Check all tiles under the player are platforms or blank space
func only_platforms(left_tile: int, center_tile: int, right_tile: int):
	# -1 means blank space, no tile
	return ((left_tile == -1 or left_tile == TILE_PLATFORM) and
	(center_tile == -1 or center_tile == TILE_PLATFORM) and
	(right_tile == -1 or right_tile == TILE_PLATFORM))


func move() -> void:
	var was_on_floor := is_on_floor()
	#var was_in_air := not is_on_floor()
	#var last_motion := motion
	var last_position := position
	
	motion = move_and_slide(motion, Vector2.UP)
	
	# If Player is in the air but hasn't jumped (fell off a platform),
	# allow a small window where the player can still jump.
	if was_on_floor and not is_on_floor() and not jumped:
		position.y = last_position.y
		jump_delay_timer.start()
	
	# Remove knockback effect if landed.
	if is_on_floor():
		if knocked_back:
			knocked_back = false
			guns.enabled = true


func hit(damage: int, spot: Vector2) -> void:
	stats.health -= damage
	if damage > 0:
		knockback(spot)
		guns.enabled = false


# Launch the Player depending on where the Player was hit.
func knockback(spot: Vector2) -> void:
	knocked_back = true
	var x := global_position.x
	if spot.x - x > 0:
		motion.x = -KNOCKBACK_FORCE
	elif spot.x - x < 0:
		motion.x = KNOCKBACK_FORCE
	if is_on_floor():
		motion.y = -KNOCKBACK_FORCE / 2


func replenish_health() -> void:
	if stats.total_health > 0:
		stats.health = stats.total_health
		stats.total_health -= stats.max_health

func turn_invincible(duration: float):
	if not invincible:
		set_invincible(true)
		yield(get_tree().create_timer(duration), "timeout")
		set_invincible(false)


func set_invincible(value: bool) -> void:
	invincible = value
	hurtbox.set_collision_layer_bit(PLAYER_HURTBOX_LAYER_BIT, not value)


func die() -> void:
	replenish_health()


func game_over() -> void:
	pass


func _on_Hurtbox_hit(damage: int, spot: Vector2) -> void:
	hit(damage, spot)


func _on_died() -> void:
	die()


func _on_game_over() -> void:
	game_over()


func _on_PlayerGuns_gun_rotated() -> void:
	mouse_helper.set_mouse_rotation(guns.get_gun_rotation())


func _on_PlayerGuns_gun_swapped() -> void:
	mouse_helper.set_mouse_rotation(guns.get_gun_rotation())
