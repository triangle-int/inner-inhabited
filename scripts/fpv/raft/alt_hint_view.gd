extends Node

@export var alt_hints: Array[AltHint]

@onready var label: Label3D = $"."


func _ready() -> void:
	var possible_hints := alt_hints.filter(
		func(hint: AltHint) -> bool: return not PlayerProgress.alt_passed_levels_ids.has(
			hint.level_id
		)
	)

	if possible_hints == null:
		push_warning("All levels already solved alternatively! Hint shouldn't have been shown!")
		return

	var first_hint: AltHint = possible_hints.front()
	label.text = "L%s:\n%s" % [first_hint.level_id, first_hint.message]
