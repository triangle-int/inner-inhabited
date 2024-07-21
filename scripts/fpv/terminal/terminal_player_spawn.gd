extends Node3D

@export var player: Player


func _ready() -> void:
	if LevelSwitcher.play_terminal_animation:
		player.can_move = false
		player.global_position = global_position 
