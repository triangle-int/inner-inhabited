class_name SequenceGoal
extends BaseLevelGoal

@export_node_path var receiver_path: NodePath
@export var target_sequence: Array[int]


func _is_achieved(level: Level) -> bool:
	var receiver := level.get_node(receiver_path) as BaseSignalNode
	var signals: Array[SignalInfo] = receiver.received_signals

	if target_sequence.size() != signals.size():
		return false

	for i in range(signals.size()):
		if signals[i].number != target_sequence[i]:
			return false

	return true
