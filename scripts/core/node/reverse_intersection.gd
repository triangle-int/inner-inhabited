extends IntersectionNode


func sort_outgoing_connections() -> void:
	outgoing_connections.sort_custom(
		func(a: Connection, b: Connection) -> bool: return a.target.position.x > b.target.position.x
	)


func _on_drag_stopped() -> void:
	_sort_in_incoming()
