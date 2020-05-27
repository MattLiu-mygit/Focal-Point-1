extends Area2D

export (int) var DAMAGE

# Hitboxes should only enter Hurtboxes, so we assume the parameter is a hurtbox.
func _on_area_entered(hurtbox: Area2D) -> void:
	hurtbox.emit_signal("hit", DAMAGE)


func _on_Hitbox_area_entered(area):
	pass # Replace with function body.
