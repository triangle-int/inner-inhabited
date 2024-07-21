class_name LevelLoadCommand
extends BaseTerminalCommand

@export var levels: Array[LevelResource]


func _matches_command(string: String) -> bool:
	if not string.begins_with("L"):
		return false

	var level_id := string.substr(1)
	return levels.any(func(l: LevelResource) -> bool: return l.id == level_id)


func _execute(command: String, terminal: Terminal) -> String:
	var level_id := command.substr(1)
	var index := find_level_index(level_id)

	if index > 0:
		var prev := levels[index - 1].id

		if not PlayerProgress.passed_levels_ids.has(prev):
			return "Level locked!\nYou should beat level %s to unlock this it." % prev

	var level_node := levels[index].level.instantiate() as Level
	level_node.level_id = level_id
	terminal.attach_level(level_node)

	return "Loading level %s...\n%s" % [level_id, levels[index].hint]


func find_level_index(level_id: String) -> int:
	for index in range(levels.size()):
		if levels[index].id == level_id:
			return index

	return -1
