class_name AllEqualGoal
extends BaseLevelGoal

@export_node_path var receiver_path: NodePath
@export var default: bool


func _is_achieved(level: Level) -> bool:
	var receiver := level.get_node(receiver_path) as BaseSignalNode
	var signals: Array[SignalInfo] = receiver.received_signals

	if signals.is_empty():
		return default

	return signals.all(func(s: SignalInfo) -> bool: return s.number == signals.front().number)
