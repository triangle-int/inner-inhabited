extends BaseSignalNode

var _memory: int
var _should_send := false


func _receive_signal(signal_info: SignalInfo) -> void:
	if not _should_send:
		_memory = signal_info.number
		_should_send = true
		self.signal_consumed.emit()
		return

	_should_send = false

	if outgoing_connections.is_empty():
		Level.current.stop_simulation()
		return

	var new_signal := SignalInfo.new()
	new_signal.number = _memory * signal_info.number
	SignalSender.send_signal(position, outgoing_connections.front().target, new_signal)


func _reset() -> void:
	_should_send = false


func _on_drag_stopped() -> void:
	_sort_in_incoming()
