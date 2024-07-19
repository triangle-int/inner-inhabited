extends Node

@export var allowed_nodes: Array[PackedScene]
@export var buttons_root: Node


func _ready() -> void:
	for node in allowed_nodes:
		var instance := node.instantiate()
		buttons_root.add_child(instance)
