class_name Level
extends Node

enum SolutionStatus { NOT_SOLVED, ALTERNATIVELY_SOLVED, NORMALLY_SOLVED }

signal finished(status: Level.SolutionStatus)

@export var sequence: Array[SignalInfo]
@export var receivers: Array[SignalReceiver]
@export var root: BaseSignalNode

static var current: Level = null

var is_simulating: bool

var _signals_received: int = 0


func _ready() -> void:
	current = self

	for receiver in receivers:
		receiver.signal_received.connect(_on_signal_reached_endpoint)


func _exit_tree() -> void:
	current = null


func _on_signal_reached_endpoint() -> void:
	_signals_received += 1

	if _signals_received < sequence.size():
		_send_next()
		return

	var statuses := receivers.map(
		func(receiver: SignalReceiver) -> Level.SolutionStatus: return (
			receiver.get_solution_status()
		)
	)
	stop_simulation()

	if statuses.all(
		func(status: Level.SolutionStatus) -> bool: return (
			status == SolutionStatus.ALTERNATIVELY_SOLVED
		)
	):
		print("solved alternatively")
		finished.emit(SolutionStatus.ALTERNATIVELY_SOLVED)
		return

	if statuses.all(
		func(status: Level.SolutionStatus) -> bool: return status == SolutionStatus.NORMALLY_SOLVED
	):
		print("solved normally")
		finished.emit(SolutionStatus.NORMALLY_SOLVED)
		return

	print("not solved")
	finished.emit(SolutionStatus.NOT_SOLVED)


func start_simulation() -> void:
	if is_simulating:
		return

	NodeInteraction.deselect()

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
