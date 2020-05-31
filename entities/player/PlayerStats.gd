extends Resource
class_name PlayerStats
# This class contains all of the Player's relevant game data.

export (int) var max_health := 3
var health := max_health setget set_health
<<<<<<< HEAD
=======
var selected_level: PackedScene = null
# Various unlockable perks
var basic_gun_unlocked := false
>>>>>>> be8cb45f034842d0b5d1630d8d463c6edacf910d
var ring_gun_unlocked := false
var reflect_gun_unlocked := false
var rotate_gun_unlocked := false
var laser_sights_unlocked := false
<<<<<<< HEAD
=======
var scope_unlocked := false
>>>>>>> be8cb45f034842d0b5d1630d8d463c6edacf910d

func set_health(value: int):
	# warning-ignore:narrowing_conversion
	health = clamp(value, 0, max_health)
