class_name SignalNodePlan
extends Node2D

@export var target_node: PackedScene


func _process(_delta: float) -> void:
	if not Input.is_action_just_pressed("drag_node"):
		return

	var node := target_node.instantiate() as Node2D
	node.position = position
	Level.current.add_child(node)
	queue_free()


func _input(event: InputEvent) -> void:
	var mouse_event := event as InputEventMouseMotion

	if mouse_event == null:
		return

	position += mouse_event.relative
