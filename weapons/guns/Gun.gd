extends Sprite
# Guns are primarily used to create bullets. As such, the gun is responsible
# for initializing the bullet in instance_bullet.
# Guns have a universal property in that they always point relative to where the
# mouse is pointing, as well as other expected properties like fire rate.

const PLAYER_HURTBOX_MASK_BIT := 3
const ENEMY_HURTBOX_MASK_BIT := 4

export (float) var FIRE_RATE

onready var fire_rate_timer: Timer = $FireRateTimer
onready var fire_position: Position2D = $FirePosition


func _ready() -> void:
	fire_rate_timer.wait_time = FIRE_RATE


func _process(_delta: float) -> void:
	var shooter = get_parent()
	set_gun_rotation(shooter.get_local_mouse_position().angle())
	if Input.is_action_pressed("fire") and fire_rate_timer.time_left == 0:
		fire()


func set_gun_rotation(mouse_angle: float) -> void:
	rotation = mouse_angle


# Subscenes are responsible for further initializing the bullet.
func instance_bullet(Bullet_: PackedScene) -> Bullet:
	var shooter = get_parent()
	# Bullets don't know which entity to hit, so the gun is responsible for that.
	var bullet: Bullet = Utils.instance_scene_on_main(
						 Bullet_, fire_position.global_position)
	if shooter is Player:
		bullet.hitbox.set_collision_mask_bit(ENEMY_HURTBOX_MASK_BIT, true)
	elif shooter is Enemy:
		bullet.hitbox.set_collision_mask_bit(PLAYER_HURTBOX_MASK_BIT, true)
		bullet.modulate = Color.red
	return bullet


# Subscenes are responsible for instancing the bullet.
func fire() -> void:
	fire_rate_timer.start()
