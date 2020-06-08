extends Resource
class_name PlayerStats
# This class contains all of the Player's relevant game data.

# GUI signals
signal player_health_changed(health)
signal player_total_health_changed(total_health)
signal player_has_key_changed(has_key)
# Game signals
# warning-ignore:unused_signal
signal player_fell    # emitted by KillZone
# The next two are mutually exclusive
signal player_died
signal player_game_over

var total_health := 99 setget set_total_health
var max_health := 3
var health := max_health setget set_health
var has_key := false setget set_has_key
# Various unlockable perks
var basic_gun_unlocked := true
var ring_gun_unlocked := false
var reflect_gun_unlocked := false
var rotate_gun_unlocked := false
var scope_unlocked := false
# Not related to player stats, saved for convenience
var selected_level: PackedScene = null


func set_health(value: int):
	# warning-ignore:narrowing_conversion
	health = clamp(value, 0, max_health)
	emit_signal("player_health_changed", health)
	if health == 0 and total_health == 0:
		emit_signal("player_game_over")
	elif health == 0:
		emit_signal("player_died")


func set_total_health(value: int):
	# warning-ignore:narrowing_conversion
	total_health = clamp(value, 0, 99)
	emit_signal("player_total_health_changed", total_health)


func set_has_key(value: bool):
	has_key = value
	emit_signal("player_has_key_changed", value)


func replenish_health() -> void:
	if total_health > 0:
		var old_health = health
		set_health(health + total_health)
		set_total_health(total_health - (max_health - old_health))


func reset_stats() -> void:
	self.has_key = false
	replenish_health()
