class_name InputLine
extends Node

@onready var _input_label: Label = $Input


func add_text(new_text: String) -> void:
	_input_label.text += new_text


func backspace() -> void:
	var text := _input_label.text.substr(0, _input_label.text.length() - 1)
	_input_label.text = text


func get_text() -> String:
	return _input_label.text
