extends Node2D
class_name Room
# A Room is a single screen of the Player, Enemies, and other platforms. It is a
# sort of mini-level.

export (Vector2) var player_start_position
export (PackedScene) var next_room


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("temp_next_level"):
		var world = get_parent()
		world.set_room(next_room)
