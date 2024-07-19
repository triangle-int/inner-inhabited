class_name BaseSignalNode
extends Node2D

@export var connections: Array[BaseSignalNode]


func receive_signal(signal_info: SignalInfo) -> void:
	_receive_signal(signal_info)


func _receive_signal(_signal_info: SignalInfo) -> void:
	push_warning("unimplemented!")


func reset() -> void:
	_reset()


func _reset() -> void:
	pass
