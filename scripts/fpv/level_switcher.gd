extends Node

@export var main_level: PackedScene
@export var statue_level: PackedScene
@export var end_level: PackedScene
@export var fade: ColorRect
@export var fade_time: float

var _need_rotate: bool
var _old_player_rotation: Vector3
var _old_player_head_rotation: Vector3


func rotate_to_match_old(new_player: Player) -> void:
	if not _need_rotate:
		return

	_need_rotate = false
	new_player.rotation = _old_player_rotation
	new_player.head.rotation = _old_player_head_rotation


func switch_to_statue(player: Player) -> void:
	_need_rotate = true
	_old_player_rotation = player.rotation
	_old_player_head_rotation = player.head.rotation
	get_tree().change_scene_to_packed(statue_level)


func switch_to_main() -> void:
	_start_fade(Color.BLACK)
	get_tree().change_scene_to_packed(main_level)


func switch_to_end() -> void:
	_start_fade(Color.BLACK)
	get_tree().change_scene_to_packed(end_level)


func _start_fade(initial_color: Color) -> void:
	fade.color = initial_color
	get_tree().create_tween().tween_property(
		fade, "color", Color(initial_color.r, initial_color.g, initial_color.b, 0), fade_time
	)
