extends "res://weapons/guns/Gun.gd"
# The basic gun fires a basic bullet four times per second.

const BasicBullet := preload("res://weapons/bullets/basic/BasicBullet.tscn")

export (int) var BULLET_SPEED


func instance_bullet(Bullet_: PackedScene) -> Bullet:
	var bullet = .instance_bullet(Bullet_)
	bullet.motion = Vector2.RIGHT.rotated(rotation) * BULLET_SPEED
	bullet.init_check()
	return bullet


func fire() -> void:
	.fire()
	# warning-ignore:return_value_discarded
	instance_bullet(BasicBullet)
