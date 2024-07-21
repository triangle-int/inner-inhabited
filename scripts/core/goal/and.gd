class_name AndGoal
extends BaseLevelGoal

@export var a: BaseLevelGoal
@export var b: BaseLevelGoal


func _is_achieved(level: Level) -> bool:
	return a.is_achieved(level) and b.is_achieved(level)
