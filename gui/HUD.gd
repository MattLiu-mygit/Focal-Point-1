extends Control

const HeartIcon := preload("res://gui/icons/HeartIcon.tscn")

var player_stats = ResourceLoader.player_stats

onready var heart_container: HBoxContainer = $HeartContainer
onready var life_count_label: Label = $LifeCountLabel
onready var key_icon: TextureRect = $KeyIcon


func _ready() -> void:
	player_stats.connect("player_health_changed", self, "_on_player_health_changed")
	player_stats.connect("player_total_health_changed", self, "_on_player_total_health_changed")
	player_stats.connect("player_has_key_changed", self, "_on_player_has_key_changed")


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


func _on_player_has_key_changed(has_key: bool):
	key_icon.visible = has_key
