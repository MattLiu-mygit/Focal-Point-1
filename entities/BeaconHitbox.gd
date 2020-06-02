extends "res://entities/Hitbox.gd"


func _on_BeaconHitbox_area_entered(hurtbox: Area2D) -> void:
	hurtbox.emit_signal("beacon_pushed")
