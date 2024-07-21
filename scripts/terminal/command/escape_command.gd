extends BaseTerminalCommand
class_name EscapeCommand

@export var delay: float


func _matches_command(string: String) -> bool:
	return string == "ESC"


func _execute(_command: String, terminal: Terminal) -> String:
	# TODO: A bit better visuals, sounds or smth
	terminal.get_tree().create_timer(delay).timeout.connect(
		func() -> void: LevelSwitcher.switch_to_main_from_terminal()
	)
	PlayerProgress.escaped_terminal = true

	return "Disabling simulation..."
