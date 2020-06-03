extends Area2D

export (int) var DAMAGE


# Hitboxes should only enter Hurtboxes, so we assume the parameter is a hurtbox.
# We use global_position because local position doesn't tell us anything.
func _on_area_entered(hurtbox: Area2D) -> void:
	hurtbox.emit_signal("hit", DAMAGE, global_position)
