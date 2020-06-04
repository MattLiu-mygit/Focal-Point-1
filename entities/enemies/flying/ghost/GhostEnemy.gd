extends Enemy

# Maybe make the enemy keyframe be just the eyes when in walls
# fade in and out. When faded, hurtbox 0

enum DIRECTION {LEFT = -1, RIGHT = 1}
enum STATE {SEMISOLID = 1, SOLID = 0, TRANSPARENT = -1}

export(DIRECTION) var WALKING_DIRECTION = DIRECTION.RIGHT
export(int) var LEFT_BOUND
export(int) var RIGHT_BOUND
export(int) var pause_time = 3
export(int) var SPOOPYNESS = 1

var start_x
var motion_x
var motion_up
var state

onready var sprite: Sprite = $Sprite
onready var hurtbox: Area2D = $Hurtbox
onready var collider: Area2D = $Collider
onready var patrol_timer: Timer = $PatrolTimer
onready var spoopy_timer: Timer = $SpoopyTimer
onready var fade_timer: Timer = $FadeTimer
onready var wall: RayCast2D = $Wall
onready var fade_animator: AnimationPlayer = $FadeAnimator


func _ready() -> void:
	motion_up = false
	state = STATE.SEMISOLID
	start_x = position.x
	motion.x = SPEED * WALKING_DIRECTION
	patrol_timer.wait_time = pause_time
	motion.y = -randi() % SPOOPYNESS


# Checks for two cases in which special action needs to occur: 
func _physics_process(_delta: float) -> void:
	if not in_patrol_area():
		return_to_patrol_area()
	motion = move_and_slide(motion, Vector2.UP)


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
	WALKING_DIRECTION *= -1
	motion.x = 0
	patrol_timer.start()
	scale.x *= -1

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
	
	if position.x >= left_bound and position.x <= right_bound:
		return true
	else:
		return false


func fade() -> void:
	fade_animator.play("fade")
	hurtbox.set_collision_layer_bit(4, false)
	state = STATE.TRANSPARENT


func materialize() -> void:
	fade_animator.play_backwards("fade")
	hurtbox.set_collision_layer_bit(4, true)
	state = STATE.SOLID


func _on_PatrolTimer_timeout() -> void:
	motion.x = SPEED * WALKING_DIRECTION


func _on_SpoopyTimer_timeout() -> void:
	if motion_up:
		motion_up = false
		spoopy_timer.wait_time = randf() * 1.5
		motion.y = -randi() % SPOOPYNESS
	else:
		motion.y *= -1
		motion_up = true


# Transitions between a solid and transparent state. SEMISOLID is the transition
# where SEMISOLID can either be when materializing or when fading.
func _on_FadeTimer_timeout() -> void:
	if state == STATE.TRANSPARENT:
		state = STATE.SEMISOLID
	elif state == STATE.SOLID:
		state = STATE.SEMISOLID
	else:
		if hurtbox.get_collision_layer_bit(4) == false:		
			materialize()
		else: 
			fade()
