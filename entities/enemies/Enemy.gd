extends KinematicBody2D
class_name Enemy

# Setting up common enemy elements
onready var stats = $EnemyStats
export(int) var MAX_SPEED = 15
var motion = Vector2.ZERO

func _on_Hurtbox_hit(damage: int) -> void:
	stats.health -= damage

func _on_EnemyStats_enemy_died():
	queue_free()
