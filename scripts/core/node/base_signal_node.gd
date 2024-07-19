class_name BaseSignalNode
extends Node2D

@export var connection_limit: int

var outgoing_connections: Array[Connection]
var incoming_connections: Array[Connection]


func receive_signal(signal_info: SignalInfo) -> void:
	_receive_signal(signal_info)


func _receive_signal(_signal_info: SignalInfo) -> void:
	push_warning("unimplemented!")


func reset() -> void:
	_reset()


func _reset() -> void:
	pass


func destroy() -> void:
	for connection in outgoing_connections:
		connection.target.incoming_connections.erase(connection)
		connection.queue_free()

	for connection in incoming_connections:
		connection.source.outgoing_connections.erase(connection)
		connection.queue_free()

	queue_free()
