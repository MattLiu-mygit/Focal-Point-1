extends Control
# The LevelSelctMenu not only provides an interface for the Player to select
# a level, but also sets Player stats based on which level they chose.

const Game: PackedScene = preload("res://Game.tscn")
const Level0: PackedScene = preload("res://world/levels/level0/Room1.tscn")

var levels := [Level0]
var selected_level: int = 0
var player_stats = ResourceLoader.player_stats


# Sets player stats such as weapons available based on selected_level
func set_player_stats() -> void:
	player_stats.selected_level = levels[selected_level]


func _on_SelectButton_pressed() -> void:
	set_player_stats()
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(Game)


func _on_LeftButton_pressed() -> void:
	selected_level = (selected_level - 1) % len(levels)


func _on_RightButton_pressed() -> void:
	selected_level = (selected_level + 1) % len(levels)
