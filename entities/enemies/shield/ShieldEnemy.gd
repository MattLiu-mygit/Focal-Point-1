extends Enemy

enum DIRECTION {LEFT = 1, RIGHT = -1}

export(DIRECTION) var WALKING_DIRECTION = DIRECTION.LEFT
export(int) var LEFT_BOUND
export(int) var RIGHT_BOUND
export(int) var pause_time = 3

var start_x
var motion_x

onready var sprite : Sprite = $Sprite
onready var floor_left: RayCast2D = $FloorLeft
onready var floor_right: RayCast2D = $FloorRight
onready var wall : RayCast2D = $Wall
onready var timer : Timer = $PatrolTimer


func _ready():
	start_x = position.x
	motion.x = SPEED * WALKING_DIRECTION
	scale.x *= -1


func _physics_process(_delta) -> void:
	var turned = false
	if not floor_right.is_colliding() or not floor_left.is_colliding() or wall.is_colliding() or not in_patrol_area():
		scale.x *= -1
		WALKING_DIRECTION *= -1
		turned = true
		
	if turned:
		motion.x = 0
		timer.start()
	
	motion = move_and_slide_with_snap(motion, Vector2.DOWN * 8, Vector2.UP, true, 4, deg2rad(46))


func in_patrol_area() -> bool:
	var right_bound = start_x + RIGHT_BOUND
	var left_bound = start_x - LEFT_BOUND
	
	if position.x >= left_bound and position.x <= right_bound:
		return true
	else:
		return false


func _on_PatrolTimer_timeout() -> void:
	motion.x = SPEED * WALKING_DIRECTION
