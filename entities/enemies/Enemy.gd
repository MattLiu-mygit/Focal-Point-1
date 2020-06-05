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


# VisibilityNotifier2Ds set so that enemies tracking players don't track the
# player before the players see the enemies. Good for setting up levels.
# Disconnected rn because there's a signal calling error, but may need to be 
# connected in the future.
func _on_VisibilityNotifier2D_screen_entered() -> void:
	set_physics_process(true)
