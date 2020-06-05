extends KinematicBody2D
class_name Enemy

export(int) var SPEED = 15

var motion = Vector2.ZERO

onready var stats = $EnemyStats


func ready() -> void:
	set_physics_process(false)


func die() -> void:
	queue_free()


func _on_Hurtbox_hit(damage: int, _spot: Vector2) -> void:
	stats.health -= damage


func _on_EnemyStats_enemy_died() -> void:
	die()
