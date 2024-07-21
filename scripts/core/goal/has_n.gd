class_name HasNGoal
extends BaseLevelGoal

@export_node_path var receiver_path: NodePath
@export var count: int


func _is_achieved(level: Level) -> bool:
	var receiver := level.get_node(receiver_path) as BaseSignalNode
	return receiver.received_signals.size() == count
