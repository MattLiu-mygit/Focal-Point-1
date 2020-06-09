extends "res://world/environment/Door.gd"

var locked := true

onready var locked_sprite : Sprite = $LockedSprite


func _ready() -> void:
	player_stats.connect("player_has_key_changed", self, "unlock")


func unlock(has_key: bool) -> void:
	locked = not has_key
	locked_sprite.visible = not has_key


func _on_body_entered(body: Node):
	if not locked:
		._on_body_entered(body)
