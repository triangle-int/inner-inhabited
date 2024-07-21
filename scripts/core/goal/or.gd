class_name OrGoal
extends BaseLevelGoal

@export var a: BaseLevelGoal
@export var b: BaseLevelGoal


func _is_achieved(level: Level) -> bool:
	return a.is_achieved(level) or b.is_achieved(level)
