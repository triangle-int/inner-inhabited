class_name LevelLoadCommand
extends BaseTerminalCommand

@export var levels: Array[LevelResource]


func _matches_command(string: String) -> bool:
	if not string.begins_with("L"):
		return false

	var level_id := string.substr(1)
	return find_level(level_id) != null


func _execute(command: String, terminal: Terminal) -> String:
	var level_id := command.substr(1)
	var level := find_level(level_id).level
	var level_node := level.instantiate() as Level

	terminal.attach_level(level_node)
	
	return "Loading level %s..." % level_id


func find_level(level_id: String) -> LevelResource:
	var possible_levels := levels.filter(
		func(level: LevelResource) -> bool: return level.id == level_id
	)
	return possible_levels.front() if possible_levels.size() == 1 else null
