extends Node2D

enum Drop {
	HEALTH,
	KEY
}

const Health := preload("res://world/powerups/HealthPowerup.tscn")
const Key := preload("res://world/powerups/Key.tscn")

export (Array, Drop) var drops


func release_drops() -> void:
	var origin = get_parent().global_position
	for drop_id in drops:
		var spawn_position = origin + Vector2(rand_range(-4, 4), rand_range(-4, 4))
		var scene: PackedScene = null
		match drop_id:
			Drop.HEALTH:
				scene = Health
			Drop.KEY:
				scene = Key
		# warning-ignore:return_value_discarded
		Utils.instance_scene_in_room(scene, spawn_position)


func add_drop(drop_id: int):
	assert(0 <= drop_id < Drop.size())
	drops.append(drop_id)
