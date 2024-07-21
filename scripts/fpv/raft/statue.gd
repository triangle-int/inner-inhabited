extends StaticBody3D

@export var hide_duration: float

@onready var spot_light_3d: SpotLight3D = $Node3D/SpotLight3D
@onready var spot_light_3d_2: SpotLight3D = $Node3D/SpotLight3D2
@onready var omni_light_3d: OmniLight3D = $Node3D/OmniLight3D


func hide_and_remove() -> Signal:
	var tween := create_tween()
	tween.tween_property(spot_light_3d, "light_energy", 0.0, hide_duration)
	tween.parallel().tween_property(spot_light_3d_2, "light_energy", 0.0, hide_duration)
	tween.parallel().tween_property(omni_light_3d, "light_energy", 0.0, hide_duration)
	tween.tween_callback(func() -> void: queue_free())
	return tween.finished
