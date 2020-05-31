extends "res://entities/Hitbox.gd"


var colliding = false

onready var collider: CollisionShape2D = $Collider
# Gets the scale of the laser sprite.
onready var laser_sprite: Sprite = get_parent().get_parent().get_parent()
onready var original_size: float = laser_sprite.scale.y


# When colliding, laser scale sheaths. When not colliding, laser increases length.
func _process(_delta: float) -> void:
	if not colliding and laser_sprite.scale.y < original_size:
		laser_sprite.scale.y += 0.4
		
	if colliding and laser_sprite.scale.y > 10:
		laser_sprite.scale.y -= 1


func _on_WorldHitbox_area_entered(_area: Area2D) -> void:
	colliding = true


func _on_WorldHitbox_body_entered(_body: StaticBody2D) -> void:
	colliding = true


func _on_WorldHitbox_area_exited(_area: Area2D) -> void:
	colliding = false


func _on_WorldHitbox_body_exited(_body: StaticBody2D) -> void:
	colliding = false
