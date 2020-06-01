extends RayCast2D

var last_angle: float

onready var sprite: Sprite = $Sprite
onready var hitbox_collider: CollisionShape2D = $Hitbox/Collider


func _physics_process(_delta: float) -> void:
	rotation = get_parent().get_local_mouse_position().angle() - deg2rad(90)
	if is_colliding():
		update_laser()


func update_laser() -> void:
	var collision_point := get_collision_point()
	var length = (collision_point - global_position).length()
	sprite.scale.y = length
	hitbox_collider.shape.length = length


func rotate_slowly() -> void:
	pass
