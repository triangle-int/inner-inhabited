class_name AndGoal
extends BaseLevelGoal

@export var goals: Array[BaseLevelGoal]


func _is_achieved(level: Level) -> bool:
	return goals.all(func(g: BaseLevelGoal) -> bool: return g.is_achieved(level))
