class_name SumEqualGoal
extends BaseLevelGoal

@export_node_path var receiver_path: NodePath
@export var target_sum: int


func _is_achieved(level: Level) -> bool:
	var receiver := level.get_node(receiver_path) as BaseSignalNode
	var signals: Array[SignalInfo] = receiver.received_signals

	return target_sum == signals.reduce(func(acc: int, s: SignalInfo) -> int: return acc + s.number)
