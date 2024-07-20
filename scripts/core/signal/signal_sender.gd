extends Node

@export var signal_scene: PackedScene
@export var signal_speed: float

var tweens: Array[Tween]
var views: Array[SignalView]


func send_signal(start_pos: Vector2, target: BaseSignalNode, signal_info: SignalInfo) -> void:
	var distance := (target.position - start_pos).length()
	var time := distance / signal_speed

	var signal_view := signal_scene.instantiate() as SignalView
	signal_view.load_signal(signal_info)
	signal_view.position = start_pos
	Level.current.add_child(signal_view)

	var tween := get_tree().create_tween()
	tween.tween_property(signal_view, "position", target.position, time)

	tweens.push_back(tween)
	views.push_back(signal_view)

	await tween.finished
	target.receive_signal(signal_info)
	signal_view.queue_free()

	tweens.erase(tween)
	views.erase(signal_view)


func stop_all_signals() -> void:
	for tween in tweens:
		tween.stop()

	for view in views:
		view.queue_free()

	tweens.clear()
	views.clear()
