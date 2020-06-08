extends Area2D

var player_stats = ResourceLoader.player_stats


func _on_body_entered(body: Node) -> void:
	if body is Player:
		player_stats.emit_signal("player_cleared_room")
