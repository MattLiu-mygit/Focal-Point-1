extends "res://entities/enemies/floor/FloorEnemy.gd"

var main_instances = ResourceLoader.main_instances
var attached_to_player = false


func _physics_process(delta) -> void:
	var player = main_instances.player
	
	if attached_to_player and player != null:
		motion.x = 0
		player.motion.x *= SLOW_PERCENT
		position.x = player.global_position.x
		position.y = player.global_position.y + 12
	
	motion = move_and_slide(motion, Vector2.UP) * delta


func _on_Hitbox_area_entered(_area: Area2D) -> void:
	attached_to_player = true


func _on_Hitbox_body_entered(body: Node) -> void:
	attached_to_player = true
