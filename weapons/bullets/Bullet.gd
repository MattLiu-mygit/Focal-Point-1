extends KinematicBody2D
class_name Bullet
# Bullets are responsible for controlling their own movement with update_motion.
# Once initialized from a gun, they should move in their defined pattern without
# any other modifications.

var motion := Vector2.ZERO

onready var raycast : RayCast2D = $RayCast
onready var hitbox : Area2D = $Hitbox


func _physics_process(delta: float) -> void:
	update_motion()
	move(delta)
	if raycast.is_colliding():
		handle_raycast_collision()


func init_check():
	var collision := move_and_collide(Vector2.ZERO)
	if collision:
		handle_kinematic_collision(collision)
	if raycast.is_colliding():
		handle_raycast_collision()


func update_motion() -> void:
	pass


func move(delta: float) -> void:
	var collision := move_and_collide(motion * delta)
	if collision:
		handle_kinematic_collision(collision)


func handle_raycast_collision() -> void:
	queue_free()


func handle_kinematic_collision(_collision: KinematicCollision2D) -> void:
	queue_free()


func _on_VisibilityNotifier_viewport_exited(_viewport: Viewport) -> void:
	queue_free()
