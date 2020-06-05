extends Node2D

enum Drop {
	HEALTH,
	KEY
}

const Health := preload("res://world/powerups/HealthPowerup.tscn")
const Key := preload("res://world/powerups/Key.tscn")

export (Array, Drop) var drops


func _exit_tree() -> void:
	for drop_id in drops:
		match drop_id:
			Drop.HEALTH:
				instance_drop(Health)
			Drop.KEY:
				instance_drop(Key)


func add_drop(drop_id: int):
	assert(0 <= drop_id < Drop.size())
	drops.append(drop_id)


func instance_drop(drop_: PackedScene):
	var room: Room = ResourceLoader.main_instances.world.room
	var spawn_position = get_parent().global_position
	var drop = drop_.instance()
	drop.global_position = spawn_position + Vector2(rand_range(-4, 4), rand_range(-4, 4))
	room.call_deferred("add_child", drop)
