extends Gun
# A gun that shoots five bullets in a spread

onready var gun1: Gun = $BasicGun1
onready var gun2: Gun = $BasicGun2
onready var gun3: Gun = $BasicGun3
onready var gun4: Gun = $BasicGun4
onready var gun5: Gun = $BasicGun5
onready var guns: Array = [gun1, gun2, gun3, gun4, gun5]

func _ready() -> void:
	for gun in guns:
		gun.FIRE_RATE = FIRE_RATE
		gun.BULLET_SPEED = BULLET_SPEED
		gun.AUTO_FIRE = AUTO_FIRE
		gun.AUTO_FIRE_RATE = AUTO_FIRE_RATE
		gun.MASK_BIT = MASK_BIT
		gun._ready()


func set_gun_rotation(mouse_angle: float) -> void:
	for gun in guns:
		gun.set_gun_rotation(mouse_angle)
