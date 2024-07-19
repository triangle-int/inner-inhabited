extends BaseSignalReceiver

@export var target_number: int
@export var target_count: int


func _is_correct() -> bool:
	return (
		_received_signals.all(func(info: SignalInfo) -> bool: return info.number == target_number)
		and _received_signals.size() == target_count
	)
