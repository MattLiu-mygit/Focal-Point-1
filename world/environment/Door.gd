extends Area2D

var world: Node = ResourceLoader.main_instances.world

func _on_body_entered(body: Node) -> void:
	if body is Player:
		world.set_room(world.room.next_room)
