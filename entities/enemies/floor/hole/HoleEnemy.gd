extends "res://entities/enemies/floor/FloorEnemy.gd"

# Hole enemy has player falling through it. Only works with platoforms and floors of depth 1.

export (int) var DEPTH_BY_TILE = 1

var main_instances = ResourceLoader.main_instances
var on_player = false

onready var fall_kill_timer = $FallKillTimer


func follow_mouse() -> void:
	var player = main_instances.player
	if player != null:
		
		# If player steps on hole enemy, player doesn't collide with world.
		# Player x motion set to 0 to prevent bug where the player gets stuck
		# in an edge or accidentally crosses some kind of gap when the 
		# collsion mask is reinstated.
		if on_player:
			player.set_collision_mask_bit(0, false)
			player.motion.x = 0
		else:
			.follow_mouse()
		
		# Once the player clears one layer of tileset, reinstate player world
		# collsion.
		if player.position.y > position.y + 25 + (DEPTH_BY_TILE * 16):
			on_player = false
			player.set_collision_mask_bit(0, true)
			fall_kill_timer.start()


func _on_Hitbox_area_entered(_area: Area2D) -> void:
	on_player = true


func _on_Hitbox_body_entered(_body: Node) -> void:
	on_player = true


# If the player falls for more than 3 seconds and has hit terminal speed, it's
# safe to assume it died or the fall would kill him. Also there shouldn't be
# any 3 second falls
func _on_FallKillTimer_timeout() -> void:
	var player = main_instances.player
	if player.motion.y == player.TERMINAL_SPEED:
		player.stats.health -= player.stats.health
