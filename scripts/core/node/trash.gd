extends BaseSignalNode


func _receive_signal(_signal_info: SignalInfo) -> void:
	self.signal_consumed.emit()
