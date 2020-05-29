extends Enemy

onready var laser = $Sprite
onready var hurtbox = $Hurtbox

# Basically rotates the beam so that it's pointed at the mouse.
func _process(delta):
	laser.rotation = get_local_mouse_position().angle() + deg2rad(90)
	hurtbox.rotation = get_local_mouse_position().angle() + deg2rad(90)
