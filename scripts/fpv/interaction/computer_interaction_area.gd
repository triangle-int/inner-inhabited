extends Area3D

@onready var camera_exit_position: Node3D = $CameraExitPosition


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		body.enable_interaction("DOZE OFF", self)


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		body.disable_interaction()


func interact(player: Player) -> void:
	player.disable_interaction()
	print("interacting")
