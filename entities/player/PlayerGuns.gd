extends Node
# This contains all of the Player's guns and controls over weapons.

signal gun_rotated
signal gun_swapped

export (bool) var debug = false

var player_stats : Resource = ResourceLoader.player_stats
var guns := []
var gun_index := 0
var current_gun : Gun
var enabled := true setget set_guns_enabled

onready var basic_gun: Gun = $BasicGun
onready var ring_gun: Gun = $RingGun
onready var reflect_gun: Gun = $ReflectGun


# Assume player_stats should already be updated
func _ready() -> void:
	_disable(basic_gun)
	_disable(ring_gun)
	_disable(reflect_gun)
	unlock_guns()


func _process(_delta: float) -> void:
	if not enabled:
		return

	if Input.is_action_just_pressed("rotate"):
		current_gun.rotate_gun()
		emit_signal("gun_rotated")

	if Input.is_action_just_pressed("swap_right"):
		swap_next_gun()
		emit_signal("gun_swapped")
	elif Input.is_action_just_pressed("swap_left"):
		swap_previous_gun()
		emit_signal("gun_swapped")


func unlock_guns() -> void:
	if player_stats.basic_gun_unlocked or debug:
		guns.append(basic_gun)
	if player_stats.ring_gun_unlocked or debug:
		guns.append(ring_gun)
	if player_stats.reflect_gun_unlocked or debug:
		guns.append(reflect_gun)
	gun_index = 0
	current_gun = guns[0]
	_enable(current_gun)


func set_guns_enabled(value: bool):
	enabled = value
	if enabled:
		_enable(current_gun)
	else:
		_disable(current_gun)

func swap_next_gun() -> void:
	gun_index = (gun_index + 1) % len(guns)
	_disable(current_gun)
	current_gun = guns[gun_index]
	_enable(current_gun)

func swap_previous_gun() -> void:
	gun_index = (gun_index - 1) % len(guns)
	_disable(current_gun)
	current_gun = guns[gun_index]
	_enable(current_gun)


func get_gun_rotation() -> int:
	return current_gun.gun_rotation


func _enable(node: Node) -> void:
	node.set_process(true)
	node.visible = true


func _disable(node: Node) -> void:
	node.set_process(false)
	node.visible = false

