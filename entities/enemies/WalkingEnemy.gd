extends Enemy
# Known bug: Cannot interact with walls, but patrols correctly

enum Direction {LEFT = -1, RIGHT = 1}

export (Direction) var WALKING_DIRECTION = Direction.LEFT
export (int) var LEFT_BOUND = 0
export (int) var RIGHT_BOUND = 0
export (float) var PAUSE_TIME = 1.0

var start_x

onready var sprite: Sprite = $Sprite
onready var hurtbox: Area2D = $Hurtbox
onready var collider: Area2D = $Collider
onready var floor_cast: RayCast2D = $FloorCast
onready var wall_cast: RayCast2D = $WallCast
onready var patrol_timer: Timer = $PatrolTimer


func _ready():
	start_x = position.x
	motion.x = SPEED * WALKING_DIRECTION
	patrol_timer.wait_time = PAUSE_TIME
	wall_cast.scale.x = WALKING_DIRECTION
	floor_cast.position.x = 8 * WALKING_DIRECTION


func _process(_delta: float) -> void:
	var facing_direction := sign(get_local_mouse_position().x)
	if facing_direction != 0:
		sprite.scale.x = facing_direction


func _physics_process(_delta: float) -> void:
	if not floor_cast.is_colliding() or wall_cast.is_colliding():
		patrol_flip()
	if not in_patrol_area():
		return_to_patrol_area()
	motion = move_and_slide(motion, Vector2.UP)



func patrol_flip() -> void:
	WALKING_DIRECTION *= -1
	motion.x = 0
	patrol_timer.start()
	wall_cast.scale.x *= -1
	floor_cast.position.x *= -1


func return_to_patrol_area() -> void:
	if not check_direction():
		patrol_flip()


func check_direction() -> bool:
	var compare_val = position.x + WALKING_DIRECTION
	var compare_to_start = abs(compare_val - start_x)
	var dist_to_start = abs(position.x - start_x)
	if compare_to_start < dist_to_start:
		return true
	else: 
		return false


func in_patrol_area() -> bool:
	if LEFT_BOUND == 0 and RIGHT_BOUND == 0:
		return true
	var right_bound = start_x + RIGHT_BOUND
	var left_bound = start_x - LEFT_BOUND
	
	if position.x >= left_bound and position.x <= right_bound:
		return true
	else:
		return false


func _on_PatrolTimer_timeout() -> void:
	motion.x = SPEED * WALKING_DIRECTION
