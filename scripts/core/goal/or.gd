class_name OrGoal
extends BaseLevelGoal

@export var goals: Array[BaseLevelGoal]


func _is_achieved(level: Level) -> bool:
	return goals.any(func(g: BaseLevelGoal) -> bool: return g.is_achieved(level))
