extends "res://weapons/guns/basic/BasicGun.gd"


func set_gun_rotation(mouse_angle: float) -> void:
	# Point in the opposite direction as mouse position
	rotation = mouse_angle + deg2rad(180)
