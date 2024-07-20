extends Node

@export var player: Node3D
@export var limit: float
@export var axis: Vector3


func _physics_process(_delta: float) -> void:
	# pos (dot) axis := |pos| * |axis| * cos(pos, axis) =
	# = |pos| * cos(pos, axis) =: projection of pos onto axis
	var projection := player.position.dot(axis)

	if projection >= limit:
		player.position -= axis * limit
	elif projection <= -limit:
		player.position += axis * limit
