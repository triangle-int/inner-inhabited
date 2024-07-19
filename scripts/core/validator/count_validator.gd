class_name CountValidator
extends BaseValidator

@export var counts: Array[CountParam]


func _is_valid(received: Array[SignalInfo]) -> bool:
	return (
		counts.all(
			func(count: CountParam) -> bool: return (
				(
					received
					. filter(func(info: SignalInfo) -> bool: return info.number == count.number)
					. size()
				)
				== count.expected_count
			)
		)
		and (
			received.size()
			== counts.reduce(
				func(sum: int, count: CountParam) -> int: return sum + count.expected_count, 0
			)
		)
	)
