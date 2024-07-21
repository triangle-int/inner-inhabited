extends Label

@onready var choice_button: BaseButton = $"../ChoiceButton"


func _ready() -> void:
	choice_button.visibility_changed.connect(func() -> void: visible = choice_button.visible)
