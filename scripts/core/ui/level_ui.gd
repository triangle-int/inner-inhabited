extends Node

@export var level: Level
@export var allowed_nodes: Array[PackedScene]
@export var buttons_root: Node
@export var sequence_label: Label

@export var hint: String
@export var hint_label: Label


func _ready() -> void:
	hint_label.text = hint

	for node in allowed_nodes:
		var instance := node.instantiate()
		buttons_root.add_child(instance)

	_on_sequence_updated()
	level.sequence_updated.connect(_on_sequence_updated)


func _on_start_button_pressed() -> void:
	level.start_simulation()


func _on_stop_button_pressed() -> void:
	level.stop_simulation()


func _on_sequence_updated() -> void:
	sequence_label.text = ", ".join(
		level.get_current_sequence().map(func(num: int) -> String: return str(num))
	)


func _on_exit_button_pressed() -> void:
	level.finish_level(Level.SolutionStatus.NOT_SOLVED)
