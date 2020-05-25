extends Enemy

onready var gun = $BasicGun

func _ready():
	gun.MASK_BIT = gun.HurtboxMaskBit.ENEMY
