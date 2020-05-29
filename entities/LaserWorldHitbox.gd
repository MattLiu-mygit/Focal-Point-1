extends "res://entities/Hitbox.gd"

onready var collider = $Collider
var colliding = false

# When colliding, laser scale sheaths. When not colliding, laser increases length.
func _process(delta):
	if colliding == false and get_parent().get_parent().get_parent().scale.y < 150:
		get_parent().get_parent().get_parent().scale.y += 0.1
		
	if colliding == true and get_parent().get_parent().get_parent().scale.y > 10:
		get_parent().get_parent().get_parent().scale.y -= 1

func _on_WorldHitbox_area_entered(area):
	colliding = true


func _on_WorldHitbox_body_entered(body):
	colliding = true


func _on_WorldHitbox_area_exited(area):
	colliding = false


func _on_WorldHitbox_body_exited(body):
	colliding = false

