extends Node

export (int) var max_health = 1

onready var health : int = max_health setget set_health

signal enemy_died

func set_health(value: int):
	# warning-ignore:narrowing_conversion
	health = clamp(value, 0, max_health)
	if health == 0:
		emit_signal("enemy_died")
