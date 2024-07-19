class_name SignalReceiver
extends BaseSignalNode

enum SolutionStatus { NOT_SOLVED, ALTERNATIVELY_SOLVED, NORMALLY_SOLVED }

signal signal_received

@export var normal_validator: BaseValidator
@export var alternative_validator: BaseValidator

var _received_signals: Array[SignalInfo]


func _receive_signal(_signal_info: SignalInfo) -> void:
	_received_signals.push_back(_signal_info)
	signal_received.emit()


func get_solution_status() -> SolutionStatus:
	if alternative_validator != null and alternative_validator.is_valid(_received_signals):
		return SolutionStatus.ALTERNATIVELY_SOLVED

	if normal_validator.is_valid(_received_signals):
		return SolutionStatus.NORMALLY_SOLVED

	return SolutionStatus.NOT_SOLVED


func _reset() -> void:
	super._reset()
	_received_signals.clear()
