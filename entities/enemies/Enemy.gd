extends KinematicBody2D
class_name Enemy

export(int) var SPEED = 15

var motion = Vector2.ZERO

onready var stats = $EnemyStats


func _on_Hurtbox_hit(damage: int) -> void:
	stats.health -= damage


func _on_EnemyStats_enemy_died() -> void:
	queue_free()
