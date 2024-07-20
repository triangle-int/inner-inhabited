extends Node3D

@export var player: Node3D
@export var axis: Vector3

var _initial_position: Vector3


func _ready() -> void:
	_initial_position = position


func _physics_process(_delta: float) -> void:
	position = _initial_position + axis * player.position.dot(axis)
