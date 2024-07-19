extends Node3D

@onready var hitbox: Area3D = $Area3D
@onready var player: Node3D = $"../Player"


func _process(delta: float) -> void:
	var overlapping_bodies := hitbox.get_overlapping_bodies()
	if player in overlapping_bodies:
		player.attach_to_raft(self)
