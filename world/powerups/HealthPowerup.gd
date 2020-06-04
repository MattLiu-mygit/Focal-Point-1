extends "res://world/powerups/Powerup.gd"


func activate() -> void:
	player_stats.health += 1
	.activate()
