extends "res://world/powerups/Powerup.gd"


func activate() -> void:
	player_stats.has_key = true
	.activate()
