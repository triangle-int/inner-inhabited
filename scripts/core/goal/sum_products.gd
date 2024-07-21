class_name SumProductGoal
extends BaseLevelGoal

@export var receiver_paths: Array[NodePath]
@export var target: int
@export var empty_default: int


func _is_achieved(level: Level) -> bool:
	var receivers := receiver_paths.map(
		func(path: NodePath) -> BaseSignalNode: return level.get_node(path)
	)
	var products := (
		receivers
		. map(
			func(node: BaseSignalNode) -> int: return (
				node.received_signals.reduce(
					func(acc: int, s: SignalInfo) -> int: return acc * s.number, 1
				)
				if not node.received_signals.is_empty()
				else empty_default
			),
		)
	)

	return products.reduce(func(acc: int, curr: int) -> int: return acc + curr, 0) == target
