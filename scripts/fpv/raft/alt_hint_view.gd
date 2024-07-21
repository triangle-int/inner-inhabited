extends Label3D

enum HintText {
	LEVEL_ID,
	LEVEL_HINT
}

@export var text_type: HintText


func _ready() -> void:
	var hint: AltLevel = PlayerProgress.first_non_solved_alt_level()

	if hint == null:
		text = ""
		return
	
	if text_type == HintText.LEVEL_ID:
		text = hint.level_id
	elif text_type == HintText.LEVEL_HINT:
		text = hint.message
