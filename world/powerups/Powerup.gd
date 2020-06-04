extends Area2D
# A "powerup" is anything in a Room that the Player can pick up and that 
# disappears after being collected.

var player_stats = ResourceLoader.player_stats


func _on_body_entered(body: Node) -> void:
	if body is Player:
		activate()


func activate() -> void:
	queue_free()
