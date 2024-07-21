class_name VolumeCommand
extends BaseTerminalCommand


func _matches_command(string: String) -> bool:
	var words := string.split(" ", false)
	return words.size() == 2 and words[0] == "VOL"


func _execute(command: String, _term: Terminal) -> String:
	var volume_str: String = command.split(" ", false)[1]

	if not volume_str.is_valid_int():
		return "Second argument should be an integer."

	var volume := volume_str.to_int()

	if volume < 0 or volume > 100:
		return "Volume should be in range from 0 to 100."

	AudioPlayer.set_volume(volume / 100.)
	return "Setting volume..."
