extends Node2D
# The World is the Room loader and the scene where gameplay takes place.

var mouse_cursor := load("res://MouseCursor.png")
# Assigned when level is selected and when transitioning levels
var player_stats = ResourceLoader.player_stats

onready var camera: Camera2D = $Camera
onready var player: Player = $Player
onready var room: Room = $TestingRoom


func _ready() -> void:
	if player_stats.selected_level != null:
		set_room(player_stats.selected_level)
	Input.set_custom_mouse_cursor(mouse_cursor)


func set_room(room_: PackedScene):
	if room:
		remove_child(room)
		room.queue_free()
	room = room_.instance()
	add_child(room)
	player.position = room.player_start_position
