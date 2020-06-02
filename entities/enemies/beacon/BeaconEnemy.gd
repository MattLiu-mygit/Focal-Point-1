extends Enemy

export(float) var BEACON_SIZE = 1

var switched_on = true

onready var beacon = $Sprite/Beacon


# Now beacon shield is resizeable!!!
func _ready() -> void:
	beacon.scale.x = BEACON_SIZE
	beacon.scale.y = BEACON_SIZE


# If the beacon button is pushed, the laser is switched off. If it's off, 
# there's no need to free a beacon that doesn't exist.
func _on_Hurtbox_beacon_pushed() -> void:
	if switched_on:
		switched_on = false
		beacon.queue_free()
