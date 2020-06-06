extends Enemy

enum DIRECTION {LEFT = -1, RIGHT = 1}

export(int) var ACCELERATION = 100
export(DIRECTION) var WALKING_DIRECTION = DIRECTION.RIGHT

var main_instances = ResourceLoader.main_instances

onready var sprite: Sprite = $Sprite
onready var hurtbox: Area2D = $Hurtbox
onready var collider: Area2D = $Collider


func _ready() -> void:
	motion.x = SPEED * WALKING_DIRECTION


func _physics_process(delta: float) -> void:
	var player = main_instances.player
	
	if player != null:
		chase_player(player)
	
	motion = move_and_slide(motion)


# Chases player
func chase_player(player) -> void:
	var direction = (player.global_position - global_position).normalized()
	motion += direction * ACCELERATION
	motion = motion.clamped(SPEED)
	sprite.flip_h = global_position > player.global_position
