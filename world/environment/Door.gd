extends Area2D


func _on_body_entered(body: Node) -> void:
	if body is Player:
		var room: Room = get_parent()
		var world: Node = room.get_parent()
		world.set_room(room.next_room)
