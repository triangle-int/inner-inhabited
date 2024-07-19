class_name Connection
extends Line2D

var source: BaseSignalNode
var target: BaseSignalNode

static var current: Connection


func start_connection(new_source: BaseSignalNode) -> void:
	if new_source.outgoing_connections.size() >= new_source.connection_limit:
		queue_free()
		return

	current = self
	source = new_source

	add_point(Vector2.ZERO)
	add_point(Vector2.ZERO)


func end_connection(new_target: BaseSignalNode) -> void:
	if source.outgoing_connections.any(
		func(conn: Connection) -> bool: return conn.target == new_target
	):
		return

	current = null
	target = new_target
	source.outgoing_connections.push_back(self)
	target.incoming_connections.push_back(self)


func _process(_delta: float) -> void:
	if target == null:
		set_point_position(1, get_global_mouse_position() - source.position)
	else:
		set_point_position(1, target.global_position - source.global_position)
