extends Node

var world: Node
var player: Player
var player_stats: PlayerStats


func _ready() -> void:
	world = ResourceLoader.main_instances.world
	player = ResourceLoader.main_instances.player
	player_stats = ResourceLoader.player_stats
	# warning-ignore-all:return_value_discarded
	player_stats.connect("player_cleared_room", self, "_on_player_cleared_room")
	player_stats.connect("player_died", self, "_on_player_died")
	player_stats.connect("player_fell", self, "_on_player_fell")
	player_stats.connect("player_game_over", self, "_on_player_game_over")


func enable_player(enabled: bool):
	player.invincible = not enabled
	player.controllable = enabled


func setup_room() -> void:
	player.position = world.room.player_start_position
	player_stats.reset_stats()
	yield(get_tree().create_timer(1.0), "timeout")


func reset_room() -> void:
	enable_player(false)
	yield(get_tree().create_timer(1.0), "timeout")
	player.visible = false
	player.position = world.room.player_start_position
	player_stats.reset_stats()
	yield(get_tree().create_timer(1.0), "timeout")
	world.reset_room()
	enable_player(true)
	player.visible = true


func _on_player_cleared_room() -> void:
	world.set_room(world.room.next_room)
	setup_room()


func _on_player_died():
	reset_room()


func _on_player_fell():
	player_stats.total_health -= 1
	reset_room()


func _on_player_game_over():
	# warning-ignore:return_value_discarded
	enable_player(false)
	yield(get_tree().create_timer(3.0), "timeout")
	get_tree().change_scene("res://gui/screens/LevelSelectMenu.tscn")
