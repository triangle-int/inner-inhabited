class_name BaseLevelGoal
extends Resource

@export var invert: bool


func is_achieved(level: Level) -> bool:
	# (!=) <=> (xor)
	return invert != _is_achieved(level)


func _is_achieved(_level: Level) -> bool:
	push_warning("not implemented!")
	return true
