extends Sprite


var mouse_rotation := 0


func _process(_delta: float) -> void:
	var parent := get_parent()
	var mouse_position : Vector2 = parent.get_local_mouse_position().rotated(deg2rad(mouse_rotation * 90))
	position = mouse_position


func rotate_mouse() -> void:
	mouse_rotation = (mouse_rotation + 1) % 4
	visible = mouse_rotation != 0
