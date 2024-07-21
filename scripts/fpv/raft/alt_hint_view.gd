extends Node

@onready var label: Label3D = $"."


func _ready() -> void:
	var hint: AltLevel = PlayerProgress.first_non_solved_alt_level()

	if hint == null:
		label.text = ""
		return

	label.text = "%s" % hint.message
