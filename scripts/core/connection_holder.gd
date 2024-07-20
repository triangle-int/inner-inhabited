extends Area2D
class_name ConnectionHandler

@export var line: PackedScene

var is_dragging := false

static var overlapping_handlers: Array[BaseSignalNode]


func _mouse_enter() -> void:
	overlapping_handlers.append(get_parent())


func _mouse_exit() -> void:
	overlapping_handlers.erase(get_parent())


func _input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Level.current.is_simulating:
		return
	
	if event.is_action_pressed("connect_nodes"):
		var conn := line.instantiate() as Connection
		add_child(conn)
		conn.start_connection(get_parent())
		return


func _exit_tree() -> void:
	overlapping_handlers.erase(get_parent())
