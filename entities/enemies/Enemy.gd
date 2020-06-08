extends KinematicBody2D
class_name Enemy

signal enemy_died

export (int) var SPEED = 50
export (bool) var DEFEATABLE

var motion = Vector2.ZERO

onready var stats = $EnemyStats
onready var drops = $Drops


func hit(damage: int, _spot: Vector2) -> void:
	stats.health -= damage


func die() -> void:
	queue_free()
	drops.release_drops()
	emit_signal("enemy_died")


func _on_Hurtbox_hit(damage: int, spot: Vector2) -> void:
	hit(damage, spot)


func _on_EnemyStats_enemy_died() -> void:
	die()
