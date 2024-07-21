class_name LoopGoal
extends BaseLevelGoal

@export var repetitions := 2


func _is_achieved(level: Level) -> bool:
	for node in level.get_children():
		var signal_node := node as BaseSignalNode

		if signal_node == null:
			continue

		var signals := signal_node.received_signals

		if signals.any(
			func(s: SignalInfo) -> bool: return (
				signals.count(func(s2: SignalInfo) -> bool: return s.id == s2.id) >= repetitions
			)
		):
			return true

	return false
