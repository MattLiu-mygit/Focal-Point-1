extends Node
# The World is the Room loader and the scene where gameplay takes place.

# Assigned when level is selected and when transitioning levels
var player_stats = ResourceLoader.player_stats
var current_room : PackedScene

onready var camera: Camera2D = $Camera
onready var player: Player = $Player
onready var room: Room = $TestingRoom


func _ready() -> void:
	if player_stats.selected_level != null:
		set_room(player_stats.selected_level)


func set_room(room_: PackedScene):
	if room:
		call_deferred("remove_child", room)
		room.queue_free()
	current_room = room_
	room = room_.instance()
	call_deferred("add_child", room)
	player.position = room.player_start_position
