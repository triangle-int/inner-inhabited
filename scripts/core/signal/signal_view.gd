class_name SignalView
extends Node


@onready var label: Label = $Label


func load_signal(signal_info: SignalInfo) -> void:
	label.text = str(signal_info.number)
