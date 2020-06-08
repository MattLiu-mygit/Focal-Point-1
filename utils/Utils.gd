extends Node
# This script contains useful methods that don't belong to a particular node.

var mouse_cursor := load("res://MouseCursor.png")

func _ready() -> void:
	Input.set_custom_mouse_cursor(mouse_cursor)
	VisualServer.set_default_clear_color(Color.black)


func instance_scene_on_main(scene: PackedScene, position: Vector2) -> Node:
	var main := get_tree().current_scene
	var instance := scene.instance()
	main.add_child(instance)
	instance.global_position = position
	return instance


func instance_scene_in_room(scene: PackedScene, position: Vector2) -> Node:
	var world : Node = ResourceLoader.main_instances.world
	var instance := scene.instance()
	# Ignoring area_set_shape_disabled error here... doesn't seem to cause any problems.
	world.room.add_child(instance)
	instance.global_position = position
	return instance


# Z-indexes:
# -3 - Door
# -2 - Laser
# -1 - Bullets
# 0 - Everything else
