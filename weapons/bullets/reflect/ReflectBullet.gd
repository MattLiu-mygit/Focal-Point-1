extends Bullet

export (int) var BOUNCES = 3

var bounces := 0

onready var raycast: RayCast2D = $RayCast2D


func _physics_process(delta: float) -> void:
	._physics_process(delta)
	if raycast.is_colliding():
		handle_raycast_collision()

func collision_test() -> void:
	.collision_test()
	if raycast.is_colliding():
		handle_raycast_collision()


func handle_raycast_collision() -> void:
	var normal := raycast.get_collision_normal()
	if bounces < BOUNCES:
		motion = motion.reflect(normal.rotated(deg2rad(90)))
		rotation = motion.angle()
		bounces += 1
	else:
		queue_free()
