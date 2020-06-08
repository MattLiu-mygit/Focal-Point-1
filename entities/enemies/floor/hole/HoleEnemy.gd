extends "res://entities/enemies/floor/FloorEnemy.gd"

var main_instances = ResourceLoader.main_instances
var on_player = false
var mask_activated = false

onready var hole_timer = $HoleTimer
onready var fall_kill_timer = $FallKillTimer


func follow_mouse() -> void:
	var player = main_instances.player
	
	if on_player and player != null:
		player.set_collision_mask_bit(0, false)
		motion = move_and_slide(motion, Vector2.UP)
		on_player = false
		hole_timer.start()
		mask_activated = true
	else:
		.follow_mouse()
		
	#if player != null:
	#	mask_activated = false


func _on_Hitbox_area_entered(_area: Area2D) -> void:
	on_player = true


func _on_Hitbox_body_entered(_body: Node) -> void:
	on_player = true


func _on_HoleTimer_timeout() -> void:
	var player = main_instances.player
	player.set_collision_mask_bit(0, true)
	fall_kill_timer.start()


func _on_FallKillTimer_timeout() -> void:
	var player = main_instances.player
	if player.motion.y == player.TERMINAL_SPEED:
		player.stats.health -= player.stats.health
