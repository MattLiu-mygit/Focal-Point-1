extends Enemy

onready var original_floor_cast_position
onready var sprite: Sprite = $Sprite
onready var floor_cast: RayCast2D = $FloorCast


func _ready() -> void:
	original_floor_cast_position = floor_cast.position.x


func _physics_process(_delta: float) -> void:
	var facing_direction = int(sign(get_local_mouse_position().x))
	if not floor_cast.is_colliding():
		motion.x = 0
	elif facing_direction != 0:
		floor_cast.position.x = facing_direction * original_floor_cast_position
		motion.x = SPEED * facing_direction
	motion = move_and_slide(motion, Vector2.UP)

