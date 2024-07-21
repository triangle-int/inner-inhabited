extends BaseSignalNode


func _receive_signal(_signal_info: SignalInfo) -> void:
	self.signal_consumed.emit()


func _on_drag_stopped() -> void:
	_sort_in_incoming()
