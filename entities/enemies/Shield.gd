extends Sprite

onready var EnemyStats = $EnemyStats

func _on_EnemyStats_enemy_died():
	queue_free()

func _on_Hurtbox_hit(damage):
	EnemyStats.health -= damage

