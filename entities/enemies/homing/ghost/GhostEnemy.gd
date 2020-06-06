extends "res://entities/enemies/homing/HomingEnemy.gd"

enum STATE {SEMISOLID = 1, SOLID = 0, TRANSPARENT = -1}

export(int) var SPOOPYNESS = 1
export(int) var FREEZE_ANGLE_RANGE = 15

var motion_up
var state
var spoopy_y_mod

onready var spoopy_timer: Timer = $SpoopyTimer
onready var fade_timer: Timer = $FadeTimer
onready var fade_animator: AnimationPlayer = $FadeAnimator


func _ready() -> void:
	motion_up = false
	state = STATE.SEMISOLID
	spoopy_y_mod = -randi() % SPOOPYNESS


# Checks for two cases in which special action needs to occur: 
func _physics_process(_delta: float) -> void:
	var player = main_instances.player
	
	if spoopy_timer.time_left == 0:
		spoopy_timer.start()
	
	if fade_timer.time_left == 0:
		fade_timer.start()
	
	if player != null:
		freeze_check(player)


func freeze_check(player: KinematicBody2D) -> void:
	var player_angle = get_player_angle(player)
	var ghost_angle = get_ghost_angle(player)
	var top_angle = player_angle + deg2rad(FREEZE_ANGLE_RANGE)
	var bottom_angle = player_angle - deg2rad(FREEZE_ANGLE_RANGE)
		
	# Freezes movement if ghost enemy within an angle range of where the 
	# player looks
	if ghost_angle < top_angle and ghost_angle > bottom_angle:
		motion.x = 0
		motion.y = 0


func chase_player(player: KinematicBody2D, delta: float) -> void:
	.chase_player(player, delta)
	motion.y += spoopy_y_mod * spoopy_timer.time_left


func get_player_angle(player: KinematicBody2D) -> float:
	var player_angle = -player.get_local_mouse_position().angle()
	if player_angle > PI/2:
		player_angle = -PI + player_angle
	elif player_angle < -PI/2:
		player_angle = PI - player_angle
	return player_angle


func get_ghost_angle(player: KinematicBody2D) -> float:
	var y_diff = -position.y + player.position.y 
	var x_diff = position.x - player.position.x
	if y_diff == 0:
		y_diff = 0.0001
	var ghost_angle = atan(y_diff/x_diff)
	return ghost_angle


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
