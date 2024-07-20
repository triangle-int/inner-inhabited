extends BaseTerminalCommand
class_name EscapeCommand


func _matches_command(string: String) -> bool:
	return string == "ESC"


func _execute(command: String, terminal: Terminal) -> String:
	# TODO: Open first person
	return "Disabling simulation..."
