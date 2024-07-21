class_name SignalReceiver
extends BaseSignalNode

signal signal_received

@export var normal_validator: BaseValidator
@export var alternative_validator: BaseValidator

@export var hint := ""

var _received_signals: Array[SignalInfo]


func _ready() -> void:
	$Label.text = hint


func _receive_signal(_signal_info: SignalInfo) -> void:
	_received_signals.push_back(_signal_info)
	signal_received.emit()


func get_solution_status() -> Level.SolutionStatus:
	if alternative_validator != null and alternative_validator.is_valid(_received_signals):
		return Level.SolutionStatus.ALTERNATIVELY_SOLVED

	if normal_validator.is_valid(_received_signals):
		return Level.SolutionStatus.NORMALLY_SOLVED

	return Level.SolutionStatus.NOT_SOLVED


func _reset() -> void:
	super._reset()
	_received_signals.clear()
