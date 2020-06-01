extends Enemy
# Known bug: Cannot interact with walls, but patrols correctly

enum Direction {LEFT = -1, RIGHT = 1}

export(Direction) var WALKING_DIRECTION = Direction.LEFT
export(int) var LEFT_BOUND
export(int) var RIGHT_BOUND
export(float) var PAUSE_TIME = 1.0

var start_x

onready var sprite: Sprite = $Sprite
onready var floor_left: RayCast2D = $FloorLeft
onready var floor_right: RayCast2D = $FloorRight
onready var wall_left: RayCast2D = $WallLeft
onready var wall_right: RayCast2D = $WallRight
onready var patrol_timer: Timer = $PatrolTimer
onready var hurtbox: Area2D = $Hurtbox
onready var collider: Area2D = $Collider


func _ready():
	start_x = position.x
	motion.x = SPEED * WALKING_DIRECTION
	patrol_timer.wait_time = PAUSE_TIME


func _process(_delta: float) -> void:
	var facing_direction := sign(get_local_mouse_position().x)
	if facing_direction != 0:
		scale.x = facing_direction

func _physics_process(_delta: float) -> void:
	# warning-ignore:return_value_discarded
	move_and_slide(motion, Vector2.UP)	# Probably will be replaced with collide
	if (not floor_right.is_colliding() or not floor_left.is_colliding() or 
			wall_left.is_colliding() or wall_right.is_colliding() or not in_patrol_area()):
		if motion.x != 0:
			WALKING_DIRECTION *= -1
			motion.x = 0
			patrol_timer.start()


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
