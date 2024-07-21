extends Area3D

@onready var target_camera_point: Node3D = $TargetCameraPoint


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.enable_interaction("TALK", self)


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		body.disable_interaction()


func interact(player: Player) -> void:
	if Dialogic.current_timeline != null:
		return
	
	if not PlayerProgress.used_raft:
		await start_sequence("first_robot_encounter", player)
	elif PlayerProgress.first_non_solved_alt_level() == null:
		await start_sequence("end_robot", player)
	else:
		await start_sequence("main_robot", player)
	
	player.can_move = true
	player.enable_interaction("TALK", self)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func continue_chat(player: Player) -> void:
	if Dialogic.current_timeline != null:
		return
	
	Dialogic.VAR.continue_chat = false
	await start_sequence("main_robot", player)


func start_sequence(seq_name: String, player: Player) -> void:
	Dialogic.start(seq_name)
	player.disable_interaction()
	player.can_move = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	var target_position := target_camera_point.global_position
	target_position.y = 0
	var target_player_transform := player.global_transform.looking_at(target_position)
	tween.tween_property(player, "global_transform", target_player_transform, 1.0)
	tween.parallel().tween_property(player.head, "rotation:x", 0, 1.0)
	
	await Dialogic.timeline_ended
