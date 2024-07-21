extends HBoxContainer
class_name InteractionBox

@onready var label: Label = $Label

var tween: Tween


func _ready() -> void:
	modulate.a = 0.0


func show_interaction(action_name: String) -> void:
	label.text = action_name
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.2)


func hide_interaction() -> void:
	if tween != null:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.2)

