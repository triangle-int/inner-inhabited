class_name BaseTerminalCommand
extends Resource


func matches_command(string: String) -> bool:
	return _matches_command(string)


func _matches_command(_string: String) -> bool:
	push_warning("unimplemented!")
	return true


func execute(command: String) -> String:
	return _execute(command)


func _execute(_command: String) -> String:
	push_warning("unimplemented!")
	return "command not implemented yet"
