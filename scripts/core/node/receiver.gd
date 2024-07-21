class_name SignalReceiver
extends BaseSignalNode

@export var hint := ""


func _ready() -> void:
	$Label.text = hint


func _receive_signal(_signal_info: SignalInfo) -> void:
	self.signal_consumed.emit()
