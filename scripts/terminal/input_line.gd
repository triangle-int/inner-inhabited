extends Node
class_name InputLine

@onready var input_label: Label = $Input


func add_text(new_text: String) -> void:
	input_label.text += new_text
