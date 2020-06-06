extends "res://entities/enemies/floor/FloorEnemy.gd"

export (float) var SLOW_PERCENT = 25

var main_instances = ResourceLoader.main_instances
var attached_to_player = false


func follow_mouse() -> void:
	var player = main_instances.player
	
	if attached_to_player and player != null:
		motion.x = 0
		player.motion.x /= (1.0 + SLOW_PERCENT / 100.0)
		position.x = player.global_position.x
		position.y = player.global_position.y
		motion = move_and_slide(motion, Vector2.UP)
	else:
		.follow_mouse()


func _on_Hitbox_area_entered(_area: Area2D) -> void:
	attached_to_player = true


func _on_Hitbox_body_entered(_body: Node) -> void:
	attached_to_player = true
