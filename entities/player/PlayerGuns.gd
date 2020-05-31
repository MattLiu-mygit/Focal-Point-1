extends Node
# This is a node that contains all of the Player's guns and controls swapping
# of weapons.

var player_stats : Resource = ResourceLoader.player_stats

onready var guns := [$BasicGun]
onready var current_gun : Gun = $BasicGun


# TODO: Available guns is related to level
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
