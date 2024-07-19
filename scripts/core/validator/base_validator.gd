class_name BaseValidator
extends Resource


func is_valid(received: Array[SignalInfo]) -> bool:
	return _is_valid(received)


func _is_valid(_received: Array[SignalInfo]) -> bool:
	push_warning("unimplemented!")
	return true
