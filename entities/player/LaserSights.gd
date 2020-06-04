extends RayCast2D
# Another helper to show the path of the bullet, may or may not keep.

onready var sprite: Sprite = $Sprite


func _physics_process(_delta: float) -> void:
	rotation = get_parent().get_local_mouse_position().angle() - deg2rad(90)	
	if is_colliding():
		var collision_point := get_collision_point()
		var length = (collision_point - global_position).length()
		sprite.scale.y = length
