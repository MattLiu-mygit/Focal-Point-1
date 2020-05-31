extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://gui/screens/LevelSelectMenu.tscn")
