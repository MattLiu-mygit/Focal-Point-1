extends Sprite

onready var EnemyStats : Node = $EnemyStats


func _on_EnemyStats_enemy_died() -> void:
	queue_free()


func _on_Hurtbox_hit(damage: int) -> void:
	EnemyStats.health -= damage

