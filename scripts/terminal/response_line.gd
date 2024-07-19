class_name ResponseLine
extends Node

@onready var _response_label: Label = $Response


func set_response_text(response_text: String) -> void:
	_response_label.text = response_text
