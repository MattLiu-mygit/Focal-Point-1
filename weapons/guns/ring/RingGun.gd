extends Gun
# The RingGun fires a RingBullet that moves in an elliptical path.
# It hits where the mouse is pointed at, but continues curving. Its rotation
# always points to the path that the ellipse will travel in.

<<<<<<< HEAD
const RingBullet:= preload("res://weapons/bullets/ring/RingBullet.tscn")
=======
const RingBullet := preload("res://weapons/bullets/ring/RingBullet.tscn")
>>>>>>> be8cb45f034842d0b5d1630d8d463c6edacf910d


func set_gun_rotation(_mouse_angle: float) -> void:
	var mouse_position = get_parent().get_local_mouse_position()
	if mouse_position.y <= 0:
		rotation = deg2rad(-90 + gun_rotation * 90)
		if mouse_position.x >= 0:
			rotation += deg2rad(15)
		else:
			rotation += deg2rad(-15)
	else:
		rotation = deg2rad(90 + gun_rotation * 90)
		if mouse_position.x >= 0:
			rotation += deg2rad(-15)
		else:
			rotation += deg2rad(15)


func instance_bullet(Bullet_: PackedScene) -> Bullet:
	var bullet := .instance_bullet(Bullet_)

	# We only use the global x position for the radius, y is the y-coord of the gun
	bullet.center = (global_position + 
			(Vector2(get_global_mouse_position().x, global_position.y) - 
			global_position).rotated(deg2rad(gun_rotation * 90)))
	var mouse_position = get_parent().get_local_mouse_position()
	if mouse_position.y <= 0:
		# 1.4 is a magic number that makes this work
		bullet.motion = Vector2(0, -abs(mouse_position.y) * 1.4).rotated(deg2rad(gun_rotation * 90))
	else:
		bullet.motion = Vector2(0, abs(mouse_position.y) * 1.4).rotated(deg2rad(gun_rotation * 90))
	return bullet


func fire() -> void:
	.fire()
	# warning-ignore:return_value_discarded
	instance_bullet(RingBullet)
