extends Control

const HeartIcon := preload("res://gui/health/HeartIcon.tscn")

var player_stats = ResourceLoader.player_stats

onready var heart_container: HBoxContainer = $HeartContainer
onready var life_count_label: Label = $LifeCountLabel


func _ready() -> void:
	pass
