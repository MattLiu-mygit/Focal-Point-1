extends Enemy

enum DIRECTION {LEFT = -1, RIGHT = 1}

export(DIRECTION) var WALKING_DIRECTION = DIRECTION.LEFT
export(int) var LEFTBOUND
export(int) var RIGHTBOUND
export(int) var right_bound
export(int) var left_bound
export(int) var globalX

var state
export(int) var start = position.x

onready var sprite = $Sprite
onready var floorLeft = $FloorLeft
onready var floorRight = $FloorRight
onready var wall = $Wall
#onready var wallRight = $Wall

func _ready():
	start = position.x
	state = WALKING_DIRECTION
	motion.x = SPEED * WALKING_DIRECTION

# warning-ignore:unused_argument
func _physics_process(delta):
	if not floorRight.is_colliding() or not floorLeft.is_colliding() or wall.is_colliding() or not in_patrol_area():
		state *= -1
		motion.x *= -1
		scale.x *= -1
	motion = move_and_slide_with_snap(motion, Vector2.DOWN * 8, Vector2.UP, true, 4, deg2rad(46))

func in_patrol_area():
	right_bound = start + RIGHTBOUND
	left_bound = start - LEFTBOUND
	globalX = position.x
	if position.x >= left_bound and position.x <= right_bound:
		return true
	else:
		return false
