extends Gun

const ReflectBullet := preload("res://weapons/bullets/reflect/ReflectBullet.tscn")


func instance_bullet(Bullet_: PackedScene) -> Bullet:
	var bullet = .instance_bullet(Bullet_)
	bullet.motion = Vector2.RIGHT.rotated(rotation) * BULLET_SPEED
	bullet.rotation = rotation
	bullet.collision_test()
	return bullet


func fire() -> void:
	.fire()
	# warning-ignore:return_value_discarded
	instance_bullet(ReflectBullet)


func _on_AutoFireTimer_timeout() -> void:
	instance_bullet(ReflectBullet)
