extends Bullet

var center := Vector2.ZERO


func _physics_process(delta: float) -> void:
	._physics_process(delta)


func update_motion(delta: float) -> void:
	.update_motion(delta)
	var opposite_position := get_opposite_position(global_position)
	motion += (opposite_position - global_position) * delta


func get_opposite_position(position: Vector2) -> Vector2:
	var opposite_x := center.x + (center.x - position.x)
	var opposite_y := center.y + (center.y - position.y)
	return Vector2(opposite_x, opposite_y)


