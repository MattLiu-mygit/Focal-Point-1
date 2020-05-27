extends Gun
# The basic gun fires a basic bullet four times per second.

const BasicBullet := preload("res://weapons/bullets/basic/BasicBullet.tscn")

func instance_bullet(Bullet_: PackedScene) -> Bullet:
	var bullet = .instance_bullet(Bullet_)
	bullet.motion = Vector2.RIGHT.rotated(rotation) * BULLET_SPEED#go to parent node to find right position?
	bullet.rotation = rotation_degrees
	
	# For rotation degrees between -90 and 90, and the character is flipped,
	# the bullet x direction is reversed as the rotation of the character is 
	# independent of the gun fixed this by checking to see if the character is 
	# flipped and modifying the x direction if flipped and between -90 and 90
	# An idea is to give firing abilities to the enemy rather than the gun(see
	# player shooting code in MetroidVania), as this allows us to access the
	# player sprite's(or in this case the enemy sprite) orientation to modify
	# bullet positioning.
	if rotation_degrees < 90 and rotation_degrees > -90 and orientationX == -1:
		bullet.motion.x *= -1
	bullet.collision_test()
	
	return bullet


func fire() -> void:
	.fire()
	# warning-ignore:return_value_discarded
	instance_bullet(BasicBullet)
