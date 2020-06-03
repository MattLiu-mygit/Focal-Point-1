extends "res://world/environment/Door.gd"

var player_stats = ResourceLoader.player_stats
var locked := true

onready var locked_sprite : Sprite = $LockedSprite


func unlock() -> void:
	locked = false
	locked_sprite.visible = false


func _on_body_entered(body: Node):
	if body is Player and player_stats.has_key and locked:
		unlock()
	if not locked:
		._on_body_entered(body)
