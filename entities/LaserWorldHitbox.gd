extends "res://entities/Hitbox.gd"


var colliding = false

onready var collider : CollisionShape2D = $Collider
# Gets the scale of the laser sprite.
onready var laser_scale := get_parent().get_parent().get_parent()
onready var original_size : float = laser_scale.scale.y


# When colliding, laser scale sheaths. When not colliding, laser increases length.
func _process(_delta) -> void:
	if not colliding and laser_scale.scale.y < original_size:
		laser_scale.scale.y += 0.4
		
	if colliding and laser_scale.scale.y > 10:
		laser_scale.scale.y -= 1


func _on_WorldHitbox_area_entered(_area) -> void:
	colliding = true


func _on_WorldHitbox_body_entered(_body) -> void:
	colliding = true


func _on_WorldHitbox_area_exited(_area) -> void:
	colliding = false


func _on_WorldHitbox_body_exited(_body) -> void:
	colliding = false
