class_name ClearCommand
extends BaseTerminalCommand


func _matches_command(command: String) -> bool:
	return command == "CLR"


func _execute(_command: String, term: Terminal) -> String:
	term.clear()
	return "What about cleaning your house instead..?"
