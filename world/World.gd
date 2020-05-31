extends Node2D
# The World is the level loader and the scene where everything takes place.

onready var player: Player = $Player

var mouse_cursor = load("res://MouseCursor.png")


func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)
	Input.set_custom_mouse_cursor(mouse_cursor)
