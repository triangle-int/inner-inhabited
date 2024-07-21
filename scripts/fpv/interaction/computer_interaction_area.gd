extends Area3D

@onready var camera_exit_position: Node3D = $CameraExitPosition


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.enable_interaction("ENTER SIMULATION", self)


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		body.disable_interaction()


func interact(player: Player) -> void:
	player.disable_interaction()
	player.can_move = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	LevelSwitcher.switch_to_terminal()
	var tween := create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(player.head, "global_position", camera_exit_position.global_position, 2.0)
	tween.parallel().tween_property(player.head, "global_rotation", camera_exit_position.global_rotation, 2.0)
