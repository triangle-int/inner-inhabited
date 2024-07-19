class_name BaseSignalReceiver
extends BaseSignalNode

signal signal_received

var _received_signals: Array[SignalInfo]


func _receive_signal(_signal_info: SignalInfo) -> void:
	_received_signals.push_back(_signal_info)
	signal_received.emit()


func is_correct() -> bool:
	return _is_correct()


func _is_correct() -> bool:
	push_warning("unimplemented!")
	return true


func _reset() -> void:
	super._reset()
	_received_signals.clear()
