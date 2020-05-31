extends Resource
class_name PlayerStats
# This class contains all of the Player's relevant game data.

export (int) var max_health := 3
var health := max_health setget set_health
var selected_level: PackedScene = null
var ring_gun_unlocked := false
var reflect_gun_unlocked := false
var rotate_gun_unlocked := false
var laser_sights_unlocked := false

func set_health(value: int):
	# warning-ignore:narrowing_conversion
	health = clamp(value, 0, max_health)
