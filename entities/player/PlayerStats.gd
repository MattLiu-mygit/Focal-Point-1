extends Resource
class_name PlayerStats


export (int) var max_health := 3
var health := max_health setget set_health


func set_health(value: int):
	# warning-ignore:narrowing_conversion
	health = clamp(value, 0, max_health)
