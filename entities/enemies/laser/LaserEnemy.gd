extends Enemy

onready var laser: Sprite = $Sprite
onready var hurtbox: Area2D = $Hurtbox


# Basically rotates the beam so that it's pointed at the mouse.
func _process(_delta: float) -> void:
	laser.rotation = get_local_mouse_position().angle() + deg2rad(90)
	hurtbox.rotation = get_local_mouse_position().angle() + deg2rad(90)
