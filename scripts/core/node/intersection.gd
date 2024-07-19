extends BaseSignalNode

var _current: int = 0


func _receive_signal(signal_info: SignalInfo) -> void:
	SignalSender.send_signal(position, outgoing_connections[_current].target, signal_info)
	_current = (_current + 1) % outgoing_connections.size()


func _reset() -> void:
	super._reset()
	_current = 0
