class_name BaseSignalNode
extends Node2D

signal signal_consumed
signal signal_received

@export var connection_limit: int

var outgoing_connections: Array[Connection]
var incoming_connections: Array[Connection]
var received_signals: Array[SignalInfo]


func receive_signal(signal_info: SignalInfo) -> void:
	received_signals.push_back(signal_info)
	signal_received.emit()
	_receive_signal(signal_info)


func _receive_signal(_signal_info: SignalInfo) -> void:
	push_warning("unimplemented!")


func reset() -> void:
	received_signals.clear()
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


func sort_outgoing_connections() -> void:
	outgoing_connections.sort_custom(
		func(a: Connection, b: Connection) -> bool: return a.target.position.x < b.target.position.x
	)
