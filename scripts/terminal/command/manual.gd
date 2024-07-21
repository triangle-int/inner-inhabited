class_name ManualCommand
extends BaseTerminalCommand

@export_multiline var text: String


func _matches_command(string: String) -> bool:
	return string == "MAN"


func _execute(_command: String, _term: Terminal) -> String:
	return text
