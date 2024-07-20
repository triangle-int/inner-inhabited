extends Node3D

@export var player: Node3D
@export var axis: Vector3
@export var limit: float

var _initial_position: Vector3
var _initial_player_position: Vector3


func _ready() -> void:
	_initial_player_position = player.position
	_initial_position = position


func _physics_process(_delta: float) -> void:
	var axis2 := Vector3.UP.cross(axis)
	var player_offset := player.position - _initial_player_position
	position = (
		_initial_position
		+ axis * player_offset.dot(axis)
		+ axis2 * clamp(player_offset.dot(axis2), -limit, limit)
	)
