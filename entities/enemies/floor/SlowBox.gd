extends Area2D

signal slowed()


func _on_SlowBox_area_entered(hurtbox: Area2D) -> void:
	hurtbox.emit_signal("slowed")


func _on_SlowBox_body_entered(hurtbox: Node) -> void:
	hurtbox.emit_signal("slowed")
