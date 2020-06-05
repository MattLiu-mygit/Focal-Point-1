extends Enemy

enum DIRECTION {LEFT = -1, RIGHT = 1}

export(DIRECTION) var WALKING_DIRECTION = DIRECTION.RIGHT
export(int) var LEFT_BOUND
export(int) var RIGHT_BOUND
export(int) var pause_time = 3
export(float) var ACCELERATION = 0.75

var start_x
var motion_x
var decelerating

onready var sprite: Sprite = $Sprite
onready var wall_cast: RayCast2D = $WallCast
onready var patrol_timer: Timer = $PatrolTimer
onready var hurtbox: Area2D = $Hurtbox
onready var collider: CollisionShape2D = $Collider


func _ready() -> void:
	start_x = position.x
	motion.x = SPEED * WALKING_DIRECTION
	patrol_timer.wait_time = pause_time
	rotation_degrees = WALKING_DIRECTION * 30
	wall_cast.scale.x = WALKING_DIRECTION


# Checks for two cases in which special action needs to occur:
func _physics_process(_delta: float) -> void:
	if wall_cast.is_colliding():
		decelerating = true
		patrol_flip()
	elif not in_patrol_area():
		return_to_patrol_area()
	
	if decelerating:
		decelerate(wall_cast.cast_to.x/2, wall_cast.cast_to.x/2)
	
	motion = move_and_slide_with_snap(motion, Vector2.DOWN * 8, Vector2.UP, true, 4, deg2rad(46))


# Performs deceleration
func decelerate(param1, param2):
	var deceleration = decelerate_calc(param1, param2)
	motion.x *= deceleration
	decelerate_rotation(deceleration)


# A check to see if it's in the right direction
func return_to_patrol_area() -> void:
	# Needs to check for this as this function will be called on constantly if 
	# the enemy ever gets knocked out of its patrol area. If it's int he right
	# direction, no need to perform a patrol flip. if not in right direction, 
	# it hasn't performed a patrol flip and will perform one.
	if not check_direction():
		patrol_flip()


# Like a patrol man, it stops, and flips itself around.
func patrol_flip() -> void:
	wall_cast.scale.x *= -1
	WALKING_DIRECTION *= -1
	rotation_degrees = 0
	patrol_timer.start()

# Checks if taking one step would take the enemy away or towards the patrol area.
func check_direction() -> bool:
	var compare_val = position.x + WALKING_DIRECTION
	var compare_to_start = abs(compare_val - start_x)
	var dist_to_start = abs(position.x - start_x)
	if compare_to_start < dist_to_start:
		return true
	else: 
		return false

# A check to see if the enemy is in the patrol area.
func in_patrol_area() -> bool:
	var right_bound = start_x + RIGHT_BOUND
	var left_bound = start_x - LEFT_BOUND
	var to_right_bound = abs(right_bound - position.x)
	var to_left_bound = abs(position.x - left_bound)
	
	# Starts decelerating halfway to the patrol flip. Checks for moving right and
	# moving left.
	if (to_right_bound < 0.5 * RIGHT_BOUND and WALKING_DIRECTION == DIRECTION.RIGHT):
		decelerate(to_right_bound, to_left_bound)
	
	if (to_left_bound < 0.5 * LEFT_BOUND and WALKING_DIRECTION == DIRECTION.LEFT):
		decelerate(to_right_bound, to_left_bound)
		
	# Gave some room so enemy doesn't decelerated too much before the flip.
	if position.x >= left_bound + LEFT_BOUND/7.5 and position.x <= right_bound - RIGHT_BOUND/7.5:
		return true
	else:
		motion.x *= 0.95
		return false


# Calculates a smooth deceleration.
func decelerate_calc(to_right_bound, to_left_bound) -> float:
	# Basically modeling acceleration after the derivative of an s curve.
	# multiplied by acceleration mod to adapt the function with the current
	# speed.
	var acceleration_mod
	if WALKING_DIRECTION == 1:
		acceleration_mod = motion.x/to_right_bound
	else:
		acceleration_mod = motion.x/to_left_bound
	var deceleration = (4 * pow(2.71828, acceleration_mod/2))/pow((1 + pow(2.71828, acceleration_mod/2)), 2.0)
	#var deceleration = pow(2.71828, -acceleration_mod/4)
	return deceleration


func decelerate_rotation(deceleration: float) -> void:
	# Helicopter dips the other way as if it's slowing down
	if rotation_degrees > -25 and sign(motion.x) == 1:
		rotation_degrees -= 4*(deceleration - (1 - deceleration))
	elif rotation_degrees < 25 and sign(motion.x) == -1:
		rotation_degrees += 4*(deceleration + (1 - deceleration))


func _on_PatrolTimer_timeout() -> void:
	motion.x = SPEED * WALKING_DIRECTION
	rotation_degrees = WALKING_DIRECTION * 30
	decelerating = false
