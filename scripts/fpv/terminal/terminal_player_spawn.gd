extends Node3D

@export var player: Player
@export var animation_duration: float

var animating := false

@onready var path_follow_3d: PathFollow3D= $Path3D/PathFollow3D
@onready var camera_look_target: Node3D = $CameraLookTarget


func _ready() -> void:
	if LevelSwitcher.play_terminal_animation:
		player.can_move = false
		player.global_position = global_position
		animating = true
		path_follow_3d.progress_ratio = 0.0
		var tween := create_tween()
		tween.tween_property(path_follow_3d, "progress_ratio", 1.0, animation_duration)\
			.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_callback(end_animation)
		await player.can_interact
		player.disable_interaction()


func end_animation() -> void:
	animating = false
	player.can_move = true


func _process(_delta: float) -> void:
	if animating:
		player.head.global_position = path_follow_3d.global_position
		player.head.look_at(camera_look_target.global_position)
