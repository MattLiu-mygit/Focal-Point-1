extends KinematicBody2D
class_name Enemy

onready var stats = $EnemyStats


func _on_Hurtbox_hit(damage: int) -> void:
	stats.health -= damage
