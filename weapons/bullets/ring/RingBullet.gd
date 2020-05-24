extends Bullet
# The RingBullet is a bullet that travels in an elliptical path with respect
# to the position of the mouse at fire time. The ellipse is made by taking the
# x-position of the mouse as the radius of the x-axis of the ellipse, and the
# y-axis is the relative y-position from the Player to the mouse.
# The RingBullet travels in an elliptical path by accelerating to the opposite
# point of the current location on the ellipse.

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
