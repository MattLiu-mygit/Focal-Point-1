extends Sprite
# The MouseHelper is a cursor that shows the relative position of the
# mouse with respect to the current rotation. Bullets will target this 
# cursor instead of the mouse because everything is relative to the mouse.

<<<<<<< HEAD
var mouse_rotation:= 0
=======
var mouse_rotation := 0 setget set_mouse_rotation
>>>>>>> be8cb45f034842d0b5d1630d8d463c6edacf910d


func _process(_delta: float) -> void:
	var parent := get_parent()
	var mouse_position : Vector2 = parent.get_local_mouse_position().rotated(deg2rad(mouse_rotation * 90))
	position = mouse_position


func rotate_mouse() -> void:
	mouse_rotation = (mouse_rotation + 1) % 4
	visible = mouse_rotation != 0


func set_mouse_rotation(multiple: int):
	while mouse_rotation != multiple:
		rotate_mouse()
