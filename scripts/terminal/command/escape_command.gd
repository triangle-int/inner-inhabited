extends BaseTerminalCommand
class_name EscapeCommand


func _matches_command(string: String) -> bool:
	return string == "ESC"


func _execute(_command: String, _terminal: Terminal) -> String:
	# TODO: A bit better visuals, sounds or smth
	LevelSwitcher.switch_to_main_from_terminal()

	return "Disabling simulation..."
