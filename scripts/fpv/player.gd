class_name Player
extends CharacterBody3D

signal entered_raft
signal can_interact

@export var movement_speed := 5.0
@export var stop_duration := 0.2
@export var rotation_speed := 0.005
@export var min_rotation_angle := -60.0
@export var max_rotation_angle := 60.0
@export var slide_time := 1.0

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var interaction_box: InteractionBox = $HUD/InteractionBox

var on_raft := false
var can_move := true

var interactable_object: Node


func _ready() -> void:
	LevelSwitcher.rotate_to_match_old(self)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and can_move:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event.is_action_pressed("interact") and interactable_object != null:
		interactable_object.interact(self)

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion \
		and can_move:
		rotate_y(-event.relative.x * rotation_speed)
		head.rotation.x = clamp(
			head.rotation.x - event.relative.y * rotation_speed,
			deg_to_rad(min_rotation_angle),
			deg_to_rad(max_rotation_angle)
		)


func _physics_process(delta: float) -> void:
	if on_raft:
		return

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * movement_speed
		velocity.z = direction.z * movement_speed
	else:
		var horizontal_velocity := Vector3(velocity.x, 0, velocity.z)
		var new_horizontal_velocity := horizontal_velocity.move_toward(
			Vector3.ZERO, (movement_speed / stop_duration) * delta
		)
		velocity.x = new_horizontal_velocity.x
		velocity.z = new_horizontal_velocity.z

	if can_move:
		move_and_slide()


func attach_to_raft(raft: Node3D) -> void:
	on_raft = true
	var final_position := Vector3(raft.global_position.x, position.y, raft.global_position.z)

	var tween := create_tween()
	tween.tween_property(self, "global_position", final_position, slide_time)

	await tween.finished
	entered_raft.emit()


func is_moving() -> bool:
	return can_move and velocity.length_squared() > 0 


func enable_interaction(text: String, object: Node) -> void:
	interaction_box.show_interaction(text)
	interactable_object = object
	can_interact.emit()


func disable_interaction() -> void:
	interaction_box.hide_interaction()
	interactable_object = null
