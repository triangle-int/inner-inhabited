class_name BaseTerminalCommand
extends Resource


func matches_command(string: String) -> bool:
	return _matches_command(string)


func _matches_command(_string: String) -> bool:
	push_warning("unimplemented!")
	return true


func execute(command: String, terminal: Terminal) -> String:
	return _execute(command, terminal)


func _execute(_command: String, _terminal: Terminal) -> String:
	push_warning("unimplemented!")
	return "command not implemented yet"
