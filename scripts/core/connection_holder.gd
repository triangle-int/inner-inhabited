class_name ConnectionHolder
extends Area2D

@export var line: PackedScene

var _mouse_over: bool

static var current: Connection


func _ready() -> void:
	mouse_entered.connect(func() -> void: _mouse_over = true)
	mouse_exited.connect(func() -> void: _mouse_over = false)


func _process(_delta: float) -> void:
	if not _mouse_over or not Input.is_action_just_pressed("connect_nodes"):
		return

	if current != null:
		if current.source == self:
			return

		current.end_connection(get_parent())
		return

	var parent := get_parent() as BaseSignalNode

	if parent.connections.size() >= parent.connection_limit:
		return

	current = line.instantiate() as Connection
	current.start_connection(parent)
	add_child(current)
