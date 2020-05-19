extends Sprite
class_name Gun
# Guns are primarily used to create bullets. As such, the gun is responsible
# for initializing the bullet in instance_bullet.
# Guns have a universal property in that they always point relative to where the
# mouse is pointing, as well as other expected properties like fire rate.
# All guns must have a parent, known as the shooter for it to function

enum HurtboxMaskBit {
	NONE = -1,
	PLAYER = 3,
	ENEMY = 4
}

export (float) var FIRE_RATE
export (int) var BULLET_SPEED
export (HurtboxMaskBit) var MASK_BIT = HurtboxMaskBit.NONE

var gun_rotation := 0

onready var fire_rate_timer: Timer = $FireRateTimer


func _ready() -> void:
	fire_rate_timer.wait_time = FIRE_RATE


func _process(_delta: float) -> void:
	var shooter = get_parent()
	set_gun_rotation(shooter.get_local_mouse_position().angle())
	if Input.is_action_pressed("fire") and fire_rate_timer.time_left == 0:
		fire()


func rotate_gun() -> void:
	gun_rotation = (gun_rotation + 1) % 4


func set_gun_rotation(mouse_angle: float) -> void:
	rotation = mouse_angle + gun_rotation * deg2rad(90)


# Subscenes are responsible for further initializing the bullet.
func instance_bullet(Bullet_: PackedScene) -> Bullet:
	# Bullets don't know which entity to hit, so the gun is responsible for that.
	var bullet: Bullet = Utils.instance_scene_on_main(
						 Bullet_, global_position)
	bullet.hitbox.set_collision_mask_bit(MASK_BIT, true)
	if MASK_BIT == HurtboxMaskBit.ENEMY:
		bullet.modulate = Color.red
	return bullet


# Subscenes are responsible for instancing the bullet.
func fire() -> void:
	fire_rate_timer.start()
