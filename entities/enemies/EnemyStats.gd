extends Node

export (int) var max_health

var health : int = max_health setget set_health


func set_health(value: int):
	# warning-ignore:narrowing_conversion
	health = clamp(value, 0, max_health)
