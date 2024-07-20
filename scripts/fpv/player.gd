class_name Player

extends CharacterBody3D

@export var movement_speed := 5.0
@export var rotation_speed := 0.005
@export var min_rotation_angle := -60.0
@export var max_rotation_angle := 60.0
@export var on_raft := false
@export var slide_time := 1.0

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		rotate_y(-event.relative.x * rotation_speed)
		head.rotate_x(-event.relative.y * rotation_speed)
		head.rotation.x = clamp(
			head.rotation.x, deg_to_rad(min_rotation_angle), deg_to_rad(max_rotation_angle)
		)


func _physics_process(delta: float) -> void:
	if on_raft == true:
		return
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	velocity.x = direction.x * movement_speed
	velocity.z = direction.z * movement_speed
	move_and_slide()


func attach_to_raft(raft: Node3D) -> void:
	on_raft = true
	var tween := create_tween()
	var final_position := Vector3(raft.position.x, position.y, raft.position.z)
	tween.tween_property(self, "position", final_position, slide_time)


func is_moving() -> bool:
	return velocity.length_squared() > 0
