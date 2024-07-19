extends Area2D

var _mouse_over: bool
var _is_dragged: bool


func _ready() -> void:
	mouse_entered.connect(func() -> void: _mouse_over = true)
	mouse_exited.connect(func() -> void: _mouse_over = false)


func _process(_delta: float) -> void:
	if Level.current.is_simulating:
		return

	if _mouse_over and Input.is_action_just_pressed("drag_node"):
		_is_dragged = true

	if Input.is_action_just_released("drag_node"):
		_is_dragged = false

	if _mouse_over and Input.is_action_pressed("delete_node"):
		(get_parent() as BaseSignalNode).destroy()


func _input(event: InputEvent) -> void:
	var mouse_event := event as InputEventMouseMotion

	if not _is_dragged or mouse_event == null or not Input.is_action_pressed("drag_node"):
		return

	get_parent().position += mouse_event.relative
