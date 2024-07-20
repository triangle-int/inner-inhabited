extends Area2D
class_name Dragable

signal drag_stopped

var _is_dragging: bool

@onready var selection: Sprite2D = $Selection


func _input(event: InputEvent) -> void:
	if event.is_action_released("drag_node"):
		_is_dragging = false
	
	if event.is_action_pressed("delete_node") and NodeInteraction.is_selected(self):
		if not Level.current.is_simulating:
			(get_parent() as BaseSignalNode).destroy()
		# TODO: Instead stop simulation
	
	if event is InputEventMouseMotion:
		if _is_dragging and NodeInteraction.is_selected(self):
			get_parent().position += event.relative


func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("drag_node"):
		if Level.current.is_simulating:
			return
		_is_dragging = true
		NodeInteraction.select(self)
		viewport.set_input_as_handled()
	elif event.is_action_released("drag_node"):
		_is_dragging = false
		drag_stopped.emit()
		viewport.set_input_as_handled()


func select() -> void:
	selection.visible = true


func deselect() -> void:
	selection.visible = false
