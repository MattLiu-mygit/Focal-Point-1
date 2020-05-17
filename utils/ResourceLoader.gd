extends Node
# The ResourceLoader exists so that universal resources are not accidentally
# loaded while another instance also has one loaded. 
# We don't want data to desync.

var player_stats : PlayerStats = preload("res://entities/player/PlayerStats.tres")
