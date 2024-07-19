class_name Connection
extends Line2D

@export var area: Area2D
@export var shape: CollisionShape2D

var source: BaseSignalNode
var target: BaseSignalNode

static var current: Connection

var _mouse_over: bool


func _ready() -> void:
	area.mouse_entered.connect(func() -> void: _mouse_over = true)
	area.mouse_exited.connect(func() -> void: _mouse_over = false)


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
	var end := (
		(get_global_mouse_position() - source.position)
		if target == null
		else target.global_position - source.global_position
	)

	set_point_position(1, end)
	shape.position = end / 2
	shape.rotation = atan2(end.y, end.x)
	(shape.shape as RectangleShape2D).size.x = end.length()

	if !Level.current.is_simulating and _mouse_over and Input.is_action_pressed("delete_node"):
		_destroy()


func _destroy() -> void:
	source.outgoing_connections.erase(self)
	target.incoming_connections.erase(self)
	queue_free()
