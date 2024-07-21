extends Node

@export var player: AudioStreamPlayer
@export var terminal_before_escape: AudioStream
@export var terminal_after_escape: AudioStream
@export var outside: AudioStream


func switch_to_outside() -> void:
	_switch_to_stream(outside)


func switch_to_terminal() -> void:
	_switch_to_stream(
		terminal_after_escape if PlayerProgress.escaped_terminal else terminal_before_escape
	)


func _switch_to_stream(stream: AudioStream) -> void:
	player.stop()
	player.stream = stream
	player.play()


func set_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(volume))
