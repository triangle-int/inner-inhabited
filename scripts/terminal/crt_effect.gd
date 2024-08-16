extends ColorRect


func _ready() -> void:
	#if OS.has_feature("web_macos"):
		#print("Disabling screen effect, because of MacOS screen texture bug")
		#visible = false
	
	if PlayerProgress.showed_terminal_effect:
		material.set_shader_parameter("intensity", 1.0)
	else: 
		material.set_shader_parameter("intensity", 0.0)
	LevelSwitcher.transition_from_terminal.connect(animate)


func animate() -> void:
	if PlayerProgress.showed_terminal_effect:
		return
	var tween := create_tween()
	tween.tween_method(set_shader_value, 0.0, 1.0, 3.0)
	tween.tween_callback(func() -> void: PlayerProgress.showed_terminal_effect = true)


func set_shader_value(value: float) -> void:
	material.set_shader_parameter("intensity", value)
