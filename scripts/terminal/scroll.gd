class_name TerminalScroll
extends ScrollContainer

var follow := true


func _process(_delta: float) -> void:
	if follow:
		scroll_vertical = ceil(get_v_scroll_bar().max_value)


func _input(input_event: InputEvent) -> void:
	var event := input_event as InputEventMouseButton

	if event == null or event.button_index != MOUSE_BUTTON_WHEEL_UP or event.is_released():
		return

	follow = false
