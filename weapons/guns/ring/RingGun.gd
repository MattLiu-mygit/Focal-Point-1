extends Gun

# The ring gun fires a ring bullet that moves in an elliptical path.
# It also hits where the mouse is pointed at, but continues curving

const RingBullet := preload("res://weapons/bullets/ring/RingBullet.tscn")


func set_gun_rotation(_mouse_angle: float) -> void:
	var mouse_position = get_parent().get_local_mouse_position()
	if mouse_position.y <= 0:
		rotation = deg2rad(-90)
	else:
		rotation = deg2rad(90)


func instance_bullet(Bullet_: PackedScene) -> Bullet:
	var bullet := .instance_bullet(Bullet_)

	bullet.center = Vector2(get_global_mouse_position().x, global_position.y)
	var mouse_position = get_parent().get_local_mouse_position()
	if mouse_position.y <= 0:
		# 1.4 is a magic number that makes this work
		bullet.motion = Vector2(0, -abs(mouse_position.y) * 1.4)
	else:
		bullet.motion = Vector2(0, abs(mouse_position.y) * 1.4)		
	return bullet


func fire() -> void:
	.fire()
	# warning-ignore:return_value_discarded
	instance_bullet(RingBullet)
