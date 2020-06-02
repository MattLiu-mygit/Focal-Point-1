extends Bullet
# The RingBullet is a bullet that travels in an elliptical path with respect
# to the position of the mouse at fire time. The ellipse is made by taking the
# x and y position of the mouse relative to the Player and using those as the
# radii for the major and minor axes.

var center := Vector2.ZERO


func _physics_process(delta: float) -> void:
	._physics_process(delta)


func update_motion(delta: float) -> void:
	.update_motion(delta)
	# We use global_position because position is always (0, 0)
	var opposite_position := get_opposite_position(global_position)
	# Accelerate towards the opposite position
	motion += (opposite_position - global_position) * delta


func get_opposite_position(position: Vector2) -> Vector2:
	var opposite_x := center.x + (center.x - position.x)
	var opposite_y := center.y + (center.y - position.y)
	return Vector2(opposite_x, opposite_y)
