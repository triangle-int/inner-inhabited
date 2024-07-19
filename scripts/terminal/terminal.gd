extends Control

@export var input_line_scene: PackedScene
@export var response_line_scene: PackedScene
@export var commands: Array[BaseTerminalCommand]

@onready var lines_container := $MarginContainer/LinesContainer

var _last_input_line: InputLine


func _ready() -> void:
	next_input_line()


func _unhandled_key_input(event: InputEvent) -> void:
	if not (event is InputEventKey):
		return

	if event.is_released():
		return

	if event.keycode == KEY_ENTER:
		var string := _last_input_line.get_text()
		var possible_commands := commands.filter(
			func(command: BaseTerminalCommand) -> bool: return command.matches_command(string)
		)
		var response := "Unknown command"

		if possible_commands.size() == 1:
			response = possible_commands.front().execute(string)

		var line := response_line_scene.instantiate() as ResponseLine
		lines_container.add_child(line)
		line.set_response_text(response)

		next_input_line()
		return

	if event.keycode == KEY_BACKSPACE or event.keycode == KEY_DELETE:
		_last_input_line.backspace()

	if event.keycode == KEY_SPACE:
		_last_input_line.add_text(" ")

	var new_symbol := OS.get_keycode_string(event.key_label)

	if new_symbol.length() > 1:
		return

	_last_input_line.add_text(new_symbol)


func next_input_line() -> void:
	_last_input_line = input_line_scene.instantiate()
	lines_container.add_child(_last_input_line)
