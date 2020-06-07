extends Area2D

var player_stats = ResourceLoader.player_stats


func _on_body_entered(body: Node) -> void:
	if body is Enemy:
		body.die()
	elif body is Player:
		player_stats.health -= 1
		player_stats.emit_signal("player_fell")
