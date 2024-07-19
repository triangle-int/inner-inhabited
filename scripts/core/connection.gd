class_name Connection
extends Line2D

var source: BaseSignalNode
var target: BaseSignalNode


func start_connection(new_source: BaseSignalNode) -> void:
	source = new_source
	add_point(Vector2.ZERO)
	add_point(Vector2.ZERO)


func end_connection(new_target: BaseSignalNode) -> void:
	if source.connections.any(func(conn: Connection) -> bool: return conn.target == new_target):
		return

	target = new_target
	source.connections.push_back(self)
	ConnectionHolder.current = null


func _process(_delta: float) -> void:
	if target == null:
		set_point_position(1, get_global_mouse_position() - source.position)
	else:
		set_point_position(1, target.global_position - source.global_position)
