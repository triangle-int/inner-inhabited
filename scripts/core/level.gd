class_name Level
extends Node

enum SolutionStatus { ALTERNATIVELY_SOLVED, NORMALLY_SOLVED }

signal level_solved(status: Level.SolutionStatus)
signal sequence_updated

@export var sequence: Array[SignalInfo]
@export var root: BaseSignalNode

@export var normal_goal: BaseLevelGoal
@export var alt_goal: BaseLevelGoal

static var current: Level = null

var is_simulating: bool
var level_id: String

var _signals_sent: int = 0


func _ready() -> void:
	current = self


func _exit_tree() -> void:
	current = null


func _on_signal_consumed() -> void:
	if _signals_sent < sequence.size():
		_send_next()
		return

	stop_simulation()


func _check_goals() -> void:
	if alt_goal != null and alt_goal.is_achieved(self):
		_finish_level(SolutionStatus.ALTERNATIVELY_SOLVED)
		return

	if normal_goal.is_achieved(self):
		_finish_level(SolutionStatus.NORMALLY_SOLVED)
		return


func _finish_level(status: Level.SolutionStatus) -> void:
	print("alt solved" if status == SolutionStatus.ALTERNATIVELY_SOLVED else "normal solved")
	stop_simulation()
	level_solved.emit(status)
	PlayerProgress.register_level_solution(level_id, status)


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
	_send_next()


func stop_simulation() -> void:
	if not is_simulating:
		return

	is_simulating = false
	_signals_sent = 0
	sequence_updated.emit()
	SignalSender.stop_all_signals()

	for child in get_children():
		var node := child as BaseSignalNode

		if node == null:
			continue

		node.signal_consumed.disconnect(_on_signal_consumed)
		node.signal_received.disconnect(_check_goals)
		node.reset()


func _send_next() -> void:
	root.receive_signal(sequence[_signals_sent])

	if not is_simulating:
		return

	_signals_sent += 1
	sequence_updated.emit()


func get_current_sequence() -> Array:
	return sequence.slice(_signals_sent).map(func(s: SignalInfo) -> int: return s.number)
