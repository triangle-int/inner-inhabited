extends Node

@onready var response_label: Label = $Response


func set_response_text(response_text: String) -> void:
	response_label.text = response_text
