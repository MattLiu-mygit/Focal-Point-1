extends Room
# In MonsterRooms, all enemies must be defeated in order to advance.

var player_stats = ResourceLoader.player_stats


func _ready() -> void:
	for enemy in get_children():
		if enemy is Enemy:
			enemy.connect("enemy_died", self, "check_cleared")
	check_cleared()


func check_cleared() -> void:
	for enemy in get_children():
		if enemy is Enemy and enemy.DEFEATABLE:
			return
	player_stats.has_key = true
