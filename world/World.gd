extends Node2D
# The World is the Room loader and is essentially the physical environment.

# Assigned when level is selected and when transitioning levels
var player_stats = ResourceLoader.player_stats

var _room_scene : PackedScene

onready var room: Room = $TestingRoom


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("temp_reset_room"):
		reset_room()


func _ready() -> void:
	ResourceLoader.main_instances.world = self
	# temp
	if player_stats.selected_level != null:
		set_room(player_stats.selected_level)
	else:
		var packed_scene: PackedScene = PackedScene.new()
		for node in room.get_children():
			node.set_owner(room)
		# warning-ignore:return_value_discarded
		packed_scene.pack(room)
		_room_scene = packed_scene


func queue_free() -> void:
	ResourceLoader.main_instances.world = null
	.queue_free()


func set_room(room_: PackedScene) -> void:
	if room:
		call_deferred("remove_child", room)
		room.queue_free()
	_room_scene = room_
	room = room_.instance()
	call_deferred("add_child", room)


# Resets the room back to its original state and also sets the Player's position.
# This is NOT responsible for resetting player stats, let Player do that.
func reset_room() -> void:
	set_room(_room_scene)
