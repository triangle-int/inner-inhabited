class_name Terminal
extends Control

@export var input_line_scene: PackedScene
@export var response_line_scene: PackedScene
@export var commands: Array[BaseTerminalCommand]
@export var switch_sound := true

@onready var lines_container := $ScrollContainer/MarginContainer/LinesContainer
@onready var scroll_container: TerminalScroll = $ScrollContainer
@onready var level_container := $LevelContainer

var _last_input_line: InputLine
var _is_level_playing: bool


func _ready() -> void:
	if switch_sound:
		AudioPlayer.switch_to_terminal()

	_next_input_line()


func _on_command_sent(command: String) -> void:
	var possible_commands := commands.filter(
		func(cmd: BaseTerminalCommand) -> bool: return cmd.matches_command(command)
	)
	var response := "Unknown command"

	if possible_commands.size() == 1:
		response = possible_commands.front().execute(command, self)

	_add_response_line(response)
	_next_input_line()
	scroll_container.follow = true


func _next_input_line() -> void:
	if _last_input_line:
		_last_input_line.command_sent.disconnect(_on_command_sent)
	_last_input_line = input_line_scene.instantiate()
	lines_container.add_child(_last_input_line)
	_last_input_line.command_sent.connect(_on_command_sent)


func clear() -> void:
	_last_input_line = null

	for child in lines_container.get_children():
		child.queue_free()


func attach_level(level: Level) -> void:
	level_container.add_child(level)
	_is_level_playing = true
	scroll_container.visible = false

	level.level_solved.connect(_on_level_finished)


func print(text: String) -> void:
	if _last_input_line != null:
		_last_input_line.queue_free()
		_last_input_line = null

	_add_response_line(text)
	_next_input_line()


func _on_level_finished(_status: Level.SolutionStatus) -> void:
	# TODO: Proper level finish logic
	_is_level_playing = false
	scroll_container.visible = true
	level_container.get_children().front().queue_free()


func _add_response_line(text: String) -> void:
	var line := response_line_scene.instantiate() as ResponseLine
	lines_container.add_child(line)
	line.set_response_text(text)
