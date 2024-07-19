class_name Level
extends Node

signal finished(solved: bool)

@export var sequence: Array[SignalInfo]
@export var receivers: Array[BaseSignalReceiver]
@export var root: BaseSignalNode

static var current: Level = null

var is_simulating: bool

var _signals_received: int = 0


func _ready() -> void:
	current = self

	for receiver in receivers:
		receiver.signal_received.connect(_on_signal_reached_endpoint)


func _on_signal_reached_endpoint() -> void:
	_signals_received += 1

	if _signals_received < sequence.size():
		_send_next()
		return

	var solved := receivers.all(
		func(receiver: BaseSignalReceiver) -> bool: return receiver.is_correct()
	)
	print("solved" if solved else "not solved")
	stop_simulation()
	finished.emit(solved)


func start_simulation() -> void:
	if is_simulating:
		return

	is_simulating = true
	_signals_received = 0
	_send_next()


func stop_simulation() -> void:
	is_simulating = false
	SignalSender.stop_all_signals()

	for child in get_children():
		var node := child as BaseSignalNode

		if node == null:
			continue

		node.reset()


func _send_next() -> void:
	root.receive_signal(sequence[_signals_received])
