class_name Level
extends Node

enum SolutionStatus { NOT_SOLVED, ALTERNATIVELY_SOLVED, NORMALLY_SOLVED }

signal finished(status: Level.SolutionStatus)

@export var sequence: Array[SignalInfo]
@export var root: BaseSignalNode

@export var normal_goal: BaseLevelGoal
@export var alt_goal: BaseLevelGoal

static var current: Level = null

var is_simulating: bool

var _signals_received: int = 0


func _ready() -> void:
	current = self


func _exit_tree() -> void:
	current = null


func _on_signal_consumed() -> void:
	_signals_received += 1

	if _signals_received < sequence.size():
		_send_next()
		return

	print("not solved")
	stop_simulation()
	finished.emit(SolutionStatus.NOT_SOLVED)


func _check_goals() -> void:
	if alt_goal != null and alt_goal.is_achieved(self):
		print("solved alternatively")
		finished.emit(SolutionStatus.ALTERNATIVELY_SOLVED)
		return

	if normal_goal.is_achieved(self):
		print("solved normally")
		finished.emit(SolutionStatus.NORMALLY_SOLVED)
		return


func start_simulation() -> void:
	if is_simulating:
		return

	for child in get_children():
		var node := child as BaseSignalNode

		if node == null:
			continue

		node.signal_consumed.connect(_on_signal_consumed)
		node.signal_received.connect(_check_goals)

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

		node.signal_consumed.disconnect(_on_signal_consumed)
		node.signal_received.disconnect(_check_goals)
		node.reset()


func _send_next() -> void:
	root.receive_signal(sequence[_signals_received])
