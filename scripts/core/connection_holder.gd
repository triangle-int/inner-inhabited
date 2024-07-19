extends Area2D

@export var line: PackedScene

var _mouse_over: bool


func _ready() -> void:
	mouse_entered.connect(func() -> void: _mouse_over = true)
	mouse_exited.connect(func() -> void: _mouse_over = false)


func _process(_delta: float) -> void:
	if not _mouse_over or not Input.is_action_just_pressed("connect_nodes"):
		return

	if Connection.current == null:
		var conn := line.instantiate() as Connection
		add_child(conn)
		conn.start_connection(get_parent())
		return

	if Connection.current.source == self:
		return

	Connection.current.end_connection(get_parent())
