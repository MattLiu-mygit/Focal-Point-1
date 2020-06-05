extends Area2D

signal button_pressed()


func _on_Button_area_entered(_area: Area2D) -> void:
	emit_signal("button_pressed")


func _on_Button_body_entered(_body: Node) -> void:
	emit_signal("button_pressed")
