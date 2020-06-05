extends Enemy

# Maybe make the enemy keyframe be just the eyes when in walls
# fade in and out. When faded, hurtbox 0

enum DIRECTION {LEFT = -1, RIGHT = 1}
enum STATE {SEMISOLID = 1, SOLID = 0, TRANSPARENT = -1}

export(int) var ACCELERATION = 100
export(DIRECTION) var WALKING_DIRECTION = DIRECTION.RIGHT
export(int) var SPOOPYNESS = 1

var motion_up
var state
var spoopy_y_mod
var main_instances = ResourceLoader.main_instances

onready var sprite: Sprite = $Sprite
onready var hurtbox: Area2D = $Hurtbox
onready var collider: Area2D = $Collider
onready var spoopy_timer: Timer = $SpoopyTimer
onready var fade_timer: Timer = $FadeTimer
onready var wall_cast: RayCast2D = $WallCast
onready var fade_animator: AnimationPlayer = $FadeAnimator


func _ready() -> void:
	motion_up = false
	state = STATE.SEMISOLID
	motion.x = SPEED * WALKING_DIRECTION
	spoopy_y_mod = -randi() % SPOOPYNESS


# Checks for two cases in which special action needs to occur: 
func _physics_process(delta: float) -> void:
	var player = main_instances.player
	if spoopy_timer.time_left == 0:
		spoopy_timer.start()
	if fade_timer.time_left == 0:
		fade_timer.start()
	if player != null:
		chase_player(player, delta)


# Chases player
func chase_player(player, delta) -> void:
	var direction = (player.global_position - global_position).normalized()
	motion.y += spoopy_y_mod * spoopy_timer.time_left
	motion += direction * ACCELERATION * delta
	motion = motion.clamped(SPEED)
	sprite.flip_h = global_position > player.global_position
	motion = move_and_slide(motion)


func fade() -> void:
	fade_animator.play("fade")
	hurtbox.set_collision_layer_bit(4, false)
	state = STATE.TRANSPARENT


func materialize() -> void:
	fade_animator.play_backwards("fade")
	hurtbox.set_collision_layer_bit(4, true)
	state = STATE.SOLID


func _on_SpoopyTimer_timeout() -> void:
	if motion_up:
		motion_up = false
		spoopy_timer.wait_time = randf() * 1.5
		spoopy_y_mod = -randi() % SPOOPYNESS
	else:
		spoopy_y_mod *= -1
		motion_up = true


# Transitions between a solid and transparent state. SEMISOLID is the transition
# where SEMISOLID can either be when materializing or when fading.
func _on_FadeTimer_timeout() -> void:
	var player = main_instances.player
	var variance = SPOOPYNESS * 100
	if state == STATE.TRANSPARENT:
		# Spawns somewhere around and above the player and starts making its way 
		# towards player. 
		if player != null:
			position.x = player.position.x + (randf() * variance - variance/2 )
			position.y = player.position.y - randf() * variance/4
		state = STATE.SEMISOLID
	elif state == STATE.SOLID:
		state = STATE.SEMISOLID
	else:
		if hurtbox.get_collision_layer_bit(4) == false:		
			materialize()
		else: 
			fade()
