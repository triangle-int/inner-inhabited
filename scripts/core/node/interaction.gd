extends Node

var _selected_node: Dragable


func select(node: Dragable) -> void:
	if _selected_node != null:
		_selected_node.deselect()
	_selected_node = node
	node.select()


func deselect() -> void:
	if _selected_node != null:
		_selected_node.deselect()
	_selected_node = null


func is_selected(node: Dragable) -> bool:
	return _selected_node == node


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drag_node"):
		deselect()
