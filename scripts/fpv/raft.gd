extends Node3D

@onready var hitbox: Area3D = $Area3D
@onready var player: Node3D = $"../Player"


func _process(delta: float) -> void:
	var overlapping_bodies := hitbox.get_overlapping_bodies()
	for body in overlapping_bodies:
		if body is Player:
			body.attach_to_raft(self)
