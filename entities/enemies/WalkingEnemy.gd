extends Enemy

enum DIRECTION {LEFT = -1, RIGHT = 1}

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
onready var hurtbox : Area2D = $Hurtbox
onready var collider : Area2D = $Collider


func _ready():
	start_x = position.x
	motion.x = SPEED * WALKING_DIRECTION


# Basically rotates the beam so that it's pointed at the mouse.
func _process(_delta: float) -> void:
	sprite.rotation = get_local_mouse_position().angle() + deg2rad(90)
	hurtbox.rotation = get_local_mouse_position().angle() + deg2rad(90)
	collider.rotation = get_local_mouse_position().angle() + deg2rad(90)


func _physics_process(_delta: float) -> void:
	if not floor_right.is_colliding() or not floor_left.is_colliding() or wall.is_colliding() or not in_patrol_area():
		WALKING_DIRECTION *= -1
		motion.x = 0
		scale.x *= -1
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
