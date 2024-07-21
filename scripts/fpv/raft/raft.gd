extends Node3D

@export var tween_time: float
@export var offset: Vector3

var _player: Player


func _on_area_3d_body_entered(body: Node3D) -> void:
	if not body is Player:
		return

	_player = body as Player
	_player.entered_raft.connect(_on_player_entered_raft)
	_player.attach_to_raft(self)


func _on_player_entered_raft() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(_player, "position", _player.position + offset, tween_time)
	tween.parallel().tween_property(self, "position", position + offset, tween_time)

	await tween.finished

	if PlayerProgress.all_alt_solved():
		LevelSwitcher.switch_to_end()
	else:
		LevelSwitcher.switch_to_main()
