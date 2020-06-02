extends Control

const HeartIcon := preload("res://gui/health/HeartIcon.tscn")

var player_stats = ResourceLoader.player_stats

onready var heart_container: HBoxContainer = $HeartContainer
onready var life_count_label: Label = $LifeCountLabel


func _ready() -> void:
	player_stats.connect("player_health_changed", self, "_on_player_health_changed")
	player_stats.connect("player_total_health_changed", self, "_on_player_total_health_changed")


func _on_player_health_changed(health: int):
	var hearts := heart_container.get_child_count()
	if hearts < health:
		for _i in range(abs(hearts - health)):
			heart_container.add_child(HeartIcon.instance())
	elif hearts > health:
		for _i in range(abs(hearts - health)):
			heart_container.remove_child(heart_container.get_child(0))

func _on_player_total_health_changed(total_health: int):
	life_count_label.text = "x" + str(total_health)
