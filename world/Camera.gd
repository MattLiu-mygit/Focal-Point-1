extends Camera2D
# The Camera plays an important role in aiming because it can add more
# space when the Player is limited by the screen's size.

export (Vector2) var WINDOW_SIZE
export (int) var HORIZONTAL_SCROLL
export (int) var VERTICAL_SCROLL


func _ready() -> void:
	ResourceLoader.main_instances.camera = self


func _process(_delta: float) -> void:
	var center : Vector2 = WINDOW_SIZE / 2
	# Scope similar to Terraria's Sniper Scope accessory
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


func queue_free() -> void:
	ResourceLoader.main_instances.camera = null
	.queue_free()
