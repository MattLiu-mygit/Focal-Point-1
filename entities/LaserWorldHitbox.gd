extends "res://entities/Hitbox.gd"

onready var collider = $Collider
var colliding = false
onready var originalSize = get_parent().get_parent().get_parent().scale.y
onready var laserScale = get_parent().get_parent().get_parent()

# When colliding, laser scale sheaths. When not colliding, laser increases length.
func _process(delta):
	if colliding == false and laserScale.scale.y < originalSize*0.8:
		laserScale.scale.y += 0.4
		
	if colliding == true and laserScale.scale.y > 10:
		laserScale.scale.y -= 1

func _on_WorldHitbox_area_entered(area):
	colliding = true


func _on_WorldHitbox_body_entered(body):
	colliding = true


func _on_WorldHitbox_area_exited(area):
	colliding = false


func _on_WorldHitbox_body_exited(body):
	colliding = false

