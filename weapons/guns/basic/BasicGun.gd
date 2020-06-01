extends Gun
# The basic gun fires a basic bullet four times per second.

const BasicBullet := preload("res://weapons/bullets/basic/BasicBullet.tscn")


func instance_bullet(Bullet_: PackedScene) -> Bullet:
	var bullet = .instance_bullet(Bullet_)
	bullet.motion = Vector2.RIGHT.rotated(rotation) * BULLET_SPEED
	bullet.rotation = rotation
	bullet.collision_test()
	return bullet


func fire() -> void:
	.fire()
	# warning-ignore:return_value_discarded
	instance_bullet(BasicBullet)


func _on_AutoFireTimer_timeout() -> void:
	instance_bullet(BasicBullet)
