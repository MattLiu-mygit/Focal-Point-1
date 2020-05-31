extends Camera2D

export (Vector2) var WINDOW_SIZE
export (int) var HORIZONTAL_SCROLL
export (int) var VERTICAL_SCROLL


func _process(_delta: float) -> void:
	var center : Vector2 = WINDOW_SIZE / 2	
	if Input.is_action_pressed("scope"):
		smoothing_enabled = false
		var mouse_position := get_local_mouse_position()
		position.x = clamp(((mouse_position.x - center.x) / center.x) * HORIZONTAL_SCROLL,
							 -HORIZONTAL_SCROLL, HORIZONTAL_SCROLL)
		position.y = clamp(((mouse_position.y - center.y) / center.y) * VERTICAL_SCROLL, 
							 -VERTICAL_SCROLL, VERTICAL_SCROLL)
	if Input.is_action_just_released("scope"):
		position = Vector2.ZERO
		smoothing_enabled = true
