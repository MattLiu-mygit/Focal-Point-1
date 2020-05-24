extends Bullet
# The PhysicsBullet is a bullet that falls due to gravity and bounces

export (int) var GRAVITY = 832
export (float) var BOUNCINESS = 0.25
export (int) var BOUNCES = 2

var bounces := 0


func update_motion(delta: float) -> void:
	motion.y += GRAVITY


func handle_kinematic_collision(collision: KinematicCollision2D) -> void:
	var normal := collision.normal
	if bounces < BOUNCES:
		motion = motion.reflect(normal.rotated(deg2rad(90)))
		rotation = motion.angle()
		bounces += 1
	else:
		queue_free()
