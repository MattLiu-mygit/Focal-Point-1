extends "res://entities/enemies/floor/FloorEnemy.gd"

var main_instances = ResourceLoader.main_instances
var on_player = false

onready var hole_timer = $HoleTimer


func follow_mouse() -> void:
	var player = main_instances.player
	
	if on_player and player != null:
		player.set_collision_mask_bit(0, false)
		motion = move_and_slide(motion, Vector2.UP)
		on_player = false
		hole_timer.start()
	else:
		.follow_mouse()


func _on_Hitbox_area_entered(_area: Area2D) -> void:
	on_player = true


func _on_Hitbox_body_entered(_body: Node) -> void:
	on_player = true


func _on_HoleTimer_timeout() -> void:
	var player = main_instances.player
	player.set_collision_mask_bit(0, true)
