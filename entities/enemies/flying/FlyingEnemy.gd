extends Enemy

export(int) var ACCELERATION = 100

onready var sprite = $Sprite

func _ready():
	set_physics_process(false)

