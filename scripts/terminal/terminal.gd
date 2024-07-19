extends Node2D

@export var input_line_scene: PackedScene
@export var response_line_scene: PackedScene

@onready var lines_container = $MarginContainer/LinesContainer

var last_input_line: InputLine


func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ENTER:
			next_line()
		var new_symbol: String = OS.get_keycode_string(event.key_label)
		last_input_line.add_text(new_symbol)


func next_line() -> void:
	pass
