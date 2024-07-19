class_name Terminal
extends Control

@export var input_line_scene: PackedScene
@export var response_line_scene: PackedScene
@export var commands: Array[BaseTerminalCommand]

@onready var lines_container := $MarginContainer/LinesContainer
@onready var level_container := $LevelContainer

var _last_input_line: InputLine
var _is_level_playing: bool


func _ready() -> void:
	clear()
	_next_input_line()


func _unhandled_key_input(event: InputEvent) -> void:
	if _is_level_playing:
		return

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
			response = possible_commands.front().execute(string, self)

		var line := response_line_scene.instantiate() as ResponseLine
		lines_container.add_child(line)
		line.set_response_text(response)

		_next_input_line()
		return

	if event.keycode == KEY_BACKSPACE or event.keycode == KEY_DELETE:
		_last_input_line.backspace()

	if event.keycode == KEY_SPACE:
		_last_input_line.add_text(" ")

	var new_symbol := OS.get_keycode_string(event.key_label)

	if new_symbol.length() > 1:
		return

	_last_input_line.add_text(new_symbol)


func _next_input_line() -> void:
	_last_input_line = input_line_scene.instantiate()
	lines_container.add_child(_last_input_line)


func clear() -> void:
	_last_input_line = null

	for child in lines_container.get_children():
		child.queue_free()


func attach_level(level: Level) -> void:
	level_container.add_child(level)
	_is_level_playing = true

	level.finished.connect(func(_status: Level.SolutionStatus) -> void:
		push_warning("proper level finish not implemented")
		_is_level_playing = false
		level_container.get_children().front().queue_free()
	)
