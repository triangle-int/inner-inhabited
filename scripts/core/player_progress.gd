extends Node

@export var alt_levels: Array[AltLevel]

var passed_levels_ids: Array[String] = []
var alt_passed_levels_ids: Array[String] = []
var escaped_terminal: bool = false
var all_alt_passed: bool


func first_non_solved_alt_level() -> AltLevel:
	var possible_hints: Array[AltLevel] = alt_levels.filter(
		func(hint: AltLevel) -> bool: return not _is_alt_solved(hint.level_id)
	)

	if possible_hints.is_empty():
		return null

	return possible_hints.front()


func all_alt_solved() -> bool:
	return alt_levels.all(func(hint: AltLevel) -> bool: return _is_alt_solved(hint.level_id))


func _is_alt_solved(level_id: String) -> bool:
	return alt_passed_levels_ids.has(level_id)
