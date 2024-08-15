class_name InputLine
extends Node

signal command_sent

@onready var _input_line: LineEdit = $Input


func _ready() -> void:
	_input_line.grab_focus.call_deferred()


func _input(event: InputEvent) -> void:
	if not (event is InputEventKey):
		return

	if not event.is_pressed():
		return


func _on_input_text_changed(new_text: String) -> void:
	var caret_pos: int = _input_line.caret_column
	_input_line.text = new_text.to_upper()
	_input_line.caret_column = caret_pos


func _on_input_text_submitted(new_text: String) -> void:
	_input_line.editable = false
	command_sent.emit(new_text)
