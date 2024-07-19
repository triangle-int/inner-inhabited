extends Button

@export var target_plan: PackedScene


func _on_pressed() -> void:
	if Level.current.is_simulating:
		return

	var node := target_plan.instantiate() as Node2D
	node.position = get_global_mouse_position()
	Level.current.add_child(node)
